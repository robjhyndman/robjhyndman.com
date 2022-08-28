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
  files <- fs::dir_ls(folder)
  for(i in seq_along(files)) {
    contents <- read_lines(files[i])
    # Find yaml
    yaml <- which(str_detect(contents, "---"))
    # Remove blank links from yaml
    blank <- which(str_length(contents)==0L)
    blank <- blank[blank < max(yaml)]
    if(length(blank) > 0)
      contents <- contents[-blank]
    yaml <- which(str_detect(contents, "---"))
    # Remove wordpress id
    wp <- which(str_detect(contents, "wordpress"))
    wp <- wp[wp <- max(yaml)]
    if(length(wp) > 0)
      contents <- contents[-wp]
    # Write file
    write_lines(contents, files[i])
  }
}

clean_yaml("hyndsight")
