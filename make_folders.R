library(tidyverse)
library(stringr)

# Move files to index within folders
move_files <- function(folder, extension) {
  files <- fs::dir_ls(folder, glob=paste0("*.",extension))
  for(i in seq_along(files)) {
    talk <- read_lines(files[i])
    # Find slug
    slugline <- which(stringr::str_detect(talk, "slug"))
    if(length(slugline) == 0L) {
      slug <- files[i] |> 
        str_remove(paste0(folder,"/")) |> 
        str_remove(paste0(".",extension))
    } else {
      slug <- talk[slugline] |> 
        str_remove("slug:") |> 
        str_trim()
    }
    # Create folder
    new_folder <- paste0(folder,"/",slug)
    fs::dir_create(new_folder)
    # Write index file
    write_lines(talk, paste0(new_folder,"/index.",extension))
    # Remove original file
    fs::file_delete(files[i])
  }
}

move_files("seminars","md")
move_files("publications","md")
move_files("hyndsight", "md")


clean_yaml <- function(folder) {
  files <- c(
    fs::dir_ls(folder, glob="*.md"),
    fs::dir_ls(folder, glob="*.Rmd"),
    fs::dir_ls(folder, glob="*.qmd")
  )
  for(i in seq_along(files)) {
    modified <- FALSE
    contents <- read_lines(files[i])
    # Find yaml
    yaml <- which(str_detect(contents, "^---"))
    # Remove blank links from yaml
    if(length(yaml) > 0) {
      blank <- which(str_length(contents)==0L)
      if(length(blank) > 0)
        blank <- blank[blank < max(yaml)]
      if(length(blank) > 0) {
        contents <- contents[-blank]
        modified <- TRUE
      }
      yaml <- which(str_detect(contents, "^---"))
    }
    # Remove wordpress id
    if(length(yaml) > 0) {
      wp <- which(str_detect(contents, "^wordpress"))
      if(length(wp) > 0)
        wp <- wp[wp < max(yaml)]
      if(length(wp) > 0) {
        contents <- contents[-wp]
        modified <- TRUE
      }
    }
    # Remove comments line
    if(length(yaml) > 0) {
      wp <- which(str_detect(contents, "^comments:"))
      if(length(wp) > 0)
        wp <- wp[wp < max(yaml)]
      if(length(wp) > 0) {
        contents <- contents[-wp]
        modified <- TRUE
      }
    }
    # Write file
    if(modified)
      write_lines(contents, files[i])
  }
}

clean_yaml("hyndsight")
