# Plot fonts as in the OTexts books: Fira Sans for text, and the KaTeX fonts
# (the "BookMath" family) for maths written with TeX().
# Source it at the start of a post: source(here::here("plot-setup.R"))
knitr::opts_chunk$set(dev = "ragg_png") # systemfonts-registered fonts need ragg
# Attached first, so the theme_void() below masks it without a message
library(ggplot2)
otexts::register_book_fonts()
otexts::set_book_theme()
TeX <- otexts::tex
theme_void <- otexts::theme_book_void
