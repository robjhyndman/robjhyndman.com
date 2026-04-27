library(dplyr)
library(purrr)

# The following code was left by a colleague with no comments or docs.

wrangle <- function(df, threshold = 0.1) {
  df |>
    split(df$group) |>
    map(\(d) {
      mu <- mean(d$value, na.rm = TRUE)
      d |>
        mutate(
          z = (value - mu) / sd(value, na.rm = TRUE),
          flag = abs(z) > qnorm(1 - threshold / 2)
        )
    }) |>
    list_rbind()
}

set.seed(42)
demo <- data.frame(
  group = rep(c("A", "B", "C"), each = 20),
  value = c(rnorm(20, 5), rnorm(20, 10, 2), rnorm(20, 3, 0.5))
)
demo[c(3, 25, 41), "value"] <- c(50, -10, 30) # inject outliers

result <- wrangle(demo)

# ── Example 1: Understand the code ───────────────────────────────────────────
# Select the entire `wrangle()` function and ask:
# "Explain what this function does, step by step."

# ── Example 2: Understand the output ─────────────────────────────────────────
# Ask: "What does the `flag` column in `result` represent? What statistical
#       method is being used?"

# ── Example 3: Add roxygen2 documentation ────────────────────────────────────
# Switch to the Edit agent. Select the `wrangle()` function and ask:
# "Add a roxygen2 documentation block to this function."

# ── Example 4: Write a test ───────────────────────────────────────────────────
# Ask: "Write a testthat test that checks wrangle() correctly flags outliers
#       in a known dataset."
