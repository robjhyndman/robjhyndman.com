# Writes `details` and `doi` into each publication's front matter when the
# bib entry has enough to generate them and the file doesn't already set
# them by hand. This has to happen by editing the actual file, before Quarto
# ever runs, because Quarto's `listing:` feature (which builds publications/
# index.qmd) reads each file's raw YAML front matter directly -- it doesn't
# run computations, execute code, or apply Lua filters, so a field that only
# ever existed as a value computed at render time would never reach the
# listing page. rjhpubs.bib stays the source of truth: this script only
# ever fills in a field that's missing, never overwrites one that's already
# set, and running it again after a bib update just fills in anything newly
# missing.
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
  s
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

sync_file <- function(path, bib) {
  lines <- readLines(path, warn = FALSE, encoding = "UTF-8")
  dashes <- which(lines == "---")
  if (length(dashes) < 2) return(FALSE)
  fm_lines <- lines[(dashes[1] + 1):(dashes[2] - 1)]

  bibkey <- read_simple_field(fm_lines, "bibkey")
  if (is.null(bibkey)) return(FALSE)
  e <- bib[[bibkey]]
  if (is.null(e)) return(FALSE)

  new_lines <- character(0)

  if (is.null(read_simple_field(fm_lines, "details"))) {
    details <- build_details(e)
    if (!is.null(details)) new_lines <- c(new_lines, paste0("details: ", yaml_quote(details)))
  }
  if (is.null(read_simple_field(fm_lines, "doi")) && !is.null(e$doi)) {
    new_lines <- c(new_lines, paste0("doi: ", str_trim(e$doi)))
  }

  if (length(new_lines) == 0) return(FALSE)

  out <- append(lines, new_lines, after = dashes[2] - 1)
  writeLines(out, path, useBytes = TRUE)
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
  cat("sync_bib_fields: nothing to fill in --", length(files), "publications already in sync.\n")
} else {
  cat("sync_bib_fields: filled in details/doi for", length(changed), "publication(s):\n")
  cat(paste(" -", changed), sep = "\n")
}
