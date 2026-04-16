# Dates of all podcasts
lines <- readLines("podcasts.qmd")
dates <- regmatches(lines, regexpr("[0-9]{4}-[0-9]{2}-[0-9]{2}", lines))
max_date <- max(as.Date(dates))

# Check current date of podcast blog post
post <- readLines("hyndsight/podcasts/index.qmd")
current_date <- regmatches(
  post,
  regexpr("date: [0-9]{4}-[0-9]{2}-[0-9]{2}", post)
)
current_date <- sub("date: ", "", current_date)

# Update blog post if there's a new podcast
if (max_date > current_date) {
  post <- sub("^date:.*", paste("date:", max_date), post)
  writeLines(post, "hyndsight/podcasts/index.qmd")
}
