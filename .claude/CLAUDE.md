# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is the source for [robjhyndman.com](https://robjhyndman.com), a personal academic website for Rob J Hyndman. It is built with [Quarto](https://quarto.org) and contains a blog, publications list, seminars, software, and teaching pages.

## Commands

```bash
make preview    # Local dev server (quarto preview)
make build      # Full site build including unbelievable/ and prato2023/ sub-projects
make deploy     # Build + rsync to remote server (requires SSH access)
make clean      # Delete _site/
```

The main site excludes `unbelievable/` and `prato2023/` from the default render — they are built separately via `make build`.

## Content architecture

Content lives in section directories, each containing subdirectories with an `index.md` or `index.qmd` file:

- `hyndsight/` — blog posts (`.qmd` for posts with R code, `.md` for static posts)
- `publications/` — research papers and book chapters
- `seminars/` and `talks/` — conference talks and seminars
- `software/`, `teaching/`, `research-team/` — other sections

Each section has a `_metadata.yml` with section-wide Quarto options (e.g., custom HTML templates, sidebar settings).

### Front matter conventions

**Blog posts** (`hyndsight/`):
```yaml
date: YYYY-MM-DD
slug: post-slug
title: "Post Title"
image: /img/image.png
categories:
- forecasting
```

**Publications** (`publications/`):
```yaml
author: Author Names
Status: Published
date: YYYY-MM-DD
slug: paper-slug
title: Paper Title
categories: Articles   # or: Book chapters, Working papers, etc.
tags: [forecasting, time series]
details: '<em>Journal Name</em> <b>volume</b>(issue), pages'
doi: 10.xxxx/xxxxx
file: paper.pdf        # optional, place file in same directory
```

**Seminars** (`seminars/`):
```yaml
date: YYYY-MM-DD
title: "Talk Title"
venue: Venue Name
slug: talk-slug
aliases:
  - "/short-url"
link: https://...       # slides URL
youtube: videoID        # optional YouTube embed
```

### News items

News items are stored in `news.yml` (not as individual files). Each entry has: `title`, `href`, `outlet`, `outlet-url`, `date`.

### Shared/reusable content

`podcasts.qmd` is a shared content file included by reference via `{{< include /podcasts.qmd >}}` in blog posts.

## Freeze and caching

`freeze: true` is set globally in `_quarto.yml`. Quarto caches computational outputs in `_freeze/`. R code in `.qmd` files won't re-execute unless you explicitly re-render that file. To force re-execution of a specific file:

```bash
quarto render hyndsight/podcasts/index.qmd --no-cache
```

## RSS feed post-processing

After `quarto render`, run `Rscript make_xml.R` (done automatically by `make deploy`) to merge the publications and seminars RSS feeds into the main `index.xml` feed.

## Styling

Custom CSS/SCSS is in `rjh.scss`. The base theme is `tango` (Quarto built-in). Custom HTML templates for sections live alongside content (e.g., `hyndsight/hyndsight.html`, `publications/publication.html`).

## Extensions used

- `quarto-ext/fontawesome` — `{{< fa icon-name >}}` shortcodes
- `schochastics/academicons` — `{{< ai icon-name >}}` shortcodes for academic icons (Google Scholar, ORCID, etc.)
