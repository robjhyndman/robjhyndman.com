# Writes `details`, `doi` and `author` into each publication's front matter
# from its rjhpubs.bib entry. This has to happen by editing the actual file,
# before Quarto ever runs, because Quarto's `listing:` feature (which builds
# publications/index.qmd) reads each file's raw YAML front matter directly
# -- it doesn't run computations, execute code, or apply Lua filters, so a
# field that only ever existed as a value computed at render time would
# never reach the listing page, and Quarto resolves the browser-tab <title>
# and "Authors" byline from the raw front-matter YAML before any Lua filter
# gets a chance to touch it either way.
#
# details/doi are only ever filled in when missing, never overwritten, since
# a file with neither is the normal state for a working paper (see
# title-metadata.html's "Working paper" fallback). author is different: it's
# always present already, and always meant to match the bib exactly (unlike
# title, which sometimes has a deliberate, permanent override -- see
# TITLE_EXCEPTIONS in check_bib_sync.R), so author is unconditionally
# regenerated from the bib every run, overwriting whatever was there.
#
# rjhpubs.bib stays the source of truth throughout: this script never
# invents anything not already in the bib entry, and running it again after
# a bib update just re-syncs whatever changed.
#
# Usage: Rscript sync_bib_fields.R (run by `make preview` / `make build`,
# after fetch_bib.R and before quarto render/preview)

library(stringr)

# ---- bib parsing (same approach as check_bib_sync.R) -------------------

extract_braced <- function(text, pos) {
  n <- nchar(text)
  depth <- 0L
  start <- pos
  j <- pos
  while (j <= n) {
    c <- substr(text, j, j)
    if (c == "{") depth <- depth + 1L
    else if (c == "}") {
      depth <- depth - 1L
      if (depth == 0L) return(list(value = substr(text, start + 1L, j - 1L), after = j + 1L))
    }
    j <- j + 1L
  }
  list(value = substr(text, start + 1L, n), after = n + 1L)
}

parse_fields <- function(raw) {
  fields <- list()
  pos <- 1L
  n <- nchar(raw)
  repeat {
    m <- regexpr("[[:alpha:]][[:alnum:]-]*[[:space:]]*=[[:space:]]*", substr(raw, pos, n), perl = TRUE)
    if (m == -1L) break
    name <- str_extract(regmatches(substr(raw, pos, n), m), "^[[:alpha:]][[:alnum:]-]*")
    field_start <- pos + m - 1L
    val_start <- field_start + attr(m, "match.length")
    if (substr(raw, val_start, val_start) == "{") {
      res <- extract_braced(raw, val_start)
      fields[[tolower(name)]] <- res$value
      pos <- res$after
    } else {
      rest <- substr(raw, val_start, n)
      vm <- regexpr("[^,\n}]+", rest, perl = TRUE)
      if (vm == -1L) break
      fields[[tolower(name)]] <- str_trim(regmatches(rest, vm))
      pos <- val_start + vm + attr(vm, "match.length") - 1L
    }
  }
  fields
}

parse_bib <- function(path) {
  text <- paste(readLines(path, warn = FALSE), collapse = "\n")
  starts <- gregexpr("(?m)^@[[:alpha:]]+\\{", text, perl = TRUE)[[1]]
  ends <- c(starts[-1] - 1L, nchar(text))
  entries <- list()
  for (i in seq_along(starts)) {
    chunk <- substr(text, starts[i], ends[i])
    type <- str_match(chunk, "^@([[:alpha:]]+)\\{")[, 2]
    key <- str_match(chunk, "^@[[:alpha:]]+\\{\\s*([^,]+),")[, 2]
    if (is.na(key)) next
    key <- str_trim(key)
    body <- sub("^@[[:alpha:]]+\\{[^,]+,", "", chunk)
    f <- parse_fields(body)
    f$.type <- tolower(type)
    entries[[key]] <- f
  }
  entries
}

# ---- details formatting (mirrors publications/inject-bibtex.lua) -------

unescape_latex <- function(s) {
  s <- gsub("\\\\&", "&", s)
  s <- gsub("\\\\\\$", "$", s)
  s <- gsub("\\\\[a-zA-Z]+\\s*\\{([^}]*)\\}", "\\1", s)
  s <- gsub("[{}]", "", s)
  s <- gsub("~", " ", s) # LaTeX tie (non-breaking space), e.g. "Ben~Taieb"
  s
}

# "A and B and C" -> "A, B, C" -- the site's own convention: every author
# field already in the corpus separates every name with a comma, including
# the last one (no "and"), regardless of how many authors there are. Also
# reorders any name the bib wrote as BibTeX's alternate "Last, First" form
# (a couple of entries do) back to "First Last", same as check_bib_sync.R's
# split_bib_authors() does for its comparison.
format_authors <- function(raw) {
  names <- str_split(unescape_latex(raw), "\\s+and\\s+")[[1]]
  names <- vapply(names, function(p) {
    p <- str_trim(p)
    m <- str_match(p, "^([^,]+),\\s*(.+)$")
    if (!is.na(m[1, 1])) p <- paste(m[1, 3], m[1, 2])
    p
  }, character(1), USE.NAMES = FALSE)
  paste(names, collapse = ", ")
}

format_pages <- function(pages) gsub("(\\d)-{1,2}(\\d)", "\\1\u2013\\2", pages)
is_page_range <- function(pages) grepl("[-\u2013]", pages)

format_editors <- function(raw) {
  names <- str_split(unescape_latex(raw), "\\s+and\\s+")[[1]]
  n <- length(names)
  label <- if (n == 1) "ed." else "eds."
  joined <- if (n <= 2) paste(names, collapse = " and ") else paste0(paste(names[1:(n - 1)], collapse = ", "), " and ", names[n])
  paste(label, joined)
}

build_journal_details <- function(e) {
  journal <- e$journal
  if (is.null(journal)) return(NULL)
  journal <- unescape_latex(journal)
  out <- paste0("<em>", journal, "</em>")
  if (!is.null(e$volume)) {
    out <- paste0(out, " <b>", e$volume, "</b>")
    if (!is.null(e$number)) out <- paste0(out, "(", e$number, ")")
    if (!is.null(e$pages)) out <- paste0(out, ", ", format_pages(e$pages))
  } else if (!is.null(e$pages)) {
    out <- paste0(out, ", ", format_pages(e$pages))
  }
  out
}

build_chapter_details <- function(e) {
  booktitle <- e$booktitle
  if (is.null(booktitle)) return(NULL)
  booktitle <- str_replace(unescape_latex(booktitle), "\\.$", "")
  out <- paste0("<em>", booktitle, "</em>")
  if (!is.null(e$editor)) out <- paste0(out, ", ", format_editors(e$editor))
  if (!is.null(e$chapter)) out <- paste0(out, ", Chapter ", e$chapter)
  if (!is.null(e$pages)) {
    label <- if (is_page_range(e$pages)) "pp." else "p."
    out <- paste0(out, ", ", label, " ", format_pages(e$pages))
  }
  if (!is.null(e$publisher)) out <- paste0(out, ". ", unescape_latex(e$publisher))
  if (!is.null(e$address)) out <- paste0(out, ", ", unescape_latex(e$address))
  out
}

build_details <- function(e) {
  if (e$.type %in% c("article", "review")) build_journal_details(e)
  else if (e$.type %in% c("inbook", "incollection", "inproceedings")) build_chapter_details(e)
  else NULL
}

# ---- YAML front-matter editing ------------------------------------------

# Always double-quotes: generated text can contain a ": " sequence (e.g. a
# booktitle like "New Trends in Statistical Modelling: Proceedings..."),
# which is invalid as an unquoted YAML scalar.
yaml_quote <- function(value) {
  value <- gsub("\\\\", "\\\\\\\\", value)
  value <- gsub('"', '\\\\"', value)
  paste0('"', value, '"')
}

# Reads bibkey/details/doi out of the front matter without a full YAML
# parse, so this never trips over the free-form HTML in `details`.
read_simple_field <- function(fm_lines, field) {
  m <- str_match(fm_lines, paste0("^", field, ":\\s*(.*)$"))
  hit <- which(!is.na(m[, 1]))
  if (length(hit) == 0) return(NULL)
  str_trim(m[hit[1], 2])
}

# Finds the line span (within `lines`, index-based, inclusive) of an
# existing "field: value" entry, so it can be replaced in place -- handling
# a quoted value that wraps onto a following line, since continuation lines
# aren't reliably indented so can't be found by indentation alone.
locate_field <- function(lines, fm_start, fm_end, field) {
  idx <- NA_integer_
  for (i in (fm_start + 1):(fm_end - 1)) {
    if (grepl(paste0("^", field, ":"), lines[i])) {
      idx <- i
      break
    }
  }
  if (is.na(idx)) return(NULL)
  value <- str_trim(sub(paste0("^", field, ":"), "", lines[idx]))
  end <- idx
  if (nchar(value) >= 1 && substr(value, 1, 1) %in% c('"', "'")) {
    quote <- substr(value, 1, 1)
    closed <- nchar(value) > 1 && substr(value, nchar(value), nchar(value)) == quote
    if (!closed) {
      j <- idx + 1
      while (j <= fm_end - 1) {
        end <- j
        if (endsWith(lines[j], quote)) break
        j <- j + 1
      }
    }
  }
  list(start = idx, end = end)
}

sync_file <- function(path, bib) {
  lines <- readLines(path, warn = FALSE, encoding = "UTF-8")
  dashes <- which(lines == "---")
  if (length(dashes) < 2) return(FALSE)
  fm_lines <- lines[(dashes[1] + 1):(dashes[2] - 1)]

  bibkey <- read_simple_field(fm_lines, "bibkey")
  if (is.null(bibkey)) return(FALSE)
  e <- bib[[bibkey]]
  if (is.null(e)) return(FALSE)

  changed <- FALSE

  # author: unconditionally regenerated (see header comment for why).
  if (!is.null(e$author)) {
    generated_author <- paste0("author: ", format_authors(e$author))
    span <- locate_field(lines, dashes[1], dashes[2], "author")
    if (is.null(span)) {
      lines <- append(lines, generated_author, after = dashes[2] - 1)
      changed <- TRUE
    } else if (!(span$start == span$end && lines[span$start] == generated_author)) {
      lines <- append(lines[-(span$start:span$end)], generated_author, after = span$start - 1)
      changed <- TRUE
    }
  }

  # details/doi: only filled in when the file doesn't already set them.
  dashes <- which(lines == "---") # re-find: the author edit may have shifted line numbers
  fm_lines <- lines[(dashes[1] + 1):(dashes[2] - 1)]
  new_lines <- character(0)
  if (is.null(read_simple_field(fm_lines, "details"))) {
    details <- build_details(e)
    if (!is.null(details)) new_lines <- c(new_lines, paste0("details: ", yaml_quote(details)))
  }
  if (is.null(read_simple_field(fm_lines, "doi")) && !is.null(e$doi)) {
    new_lines <- c(new_lines, paste0("doi: ", str_trim(e$doi)))
  }
  if (length(new_lines) > 0) {
    lines <- append(lines, new_lines, after = dashes[2] - 1)
    changed <- TRUE
  }

  if (!changed) return(FALSE)
  writeLines(lines, path, useBytes = TRUE)
  TRUE
}

# ---- run over every publication -----------------------------------------

bib <- parse_bib("rjhpubs.bib")
files <- unique(c(
  Sys.glob("publications/*/index.md"), Sys.glob("publications/*/index.qmd"),
  Sys.glob("publications/*.md"), Sys.glob("publications/*.qmd")
))
files <- files[!grepl("_metadata", files)]

changed <- files[vapply(files, sync_file, logical(1), bib = bib)]
if (length(changed) == 0) {
  cat("sync_bib_fields: nothing to sync --", length(files), "publications already match rjhpubs.bib.\n")
} else {
  cat("sync_bib_fields: synced author/details/doi for", length(changed), "publication(s):\n")
  cat(paste(" -", changed), sep = "\n")
}
