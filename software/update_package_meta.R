# Run as a Quarto pre-render script: skip partial renders (single files, and
# re-renders during preview) so this only runs for full renders and preview
# start-up. Still runs when called directly with Rscript.
if (
  Sys.getenv("QUARTO_PROJECT_INPUT_FILES") != "" &&
    Sys.getenv("QUARTO_PROJECT_RENDER_ALL") != "1"
) {
  quit(save = "no")
}

# Refresh the cached package metadata (incl. downloads) if it is 30+ days old,
# so the slow fetch happens up front rather than when the software page renders
suppressMessages(library(dplyr))
source("software/software_functions.R")
invisible(package_meta())
