# Compares title/author on each publication's page against its entry in
# rjhpubs.bib and prints any that disagree. Run this after editing either
# file to catch drift before it goes live -- title, author, doi and details
# are all meant to stay in sync with the bib. doi and details are written
# into each page's front matter by sync_bib_fields.R whenever missing (and
# only when missing, since a handful of them are deliberately overridden --
# see TITLE_EXCEPTIONS below), so they can only go stale if the bib changes
# without that script being rerun. title and author can't be auto-filled the
# same unconditional way: unlike doi/details, which always have exactly one
# correct value, a title or author sometimes has a deliberate, permanent
# override (a book review's title built from the reviewed book's own
# details, an author's name spelled out vs. compact initials) that blind
# generation would silently clobber -- so this script is the fallback that
# at least flags it when the two drift apart instead of trying to fix it.
#
# Usage: Rscript check_bib_sync.R

library(yaml)
library(stringr)

# ---- bib parsing ------------------------------------------------------

# Extracts the balanced-brace value starting at `pos` (which must point at
# the opening "{") and returns list(value = ..., after = <pos just past "}">)
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
      if (depth == 0L) {
        return(list(value = substr(text, start + 1L, j - 1L), after = j + 1L))
      }
    }
    j <- j + 1L
  }
  list(value = substr(text, start + 1L, n), after = n + 1L)
}

# Parses one raw "@type{key, field = {value}, ...}" chunk into a named list
# of lowercased field -> value.
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
      fields[[tolower(name)]] <- regmatches(rest, vm)
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
    key <- str_match(chunk, "^@[[:alpha:]]+\\{\\s*([^,]+),")[, 2]
    if (is.na(key)) next
    key <- str_trim(key)
    body <- sub("^@[[:alpha:]]+\\{[^,]+,", "", chunk)
    entries[[key]] <- parse_fields(body)
  }
  entries
}

# ---- normalization (strip formatting noise, keep real wording/case) --

normalize <- function(s) {
  if (is.null(s)) return(NA_character_)
  s <- gsub("``", "'", s, fixed = TRUE)  # LaTeX open double-quote
  s <- gsub("''", "'", s, fixed = TRUE)  # LaTeX close double-quote
  s <- gsub("---", "-", s)
  s <- gsub("--", "-", s)
  s <- gsub("[–—]", "-", s)    # en/em dash -> plain hyphen
  s <- gsub("\\\\&", "&", s)
  s <- gsub("&#8209;", "-", s)          # HTML non-breaking hyphen entity -> plain hyphen
  s <- gsub("&nbsp;", " ", s)           # HTML non-breaking space entity -> plain space
  s <- gsub("‑", "-", s)            # literal non-breaking hyphen -> plain hyphen
  s <- gsub("\\\\~", " ", s)             # LaTeX tie (non-breaking space) -> space
  s <- gsub("~", " ", s)
  s <- gsub("[{}]", "", s)
  s <- gsub("\\\\[a-zA-Z]+\\s*", "", s)  # best-effort: drop stray LaTeX commands
  # Quote-style is cosmetic (curly vs straight, single vs double) -- collapse
  # all quote-mark variants to a single canonical mark so the comparison
  # only trips on actual wording, not typography.
  s <- gsub("[‘’“”'\"]", "'", s)
  s <- str_squish(s)
  s
}

split_bib_authors <- function(raw) {
  parts <- str_split(raw, "\\s+and\\s+")[[1]]
  vapply(parts, function(p) {
    p <- str_trim(p)
    m <- str_match(p, "^([^,]+),\\s*(.+)$")
    if (!is.na(m[1, 1])) p <- paste(m[1, 3], m[1, 2])
    normalize(p)
  }, character(1), USE.NAMES = FALSE)
}

split_qmd_authors <- function(raw) {
  parts <- str_trim(str_split(raw, ",\\s*|\\s+and\\s+")[[1]])
  vapply(parts, normalize, character(1), USE.NAMES = FALSE)
}

# The bib spells names out in full ("P D McNair") while the site's byline
# uses compact initials ("PD McNair") and doesn't always preserve list
# order -- neither is wrong, they're just different house styles for the
# same person. So authors are compared by *surname set*, not literal string:
# take each name's last whitespace-separated token (case-sensitive, so a
# real capitalization slip like "de Gooijer"/"De Gooijer" is invisible to
# this -- that's a deliberate tradeoff to keep the signal-to-noise ratio
# usable) and compare the two sets. A mismatch here means someone was
# actually added, dropped, or their surname is spelled/split differently --
# not just written out differently.
surname_set <- function(names) {
  sort(vapply(names, function(n) {
    toks <- str_split(n, "\\s+")[[1]]
    toks[length(toks)]
  }, character(1), USE.NAMES = FALSE))
}

# Titles you've said to leave permanently divergent: the bib keeps its own
# citation-style wording (book reviews use "Book review of X (Author, Year)"
# built from the review's own fields; the CV also keeps a "(Chinese)"
# language note the site drops) and isn't meant to be forced into sync.
TITLE_EXCEPTIONS <- c("BR96", "BR98a", "BR98b", "BR99a", "BR99b", "BR99c", "EH05a", "Hyndman01", "YH06")

# ---- compare every publication against its bib entry ------------------

bib <- parse_bib(here::here("rjhpubs.bib"))

files <- c(
  Sys.glob(here::here("publications/*/index.md")),
  Sys.glob(here::here("publications/*/index.qmd")),
  Sys.glob(here::here("publications/*.md")),
  Sys.glob(here::here("publications/*.qmd"))
)

mismatches <- list()
for (f in files) {
  txt <- paste(readLines(f, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
  parts <- str_split(txt, "^---\\s*$", n = 3)[[1]] # not reliable across lines; use split on first two '---'
  # Robust front-matter extraction: text between the first and second '---' lines.
  lines <- readLines(f, warn = FALSE, encoding = "UTF-8")
  dashes <- which(lines == "---")
  if (length(dashes) < 2) next
  fm_text <- paste(lines[(dashes[1] + 1):(dashes[2] - 1)], collapse = "\n")
  fm <- tryCatch(suppressWarnings(yaml.load(fm_text)), error = function(e) NULL)
  if (is.null(fm) || is.null(fm$bibkey)) next

  key <- as.character(fm$bibkey)
  entry <- bib[[key]]
  if (is.null(entry)) {
    mismatches[[length(mismatches) + 1]] <- list(
      key = key, file = f, field = "bibkey", bib = NA, qmd = "(not found in rjhpubs.bib)"
    )
    next
  }

  if (!is.null(fm$title) && !is.null(entry$title) && !(key %in% TITLE_EXCEPTIONS)) {
    b <- normalize(entry$title)
    q <- normalize(as.character(fm$title))
    if (b != q) {
      mismatches[[length(mismatches) + 1]] <- list(key = key, file = f, field = "title", bib = b, qmd = q)
    }
  }

  if (!is.null(fm$author) && !is.null(entry$author)) {
    b_names <- split_bib_authors(entry$author)
    q_names <- split_qmd_authors(as.character(fm$author))
    if (!identical(surname_set(b_names), surname_set(q_names))) {
      mismatches[[length(mismatches) + 1]] <- list(
        key = key, file = f, field = "author",
        bib = paste(b_names, collapse = ", "), qmd = paste(q_names, collapse = ", ")
      )
    }
  }
}

if (length(mismatches) == 0) {
  cat("check_bib_sync: all", length(files), "publications match rjhpubs.bib on title/author.\n")
} else {
  cat("check_bib_sync: found", length(mismatches), "mismatch(es) between rjhpubs.bib and the website:\n\n")
  for (m in mismatches) {
    cat(sprintf("[%s] %s (%s)\n", m$field, m$key, sub(here::here(), "", m$file)))
    cat(sprintf("  bib: %s\n", m$bib))
    cat(sprintf("  qmd: %s\n\n", m$qmd))
  }
}
