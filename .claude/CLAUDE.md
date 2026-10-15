# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is the source for [robjhyndman.com](https://robjhyndman.com), a personal academic website for Rob J Hyndman. It is built with [Quarto](https://quarto.org) and contains a blog, publications list, seminars, software, and teaching pages.

## Commands

```bash
make preview    # quarto preview
make build      # quarto render (main site + unbelievable/ + prato2023/)
make deploy     # Build + make_xml.R + rsync to remote server (requires SSH access)
make clean      # Delete _site/
```

The main site excludes `unbelievable/` and `prato2023/` from the default render — they are built separately via `make build`. They render straight into `../_site/unbelievable` and `../_site/prato2023`; Quarto warns about this (output dir outside the project, so it won't clean the old `site_libs/`), which is expected and accepted — don't "fix" it. Both reuse the main site's styling: their `_quarto.yml` themes are `../rjh.scss` (unbelievable adds `unbelievable.scss` for its slate accent and OTexts-style sidebar and font sizes; `$theme-main` in `rjh.scss` is `!default` for this) and they include `../header.html`.

Three pre-render scripts are listed under `project: pre-render:` in `_quarto.yml`, so Quarto runs them before a full render and at preview start-up (each skips partial renders, e.g. `quarto render file.qmd` or preview re-renders on save). `update_podcast_date.R` bumps `hyndsight/podcasts/index.qmd`'s `date` when `podcasts.qmd` has a newer episode. `sync_bib_fields.R` regenerates publication front matter from the bib file — see below. `software/update_package_meta.R` refreshes `software/package_meta.rds` (CRAN/GitHub metadata and download counts, via `package_meta()` in `software/software_functions.R`) when it is 30+ days old.

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

`author`, `title`, `details`, and `doi` are **generated, not hand-edited**: `sync_bib_fields.R` (a pre-render script) reads `~/git/CV/rjhpubs.bib` — the CV repo's checkout, the single source of truth — and overwrites those fields from the entry matching `bibkey`. It also creates a new `publications/<slug>.md` for any bib entry with no matching file yet (skipping bibkeys listed in `EXCLUDE_KEYS`, e.g. books with their own dedicated page). Edit the bib entry in the CV repo, not the front matter here, to change these fields. `categories` is also regenerated (from the bib entry type) when it contradicts that type, e.g. `Working papers` on what is now an `@article`; a hand-set `Editorials` or `Miscellaneous` on an `@article` is kept. A separate Lua filter, `publications/inject-bibtex.lua`, injects the raw BibTeX entry into the page for the "Cite" section at render time — it reads the same bib file but doesn't touch front matter.

**Seminars** (`seminars/`):
```yaml
date: YYYY-MM-DD
title: "Talk Title"
venue: Venue Name
slug: talk-slug
aliases:
  - "/short-url"
pdf: https://...        # PDF slides (/talks/x.pdf for files in talks/)
youtube: videoID        # optional YouTube embed
```

`{{< pdf >}}` shows the front-matter `pdf` wherever it's placed in the body; if not placed it's added at the end of the page by `seminars/auto-embed.lua`. With an argument (`{{< pdf URL >}}`) it embeds any other PDF, on any page. The shortcode is site-wide (`pdf.lua`) and draws PDFs with PDF.js via `pdf-embed.js`, since iframes of PDFs don't work on mobile, and `fullpage=true` is the CV page's full-window mode. HTML slides use `slides:` + `{{< slides >}}` (`seminars/slides.lua`). Publications keep their own `file`/`link` fields (`publications/pubs.ejs`).

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

The site is light-only: Quarto's default Bootstrap theme plus `rjh.scss` (variables under `scss:defaults`, rules under `scss:rules`). Fonts (Libron body, Fira Sans headings/UI, Hack code) are self-hosted in `fonts/`; their `@font-face` rules live in `fonts/fonts.css`, linked as `/fonts/fonts.css` from `header.html`. `fonts/` is a project resource, so renders copy it to `_site/fonts/`. Custom HTML templates for sections live alongside content (e.g., `hyndsight/hyndsight.html`, `publications/publication.html`). The site follows a consistent card/badge/pill visual language across listing pages (homepage, hyndsight, publications, software, seminars) — check existing patterns in `rjh.scss` before introducing new component styles.

## Extensions used

- `quarto-ext/fontawesome` — `{{< fa icon-name >}}` shortcodes
- `schochastics/academicons` — `{{< ai icon-name >}}` shortcodes for academic icons (Google Scholar, ORCID, etc.)
