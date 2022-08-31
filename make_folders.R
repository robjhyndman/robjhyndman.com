library(tidyverse)
library(stringr)

# Move files to index within folders
move_files <- function(folder, extension) {
  files <- fs::dir_ls(folder, glob = paste0("*.", extension))
  for (i in seq_along(files)) {
    talk <- read_lines(files[i])
    # Find slug
    slugline <- which(stringr::str_detect(talk, "slug"))
    if (length(slugline) == 0L) {
      slug <- files[i] |>
        str_remove(paste0(folder, "/")) |>
        str_remove(paste0(".", extension))
    } else {
      slug <- talk[slugline] |>
        str_remove("slug:") |>
        str_trim()
    }
    # Create folder
    new_folder <- paste0(folder, "/", slug)
    fs::dir_create(new_folder)
    # Write index file
    write_lines(talk, paste0(new_folder, "/index.", extension))
    # Remove original file
    fs::file_delete(files[i])
  }
}

move_files("seminars", "md")
move_files("publications", "md")
# move_files("hyndsight", "md")

remove_yaml_field <- function(file_contents, field) {
  # Find yaml
  yaml <- which(str_detect(file_contents, "^---"))[seq(2)]
  if (length(yaml) == 0L) {
    stop("No yaml found")
  }
  # Find relevant lines in yaml
  lines <- which(str_detect(file_contents, paste0("^", field, ":")))
  if (length(lines) > 0) {
    lines <- lines[lines < max(yaml)]
  }
  # Remove field
  if (length(lines) > 0) {
    file_contents <- file_contents[-lines]
  }
  # Return result
  return(file_contents)
}


clean_yaml <- function(folder) {
  # Find md and qmd files within folder
  files <- c(
    fs::dir_ls(folder, glob = "*.md"),
    fs::dir_ls(folder, glob = "*.qmd")
  )
  for (i in seq_along(files)) {
    oldcontents <- contents <- read_lines(files[i])
    # Was the md file generated from Rmd?
    if (any(str_detect(contents, "^output:"))) {
      fs::file_delete(files[i])
    } else {
      # Find yaml
      yaml <- which(str_detect(contents, "^---"))
      # Remove blank links from yaml
      if (length(yaml) > 0) {
        blank <- which(str_length(contents) == 0L)
        if (length(blank) > 0) {
          blank <- blank[blank < max(yaml)]
        }
        if (length(blank) > 0) {
          contents <- contents[-blank]
        }
      }
      # Remove wordpress id, author and comments
      contents <- remove_yaml_field(contents, "wordpress")
      contents <- remove_yaml_field(contents, "author")
      contents <- remove_yaml_field(contents, "comments")
      contents <- remove_yaml_field(contents, "mathjax")
      # Write file
      if(!identical(contents, oldcontents)) {
        write_lines(contents, files[i])
      }
    }
  }
}

clean_yaml("hyndsight")
