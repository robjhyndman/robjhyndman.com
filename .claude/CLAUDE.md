# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is the source for [robjhyndman.com](https://robjhyndman.com), a personal academic website for Rob J Hyndman. It is built with [Quarto](https://quarto.org) and contains a blog, publications list, seminars, software, and teaching pages.

## Commands

```bash
make preview    # Rscript update_podcast_date.R + sync_bib_fields.R, then quarto preview
make build      # Same pre-steps, then quarto render (main site + unbelievable/ + prato2023/)
make deploy     # Build + make_xml.R + rsync to remote server (requires SSH access)
make clean      # Delete _site/
```

The main site excludes `unbelievable/` and `prato2023/` from the default render — they are built separately via `make build`.

`update_podcast_date.R` bumps `hyndsight/podcasts/index.qmd`'s `date` when `podcasts.qmd` has a newer episode. `sync_bib_fields.R` regenerates publication front matter from the bib file — see below.

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
bibkey: someKey2024        # must match an entry in ~/git/CV/rjhpubs.bib
author: Author Names
title: Paper Title
date: YYYY-MM-DD
categories: Articles        # or: Book chapters, Working papers, etc.
details: '<em>Journal Name</em> <b>volume</b>(issue), pages'
doi: 10.xxxx/xxxxx
file: paper.pdf              # optional, place file in same directory
```

Files live either flat as `publications/<slug>.md` (current convention for new entries) or as `publications/<slug>/index.md` (older layout, still present for existing entries).

`author`, `title`, `details`, and `doi` are **generated, not hand-edited**: `sync_bib_fields.R` (run by `make preview`/`make build`) reads `~/git/CV/rjhpubs.bib` — the CV repo's checkout, the single source of truth — and overwrites those fields from the entry matching `bibkey`. It also creates a new `publications/<slug>.md` for any bib entry with no matching file yet (skipping bibkeys listed in `EXCLUDE_KEYS`, e.g. books with their own dedicated page). Edit the bib entry in the CV repo, not the front matter here, to change these fields. A separate Lua filter, `publications/inject-bibtex.lua`, injects the raw BibTeX entry into the page for the "Cite" section at render time — it reads the same bib file but doesn't touch front matter.

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

The site supports light and dark mode (Quarto's `theme.light`/`theme.dark` in `_quarto.yml`): light uses the `tango` base theme plus `rjh.scss`; dark uses `rjh-dark.scss`. Custom HTML templates for sections live alongside content (e.g., `hyndsight/hyndsight.html`, `publications/publication.html`). The site follows a consistent card/badge/pill visual language across listing pages (homepage, hyndsight, publications, software, seminars) — check existing patterns in `rjh.scss` before introducing new component styles.

## Extensions used

- `quarto-ext/fontawesome` — `{{< fa icon-name >}}` shortcodes
- `schochastics/academicons` — `{{< ai icon-name >}}` shortcodes for academic icons (Google Scholar, ORCID, etc.)
