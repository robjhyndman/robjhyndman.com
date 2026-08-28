# Writes `title`, `author`, `details` and `doi` into each publication's
# front matter from its rjhpubs.bib entry. This has to happen by editing the
# actual file, before Quarto ever runs, because Quarto's `listing:` feature
# (which builds publications/index.qmd) reads each file's raw YAML front
# matter directly -- it doesn't run computations, execute code, or apply Lua
# filters, so a field that only ever existed as a value computed at render
# time would never reach the listing page, and Quarto resolves the
# browser-tab <title> and "Authors" byline from the raw front-matter YAML
# before any Lua filter gets a chance to touch it either way.
#
# rjhpubs.bib is the single source of truth: every field this script writes
# is unconditionally regenerated from the bib and overwrites whatever was
# already in the file, even a deliberately hand-edited value (this includes
# the handful of book-review titles that check_bib_sync.R's TITLE_EXCEPTIONS
# used to let drift on purpose -- that list only governs what check_bib_sync
# flags, it no longer describes what this script leaves alone). A field is
# only left untouched when the bib entry itself doesn't have the underlying
# raw field (e.g. a working paper with no `doi` yet) -- this script never
# invents a value that isn't in the bib.
#
# Every bibkey in rjhpubs.bib is expected to map to exactly one publication
# file. If a publication file with that bibkey doesn't exist yet, one is
# created with whatever fields the bib entry provides. EXCLUDE_KEYS below
# lists bibkeys that deliberately have no publications/ page (books and
# sub-projects with their own dedicated page elsewhere on the site).
#
# Usage: Rscript sync_bib_fields.R (run by `make preview` / `make build`,
# after fetch_bib.R and before quarto render/preview)

library(stringr)

# bibkeys that intentionally have no publications/ page: books and
# sub-projects with a dedicated page elsewhere on the site.
EXCLUDE_KEYS <- c("expsmooth08", "fpp3", "fpppy", "ITSM91", "ITSM94", "MWH3", "unbelievable")

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

# ---- field formatting (mirrors publications/inject-bibtex.lua) ---------

unescape_latex <- function(s) {
  s <- gsub("``", '"', s, fixed = TRUE) # LaTeX open/close double-quote -> straight quote
  s <- gsub("''", '"', s, fixed = TRUE)
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
    gsub(" ", "\u00a0", p) # non-breaking within a name; ", " between authors stays breakable
  }, character(1), USE.NAMES = FALSE)
  paste(names, collapse = ", ")
}

# Bib titles use LaTeX "--" for an en-dash (e.g. a year range) and wrap
# words in extra braces purely to protect capitalisation (e.g. "{COVID-19}",
# "{Australia}") -- unescape_latex already strips those braces, this just
# also turns the literal double-hyphen into a real en-dash.
format_title <- function(raw) {
  s <- unescape_latex(raw)
  s <- gsub("--", "\u2013", s, fixed = TRUE)
  str_squish(s)
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

# Best-effort mapping from a BibTeX entry type to this site's `categories`
# values, used only when creating a brand-new publication file -- a few
# existing files deliberately recategorise a plain @article as "Editorials"
# or "Miscellaneous", which can't be inferred from the bib alone, so this is
# just a reasonable starting point the author can hand-adjust afterwards.
category_for_type <- function(type) {
  switch(type,
    article = "Articles",
    review = "Book reviews",
    inbook = ,
    incollection = "Book chapters",
    inproceedings = "Conference proceedings",
    phdthesis = "PhD thesis",
    techreport = ,
    unpublished = "Working papers",
    "Miscellaneous"
  )
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

# Reads a simple "field: value" out of the front matter without a full YAML
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
  } else {
    # Unquoted plain scalar: YAML folds a long value onto indented
    # continuation lines (e.g. a long title with no surrounding quotes).
    j <- idx + 1
    while (j <= fm_end - 1 && grepl("^[[:space:]]", lines[j])) {
      end <- j
      j <- j + 1
    }
  }
  list(start = idx, end = end)
}

# The bib-derived value for each front-matter field this script owns, or
# NULL when the bib entry doesn't have the underlying raw field -- NULL
# means "leave whatever's in the file alone", never "blank it out".
bib_field_values <- function(e) {
  details <- build_details(e)
  list(
    title = if (!is.null(e$title)) yaml_quote(format_title(e$title)) else NULL,
    author = if (!is.null(e$author)) format_authors(e$author) else NULL,
    details = if (!is.null(details)) yaml_quote(details) else NULL,
    doi = if (!is.null(e$doi)) str_trim(e$doi) else NULL
  )
}

# Overwrites an existing publication file's front matter with every
# bib-derived field the entry provides. Returns TRUE if the file changed.
sync_file <- function(path, e) {
  lines <- readLines(path, warn = FALSE, encoding = "UTF-8")
  dashes <- which(lines == "---")
  if (length(dashes) < 2) return(FALSE)

  changed <- FALSE
  values <- bib_field_values(e)
  for (field in names(values)) {
    value <- values[[field]]
    if (is.null(value)) next
    dashes <- which(lines == "---") # re-find: an earlier field's edit may have shifted line numbers
    generated_line <- paste0(field, ": ", value)
    span <- locate_field(lines, dashes[1], dashes[2], field)
    if (is.null(span)) {
      lines <- append(lines, generated_line, after = dashes[2] - 1)
      changed <- TRUE
    } else if (!(span$start == span$end && lines[span$start] == generated_line)) {
      lines <- append(lines[-(span$start:span$end)], generated_line, after = span$start - 1)
      changed <- TRUE
    }
  }

  if (!changed) return(FALSE)
  writeLines(lines, path, useBytes = TRUE)
  TRUE
}

slugify <- function(title) {
  s <- tolower(unescape_latex(title))
  s <- gsub("[^a-z0-9]+", "-", s)
  gsub("^-+|-+$", "", s)
}

# Creates a brand-new publications/<slug>.md for a bib entry that has no
# matching file yet, with whatever fields the entry provides. Matches the
# flat "publications/<slug>.md" layout used by the site's most recent
# publications (rather than the older publications/<slug>/index.md form).
create_file <- function(key, e) {
  title <- if (!is.null(e$title)) format_title(e$title) else key
  slug <- slugify(title)
  path <- file.path("publications", paste0(slug, ".md"))
  if (file.exists(path)) path <- file.path("publications", paste0(slug, "-", tolower(key), ".md"))

  values <- bib_field_values(e)
  fm <- c("---", paste0("bibkey: ", key))
  if (!is.null(values$author)) fm <- c(fm, paste0("author: ", values$author))
  if (!is.null(values$title)) fm <- c(fm, paste0("title: ", values$title))
  if (!is.null(e$year)) fm <- c(fm, paste0("date: ", str_trim(e$year), "-01-01"))
  fm <- c(fm, paste0("categories: ", category_for_type(e$.type)))
  if (!is.null(values$details)) fm <- c(fm, paste0("details: ", values$details))
  if (!is.null(values$doi)) fm <- c(fm, paste0("doi: ", values$doi))
  fm <- c(fm, "---", "")

  writeLines(fm, path, useBytes = TRUE)
  path
}

# ---- run over every bib entry -------------------------------------------

bib <- parse_bib("rjhpubs.bib")

files <- unique(c(
  Sys.glob("publications/*/index.md"), Sys.glob("publications/*/index.qmd"),
  Sys.glob("publications/*.md"), Sys.glob("publications/*.qmd")
))
files <- files[!grepl("_metadata", files)]

# Map every publication file's bibkey -> path, so each bib entry can find
# its one matching file (or learn it needs to be created). Flags a bibkey
# claimed by more than one file, and a file whose bibkey isn't in the bib
# at all, as warnings -- both indicate the 1:1 mapping is broken and need a
# person to sort out, so this script doesn't try to guess which file wins.
key_to_path <- list()
problems <- character(0)
for (f in files) {
  lines <- readLines(f, warn = FALSE, encoding = "UTF-8")
  dashes <- which(lines == "---")
  if (length(dashes) < 2) next
  fm_lines <- lines[(dashes[1] + 1):(dashes[2] - 1)]
  bibkey <- read_simple_field(fm_lines, "bibkey")
  if (is.null(bibkey)) next
  if (!is.null(key_to_path[[bibkey]])) {
    problems <- c(problems, sprintf("duplicate bibkey '%s': %s and %s", bibkey, key_to_path[[bibkey]], f))
    next
  }
  key_to_path[[bibkey]] <- f
  if (is.null(bib[[bibkey]])) {
    problems <- c(problems, sprintf("%s has bibkey '%s', which is not in rjhpubs.bib", f, bibkey))
  }
}

updated <- character(0)
created <- character(0)
for (key in names(bib)) {
  if (key %in% EXCLUDE_KEYS) next
  e <- bib[[key]]
  path <- key_to_path[[key]]
  if (is.null(path)) {
    created <- c(created, create_file(key, e))
  } else if (sync_file(path, e)) {
    updated <- c(updated, path)
  }
}

if (length(problems) > 0) {
  cat("sync_bib_fields:", length(problems), "problem(s) found:\n")
  cat(paste(" -", problems), sep = "\n")
}
if (length(created) > 0) {
  cat("sync_bib_fields: created", length(created), "new publication(s):\n")
  cat(paste(" -", created), sep = "\n")
}
if (length(updated) > 0) {
  cat("sync_bib_fields: synced", length(updated), "publication(s):\n")
  cat(paste(" -", updated), sep = "\n")
}
if (length(problems) == 0 && length(created) == 0 && length(updated) == 0) {
  cat("sync_bib_fields: nothing to sync --", length(bib) - length(EXCLUDE_KEYS), "bib entries already match their publication.\n")
}
