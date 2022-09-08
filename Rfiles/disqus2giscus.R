# Code to migrate disqus comments to giscus
# The code to turn a disqus xml to a tibble is due to Maëlle Salmon's post at
# https://masalmon.eu/2019/10/02/disqus/
# The code to turn the tibble into giscus posts was
# mostly written by Mitch O'Hara-Wild.
# Final version by Rob J Hyndman. 8 September 2022

# These are the only lines that should need changing
disqus_file <- "hyndsight.xml"
website <- "https://robjhyndman.com"
github_name <- "robjhyndman"
github_repo <- "hyndsight"
my_disqus_name <- "Rob J Hyndman"
####################################################

library(tidyverse)

# Read Disqus comments
export <- xml2::read_xml(disqus_file)

# Extract nodes corresponding to comments
threads_nodes <- xml2::xml_find_all(export, "d1:thread")

# Extract interesting information from each node,
# information that is potentially nested
threads <- tibble::tibble(
  thread_id = xml2::xml_attr(
    threads_nodes,
    "id"
  ),
  title = xml2::xml_text(
    xml2::xml_find_all(threads_nodes, "d1:title")
  ),
  url = xml2::xml_text(
    xml2::xml_find_all(threads_nodes, "d1:link")
  )
)

# Extract nodes corresponding to comments
comments_nodes <- xml2::xml_find_all(export, "d1:post")

# Extract interesting information from each node,
# information that is potentially nested
comments <- tibble::tibble(
  thread_id = xml2::xml_attr(
    xml2::xml_find_all(comments_nodes, "d1:thread"),
    "id"
  ),
  comment_id = xml2::xml_attr(comments_nodes, "id"),
  parent_id = map_chr(comments_nodes, function(x) {
    parent <- xml2::xml_find_all(x, "d1:parent")
    if(length(parent) == 0) NA_character_ else xml2::xml_attr(parent,"id")
  }),
  message = xml2::xml_text(
    xml2::xml_find_all(comments_nodes, "d1:message")
  ),
  date = xml2::xml_text(
    xml2::xml_find_all(comments_nodes, "d1:createdAt")
  ),
  deleted = xml2::xml_text(
    xml2::xml_find_all(comments_nodes, "d1:isDeleted")
  ),
  spam = xml2::xml_text(
    xml2::xml_find_all(comments_nodes, "d1:isSpam")
  ),
  author = xml2::xml_text(
    xml2::xml_find_all(
      xml2::xml_find_all(comments_nodes, "d1:author"),
      "d1:name"
    )
  )
)

# Combine comments and threads into one data frame
# and remove deleted and spam comments
comments <- comments |>
  mutate(
    date = anytime::anytime(date),
    deleted = deleted == "true",
    spam = spam == "true"
  ) |>
  left_join(threads, by = "thread_id") |>
  filter(!deleted, !spam) |>
  select(-deleted, -spam)

# Remove thread_ids without comments
threads <- threads |>
  filter(thread_id %in% comments$thread_id) |>
  # simplify url
  mutate(url = str_remove(url, website))

# Store github repo details
repo <- gh::gh_gql(paste0('query FindRepo {
  repository(owner: "',github_name, '", name: "', github_repo, '") {
    id
  }
}'))

# Get available discussion categories
discussion_categories <- gh::gh_gql(paste0('query {
  repository(owner: "', github_name, '", name: "', github_repo, '") {
    discussionCategories(first: 10) {
      nodes {
        id
        description
      }
    }
  }
}'))

# Get first category id
category_id <- discussion_categories$data$repository$discussionCategories$nodes[[1]]$id

# Template for new discussion post
new_discussion_query <- 'mutation {
  # input type: CreateDiscussionInput
  createDiscussion(input: {repositoryId: "{{repo_id}}", categoryId: "{{category_id}}", body: "{{discussion_body}}", title: "{{discussion_title}}"}) {

    # response type: CreateDiscussionPayload
    discussion {
      id
    }
  }
}'

# Template for new comment
new_comment_query <- 'mutation {
  addDiscussionComment(input: {discussionId: "{{discussion_id}}", body: "{{comment_body}}"{{#reply_id}} , replyToId: "{{reply_id}}"{{/reply_id}} }) {

    # response type: CreateDiscussionPayload
    comment {
      id
    }
  }
}'

# Resolve root comment
resolve_root_comment <- function(comment_id, parent_id) {
  resolved <- is.na(parent_id)
  while(length(unresolved <- which(!resolved)) > 0) {
    parent_comments <- match(parent_id[unresolved], comment_id)
    # Set resolved parents
    resolved[unresolved] <- newly_resolved <- is.na(parent_id[parent_comments])
    # Update unresolved parents
    parent_id[unresolved[!newly_resolved]] <- parent_id[parent_comments[!newly_resolved]]
  }
  parent_id
}

# Add comment to discussion
add_comment <- function(comment, discussion_id) {
  xfun::write_utf8(
    comment$message,
    msg_html <- tempfile(fileext = ".html")
  )
  rmarkdown::pandoc_convert(
    input = msg_html, from = "html",
    output = msg_md <- tempfile(fileext = ".md"), to = "markdown"
  )
  # Remove escaping of &quot
  comment$message <- gsub('\\\\"', '"', paste0(readLines(msg_md), collapse = "\n"))
  # Fix embeded links
  comment$message <- gsub('\\{rel=\\"nofollow noopener\\"\\}', "", comment$message)
  comment$message <- gsub(' \\"http[:/ a-zA-Z0-9_\\-\\.]*\\"',"",comment$message)

  # Add comment metadata
  comment$guest <- comment$author != my_disqus_name
  comment$message <- whisker::whisker.render(
    "```header
Originally posted {{#guest}}by {{{author}}} {{/guest}}on {{date}}
````
{{{message}}}",
    data = comment
  )
  data <- list(
    discussion_id = discussion_id,
    comment_body = gsub("\\\\", "\\\\\\\\", comment$message)
  )
  if("reply_id" %in% colnames(comment)) {
    if(!is.na(comment$reply_id))
      data$reply_id <- comment$reply_id
  }
  query <- whisker::whisker.render(
    template = new_comment_query,
    data = data
  )
  while (!is.null((out <- gh::gh_gql(query))$errors)) {
    if(out$errors[[1]]$message == "was submitted too quickly") {
      cli::cli_alert_danger("Hit rate limit, waiting 1 minute...")
      Sys.sleep(60)
    } else {
      # Unknown error, debug interactively
      browser()
    }
  }
  out$data$addDiscussionComment$comment$id
}

## Iterate over comments data to add all comments as giscus posts
thread_ids <- unique(comments$thread_id)
for(i in 1:length(thread_ids)) {
  # Grab thread for post i
  discussion_thread <- comments %>%
    filter(thread_id == thread_ids[i]) %>%
    mutate(parent_id = resolve_root_comment(comment_id, parent_id)) |>
    mutate(title_url = str_remove(url, website))
  # Generate new discussion post on github
  post <- whisker::whisker.render(
    template = new_discussion_query,
    data = list(
      repo_id = repo$data$repository$id,
      category_id = category_id,
      discussion_title = discussion_thread$title_url[1],
      discussion_body = paste(discussion_thread$title[1],"\n",discussion_thread$url[1])
    )
  )
  while (!is.null((new_discussion <- gh::gh_gql(post))$errors)) {
    if(out$errors[[1]]$message == "was submitted too quickly") {
      cli::cli_alert_danger("Hit rate limit, waiting 1 minute...")
      Sys.sleep(60)
    } else {
      # Unknown error, debug interactively
      browser()
    }
  }
  # Split thread into comments and replies
  discussion_thread_type <- split(discussion_thread,
            ifelse(is.na(discussion_thread$parent_id), "comment", "reply"))
  discussion_thread_type$comment$id <- ""
  # Post comments
  for(j in seq(NROW(discussion_thread_type$comment))) {
    discussion_thread_type$comment$id[j] <- add_comment(
      discussion_thread_type$comment[j,],
      discussion_id = new_discussion$data$createDiscussion$discussion$id
    )
  }
  # Add replies if they exist
  if(!is.null(discussion_thread_type$reply)) {
    discussion_thread_type$reply$id <- ""
    discussion_thread_type$reply$reply_id <-
      discussion_thread_type$comment$id[match(discussion_thread_type$reply$parent_id, discussion_thread_type$comment$comment_id)]
    # Post replies
    for(j in seq(NROW(discussion_thread_type$reply))) {
      discussion_thread_type$reply$id[j] <- add_comment(
        discussion_thread_type$reply[j,],
        discussion_id = new_discussion$data$createDiscussion$discussion$id
      )
    }
  }
}
