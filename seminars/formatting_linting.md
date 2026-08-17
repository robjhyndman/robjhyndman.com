---
date: 2026-08-18
title: "Formatting and linting code and documents"
venue: NUMBAT
link: https://github.com/robjhyndman/fl26_talk/raw/main/fl26.pdf
---

## NUMBAT seminar

Consistently formatted source is easier to read, review and diff, and linters alert you to problems before they become bugs.
I will survey and demonstrate the current generation of fast, opinionated formatters and linters --- mostly written in Rust, and usable from the command line or from within Positron (and in some cases from RStudio).
I'll focus on air for R and panache for Quarto and R Markdown.
If time, I might also mention jarl for R linting, ruff for Python, tex-fmt and chktex for LaTeX, and vale for prose (checking manuscripts against a style guide).
I'll show how to use TOML configuration and format-on-save, so that your code and documents stay tidy with no ongoing effort.

## R

- [**Google style guide**](<https://google.github.io/styleguide/Rguide.html>)
- [**Tidyverse style guide**](<https://style.tidyverse.org/>)
- [**styler**](<https://styler.r-lib.org/>): R code formatting
- [**formatR**](<https://yihui.org/formatr/>): R code formatting
- [**air**](<https://posit-dev.github.io/air/>): R code formatting
- [**Jarl**](<https://jarl.etiennebacher.com/>): R code linting

## Python

- [**Ruff**](<https://docs.astral.sh/ruff/>): Python linting and formatting

## Quarto and Rmarkdown

- [**Panache**](<https://panache.bz/>): Markdown, quarto and Rmarkdown linting and formatting

## LaTeX

- [**latexindent**](https://github.com/cmhughes/latexindent.pl): LaTeX formatting
- [**tex-fmt**](<https://github.com/wgunderwood/tex-fmt>): LaTeX formatting
- [**chktex**](<https://www.nongnu.org/chktex/>): LaTeX linting

## Other

- [**Prettier**](<https://prettier.io/>): JavaScript, TypeScript, HTML, CSS, JSON, Markdown
- [**Vale**](<https://vale.sh/>): Prose linting

## Slides
