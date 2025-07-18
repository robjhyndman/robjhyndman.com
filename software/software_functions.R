# Create generic hex stickers for vector of package names
generic_stickers <- function(packages) {
  # Check if the stickers already exist
  existing <- fs::dir_ls(here::here("software/stickers/"), glob = "*.png") |>
    str_split("/") |>
    lapply(tail, n = 1) |>
    unlist() |>
    str_split("\\.") |>
    lapply(head, n = 1) |>
    unlist()
  packages <- packages[!(packages %in% existing)]
  for (name in packages) {
    create_generic_sticker(name)
  }
}
# Create a generic hex stick
create_generic_sticker <- function(name) {
  empty <- ggplot() +
    theme_void() +
    ggimage::theme_transparent()
  name_length <- nchar(name)
  p_size <- ifelse(name_length < 8, 24, round(24 - (1.1 * name_length - 8)))
  hexSticker::sticker(
    empty,
    package = name,
    p_size = p_size,
    p_y = 1,
    h_fill = "#536878",
    h_size = 2,
    h_color = "#647e91",
    filename = here::here(paste0("software/stickers/", name, ".png"))
  )
}

# Produce html table with info about some packages
# packages is a tibble with all packages
# include is a character vector saying which packages to include and in which order

package_table <- function(packages) {
  z <- packages
  out <- paste0("## ", z$section[1], "\n\n")
  out <- paste0(out, "<table>")
  for (i in seq(NROW(z))) {
    # Create title with extras
    if (!is.na(z$publication[i])) {
      z$title[i] <- paste0(
        z$title[i],
        ": as described in <a href='/publications/",
        z$publication[i],
        "'>",
        z$citation[i],
        "</a>"
      )
    }
    if (!is.na(z$publication2[i])) {
      z$title[i] <- paste0(
        z$title[i],
        " and <a href='/publications/",
        z$publication2[i],
        "'>",
        z$citation2[i],
        "</a>"
      )
    }
    out <- paste0(out, "\n<tr>")
    out <- paste0(
      out,
      "\n  <td><a href='",
      z$url[i],
      "'><img src='",
      z$hex[i],
      "' width='70px' style='vertical-align:middle'></a></td>"
    )
    out <- paste0(out, "\n  <td width='55%'>", z$title[i], ".</td>")
    if (!is.na(z$github_url[i])) {
      out <- paste0(
        out,
        "\n  <td><a href=",
        z$github_url[i],
        " class='badge badge-small badge-green'>Github</a></td>"
      )
    } else {
      out <- paste0(out, "\n  <td>\n</td>")
    }
    if (!is.na(z$cran_url[i])) {
      out <- paste0(
        out,
        "\n  <td><a href=",
        z$cran_url[i],
        " class='badge badge-small badge-blue'>CRAN</a></td>"
      )
    } else {
      out <- paste0(out, "\n  <td></td>")
    }
    if (!is.na(z$downloads[i])) {
      out <- paste0(
        out,
        "\n  <td>Monthly downloads:<br>",
        round(z$downloads[i]),
        "</td>"
      )
    } else {
      out <- paste0(out, "\n  <td></td>")
    }
    out <- paste0(out, "\n</tr>")
  }
  out <- paste0(out, "\n</table>\n\n")
  cat(out)
}

# Add reference info to packages tibble

add_reference <- function(packages, pkg, pub, cite) {
  tmp <- filter(packages, package == pkg)
  if (NROW(tmp) == 0) {
    packages <- packages |>
      bind_rows(tibble(package = pkg))
  }
  pub1 <- packages |>
    filter(package == pkg) |>
    pull(publication) |>
    is.na()
  pub2 <- packages |>
    filter(package == pkg) |>
    pull(publication2) |>
    is.na()
  if (!pub1 & !pub2) {
    stop("Is this a 3rd publication?")
  }
  if (pub1) {
    packages |>
      mutate(
        publication = if_else(package == pkg, pub, publication),
        citation = if_else(package == pkg, cite, citation)
      )
  } else {
    packages |>
      mutate(
        publication2 = if_else(package == pkg, pub, publication2),
        citation2 = if_else(package == pkg, cite, citation2)
      )
  }
}

add_section <- function(packages, section_name, include) {
  out <- packages |>
    filter(!(package %in% include))
  inc <- packages |>
    filter(package %in% include) |>
    mutate(section = section_name)
  inc <- inc[match(include, inc$package), ]
  bind_rows(out, inc)
}

rjh_packages <- function() {
  # Get most recent packages file
  if (fs::file_exists(here::here("software/packages.rds"))) {
    packages <- readRDS(here::here("software/packages.rds"))
    info <- fs::file_info(here::here("software/packages.rds"))
    recent_run <- (Sys.Date() == anytime::anydate(info$modification_time))
  } else {
    recent_run <- FALSE
  }
  if (recent_run) {
    return(packages)
  } else {
    # Create new packages tibble
    # Github repos
    github <- read.table(
      "https://raw.githubusercontent.com/robjhyndman/CV/master/github_r_repos.txt"
    )$V1
    # Combine CRAN and github repos
    cran_github <- pkgmeta::get_meta(
      cran_author = "Hyndman",
      include_downloads = TRUE,
      start = as.character(lubridate::ymd(Sys.Date() - 91)),
      github_repos = github
    ) |>
      # Average monthly downloads in last 3 months
      mutate(downloads = downloads / 3)
    cran_github <- cran_github |>
      mutate(
        url = if_else(
          url == "https://OTexts.com/fpp3/",
          "http://pkg.robjhyndman.com/fpp3/",
          url
        )
      )
    # Add location of hex stickers
    hex_stickers <- tribble(
      ~package,
      ~hex,
      "cricketdata",
      "http://pkg.robjhyndman.com/cricketdata/reference/figures/cricketdata.png",
      "conduits",
      "https://github.com/PuwasalaG/conduits/raw/master/man/figures/logo.png",
      "fable",
      "https://fable.tidyverts.org/reference/figures/logo.png",
      "fasster",
      "stickers/fasstersticker.resized.png",
      "feasts",
      "https://feasts.tidyverts.org/reference/figures/logo.png",
      "forecast",
      "https://pkg.robjhyndman.com/forecast/reference/figures/logo.png",
      "gghdr",
      "https://sayani07.github.io/gghdr/reference/figures/logo.png",
      "gratis",
      "https://github.com/ykang/gratis/raw/master/man/figures/logo.PNG",
      "gravitas",
      "https://github.com/Sayani07/gravitas/raw/master/man/figures/logo.png",
      "hts",
      "stickers/htssticker.resized.png",
      "lookout",
      "https://sevvandi.github.io/lookout/reference/figures/logo.png",
      "oddnet",
      "https://raw.githubusercontent.com/sevvandi/oddnet/master/man/figures/oddnet.png",
      "oddstream",
      "https://github.com/pridiltal/oddstream/raw/master/man/figures/logo.png",
      "oddwater",
      "https://github.com/pridiltal/oddwater/raw/master/man/fig/logo.png",
      "rticles",
      "https://pkgs.rstudio.com/rticles/logo.png",
      "seer",
      "https://github.com/thiyangt/seer/raw/master/logo/seer.png",
      "stray",
      "https://github.com/pridiltal/stray/raw/master/man/figures/logo.png",
      "sugrrants",
      "stickers/sugrrantssticker.resized.png",
      "thief",
      "https://pkg.robjhyndman.com/thief/reference/figures/logo.png",
      "tsibble",
      "https://tsibble.tidyverts.org/reference/figures/logo.png",
      "tsibbledata",
      "https://tsibbledata.tidyverts.org/reference/figures/logo.png",
      "vitae",
      "https://pkg.mitchelloharawild.com/vitae/reference/figures/logo.png",
      "vital",
      "https://pkg.robjhyndman.com/vital/reference/figures/vital-hex.png",
      "weird",
      "https://pkg.robjhyndman.com/weird-package/reference/figures/weird-hex.png",
      "fpp3",
      "https://pkg.robjhyndman.com/fpp3/logo.png",
      "ozbabynames",
      "https://pkg.robjhyndman.com/ozbabynames/logo.png",
      "spiderorchid",
      "https://numbats.github.io/spiderorchid/reference/figures/spiderorchid-hex.png",
      "pkgmeta",
      "https://pkg.robjhyndman.com/pkgmeta/reference/figures/pkgmeta-hex.png",
      "eechidna",
      "https://jforbes14.github.io/eechidna/reference/figures/logo.png",
      "calcal",
      "https://pkg.robjhyndman.com/calcal/logo.png",
    )
    packages <- cran_github |> left_join(hex_stickers, by = "package")

    # Create generic hex stickers where they don't exist
    packages |>
      filter(is.na(hex)) |>
      pull(package) |>
      generic_stickers()
    packages <- packages |>
      mutate(
        hex = if_else(!is.na(hex), hex, paste0("stickers/", package, ".png"))
      )

    # Add reference links to related papers
    # Syntax: package, publication slug, citation
    references <- packages |>
      select(package) |>
      # Avoid duplicates
      distinct() |>
      mutate(
        publication = NA_character_,
        citation = NA_character_,
        publication2 = NA_character_,
        citation2 = NA_character_
      ) |>
      add_reference("bfast", "bfast1", "Verbesselt et al (2010a)") |>
      add_reference("bfast", "bfast2", "Verbesselt et al (2010b)") |>
      add_reference(
        "demography",
        "coherentfdm",
        "Hyndman, Booth & Yasmeen (2013)"
      ) |>
      add_reference("demography", "funcfor", "Hyndman & Ullah (2007)") |>
      add_reference("eechidna", "elections", "Forbes, Cook & Hyndman (2020)") |>
      add_reference(
        "forecast",
        "automatic-forecasting",
        "Hyndman & Khandakar (2008)"
      ) |>
      add_reference(
        "gghdr",
        "computing-and-graphing-highest-density-regions",
        "Hyndman (1996)"
      ) |>
      add_reference("gratis", "gratis", "Kang, Hyndman & Li (2020)") |>
      add_reference(
        "gravitas",
        "gravitas",
        "Gupta, Hyndman, Cook & Unwin (2020)"
      ) |>
      add_reference(
        "hdrcde",
        "computing-and-graphing-highest-density-regions",
        "Hyndman (1996)"
      ) |>
      add_reference(
        "hdrcde",
        "estimating-and-visualizing-conditional-densities",
        "Hyndman, Bashtannyk & Grunwald (1996)"
      ) |>
      add_reference(
        "hts",
        "hierarchical",
        "Hyndman, Ahmed, Athanasopoulos & Shang (2011)"
      ) |>
      add_reference(
        "hts",
        "mint",
        "Wickramasuriya, Athanasopoulos & Hyndman (2019)"
      ) |>
      add_reference(
        "lookout",
        "lookout",
        "Kandanaarachchi and Hyndman (2021)"
      ) |>
      add_reference(
        "MEFM",
        "peak-electricity-demand",
        "Hyndman & Fan (2010)"
      ) |>
      add_reference(
        "oddstream",
        "oddstream",
        "Talagala, Hyndman, Smith-Miles, Kandanaarachichi & Muñoz (2020)"
      ) |>
      add_reference(
        "oddwater",
        "oddwater",
        "Talagala, Hyndman, Leigh, Mengersen & Smith-Miles (2019)"
      ) |>
      add_reference("rainbow", "rainbow-fda", "Hyndman & Shang (2010)") |>
      add_reference(
        "seer",
        "fforms",
        "Talagala, Hyndman & Athanasopoulos (2018)"
      ) |>
      add_reference(
        "Rsfar",
        "sfar",
        "Zamani, Haghbin, Hashemi & Hyndman (2001)"
      ) |>
      add_reference("stR", "str", "Dokumentov & Hyndman (2020)") |>
      add_reference(
        "stray",
        "stray",
        "Talagala, Hyndman & Smith-Miles (2021)"
      ) |>
      add_reference(
        "sugrrants",
        "calendar-vis",
        "Wang, Cook & Hyndman (2020)"
      ) |>
      add_reference(
        "thief",
        "temporal-hierarchies",
        "Athanasopoulos et al (2017)"
      ) |>
      add_reference(
        "tsfeatures",
        "icdm2015",
        "Hyndman, Wang & Laptev (2015)"
      ) |>
      add_reference(
        "tsfeatures",
        "ts-feature-space",
        "Kang, Hyndman & Smith-Miles (2017)"
      ) |>
      add_reference("tsibble", "tsibble", "Wang, Cook & Hyndman (2020)") |>
      add_reference("oddnet", "oddnet", "Kandanaarachchi & Hyndman (2022)")

    packages <- left_join(packages, references)

    # Improved titles for books and others
    extended_titles <- tribble(
      ~package,
      ~alt_title,
      "compenginets",
      "Time series data from <a href='https://www.comp-engine.org/'>comp-engine.org</a>",
      "expsmooth",
      "Data sets from <a href='http://www.exponentialsmoothing.net/'>Hyndman, Koehler, Ord & Snyder (2008), <i>Forecasting with exponential smoothing: the state space approach</i>, Springer</a>",
      "fma",
      "Data sets from <a href='https://robjhyndman.com/forecasting/'>Makridakis, Wheelwright & Hyndman (1998), <i>Forecasting: methods and applications</i>, Wiley</a>",
      "fpp2",
      "Data sets from <a href='https://OTexts.com/fpp2'>Hyndman & Athanasopoulos (2018) <i>Forecasting: principles and practice</i>, 2nd edition, OTexts</a>",
      "fpp3",
      "Data sets from <a href='https://OTexts.com/fpp3'>Hyndman & Athanasopoulos (2021) <i>Forecasting: principles and practice</i>, 3rd edition, OTexts</a>",
      "weird",
      "Functions and data sets from <a href='https://OTexts.com/weird/'>Hyndman (2024) <i>That's weird: anomaly detection using R</i>, OTexts</a>",
    )
    packages <- packages |>
      left_join(extended_titles, by = "package") |>
      mutate(title = if_else(is.na(alt_title), title, alt_title))

    # Exclude packages I haven't had much to do with or are outdated or archived
    packages <- packages |>
      filter(
        !package %in%
          c(
            "anomalous",
            "bayesforecast",
            "DescTools",
            "fracdiff",
            "nortsTest",
            "rmarkdown",
            "robets",
            "smoothAPC",
            "fpp"
          )
      )

    # Add in section information
    packages <- packages |>
      arrange(package) |>
      add_section(
        "Tidy time series analysis and forecasting",
        c(
          "tsibble",
          "tsibbledata",
          "ggtime",
          "feasts",
          "fable",
          "fabletools",
          "fable.binary",
          "fasster",
          "sugrrants",
          "gravitas"
        )
      ) |>
      add_section(
        "Other time series analysis and forecasting",
        c(
          "bfast",
          "conduits",
          "forecast",
          "gratis",
          "hts",
          "MEFM",
          "seer",
          "stR",
          "thief",
          "tsfeatures"
        )
      ) |>
      add_section(
        "Time series data",
        c(
          "compenginets",
          "expsmooth",
          "fma",
          "fpp2",
          "fpp3",
          "Mcomp",
          "ozdata",
          "tscompdata",
          "tsdl"
        )
      ) |>
      add_section(
        "Anomaly detection",
        c(
          "lookout",
          "stray",
          "oddstream",
          "oddwater",
          "oddnet",
          "weird"
        )
      ) |>
      add_section(
        "Functional data and demography",
        c(
          "addb",
          "demography",
          "fds",
          "ftsa",
          "rainbow",
          "Rsfar",
          "vital"
        )
      ) |>
      add_section(
        "Rmarkdown",
        c(
          "binb",
          "monash",
          "rticles",
          "vitae"
        )
      ) |>
      replace_na(list(section = "Other"))
    # Put other packages last
    packages <- bind_rows(
      packages |> filter(section != "Other"),
      packages |> filter(section == "Other"),
    )
    # Save result
    saveRDS(packages, file = here::here("software/packages.rds"))
    return(packages)
  }
}

quarto_extension <- function(repo, description) {
  section_id <- paste0("monash-", repo, "-template")
  repo_url <- paste0("https://github.com/quarto-monash/", repo)
  section <- paste(
    "Monash",
    tools::toTitleCase(if (repo == "workingpaper") "Working paper" else repo),
    "Template"
  )
  img <- paste0(
    repo_url,
    "/raw/main/examples/",
    if (repo == "presentation") "pdftemplate" else "template",
    ".png"
  )
  cat(
    "<table>\n<tr>\n<td><a href='",
    repo_url,
    "'><img src='",
    img,
    "' class='img-fluid' width=120></a></td>\n<td valign='top' width='85%'>\n\n### [",
    section,
    "](",
    repo_url,
    ")\n\n",
    description,
    ".\n\n<pre><code>quarto use template quarto-monash/",
    repo,
    "</code></pre></td>\n</tr>\n</table>",
    sep = ""
  )
}
