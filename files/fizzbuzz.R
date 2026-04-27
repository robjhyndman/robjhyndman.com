fizz_buzz <- function(x) {
  if (!is.numeric(x)) {
    stop("x must be a numeric vector")
  }
  if (any(abs(x - round(x)) > .Machine$double.eps)) {
    stop("x must be a vector of integers")
  }
  output <- as.character(x)
  output[x %% 5 == 0] <- "fizz"
  output[x %% 7 == 0] <- "buzz"
  output[x %% 5 == 0 & x %% 7 == 0] <- "fizzbuzz"
  output
}
