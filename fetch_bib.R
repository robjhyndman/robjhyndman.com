# Fetch the canonical publication bibliography from the CV repo (source of
# truth) into a local cached copy used by the site build.
url <- "https://raw.githubusercontent.com/robjhyndman/CV/main/rjhpubs.bib"
dest <- "rjhpubs.bib"

tmp <- tempfile()
ok <- tryCatch(
  {
    download.file(url, tmp, quiet = TRUE, mode = "wb")
    file.exists(tmp) && file.size(tmp) > 0
  },
  error = function(e) FALSE,
  warning = function(w) FALSE
)

if (isTRUE(ok)) {
  file.copy(tmp, dest, overwrite = TRUE)
  message("Updated ", dest, " from robjhyndman/CV.")
} else if (file.exists(dest)) {
  warning("Could not fetch rjhpubs.bib from robjhyndman/CV; using cached copy at ", dest, ".")
} else {
  stop("Could not fetch rjhpubs.bib from robjhyndman/CV and no cached copy exists at ", dest, ".")
}
