library(xml2)

# Read Hyndsight xml
rjh <- read_xml(here::here("_site/hyndsight/index.xml")) |>
  as_list()

# Fix meta data
rjh[[1]][[1]][1]$title[[1]] <- "Rob J Hyndman"
rjh[[1]][[1]][2]$link[[1]] <- "https://robjhyndman.com"
attr(rjh[[1]][[1]][3]$link, "href") <- "https://robjhyndman.com/index.xml"
rjh[[1]][[1]][4]$description[[1]] <- "Recent content by Rob J Hyndman"

# Add Publications xml
publications <- read_xml(here::here("_site/publications/index.xml")) |>
  xml_child() |>
  as_list()
rjh[[1]][[1]] <- append(rjh[[1]][[1]], publications[7:26])

# Add Seminars xml
seminars <- read_xml(here::here("_site/seminars/index.xml")) |>
  xml_child() |>
  as_list()
rjh[[1]][[1]] <- append(rjh[[1]][[1]], seminars[7:26])

# Write out new combined xml
as_xml_document(rjh) |>
  write_xml(file = here::here("_site/index.xml"))
