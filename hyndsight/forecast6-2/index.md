---
date: 2015-10-20 06:39:21+00:00
link: https://robjhyndman.com/hyndsight/forecast6-2/
slug: forecast6-2
title: forecast package v6.2
categories:
- computing
- forecasting
- R
- time series
---

It is a while since I last updated the [CRAN version of the forecast package](https://cran.r-project.org/package=forecast), so I uploaded the latest version (6.2) today. The [github version](https://github.com/robjhyndman/forecast) remains the most up-to-date version and is already two commits ahead of the CRAN version.

This update is mostly bug fixes and additional error traps. The full ChangeLog is listed below.<!-- more -->



  * Many unit tests added using `testthat`.

  * Fixed bug in `ets()` when very short seasonal series were passed in a data frame.

  * Fixed bug in `nnetar()` where the initial predictor vector was reversed.

  * Corrected model name returned in `nnetar()`.

  * Fixed bug in `accuracy()` when non-integer seasonality used.

  * Made `auto.arima()` robust to non-integer seasonality.

  * Fixed bug in `auto.arima()` where `allowmean` was ignored when `stepwise=FALSE`.

  * Improved robustness of `forecast.ets()` for explosive models with multiplicative trends.

  * Exogenous variables now passed to VAR forecasts

  * Increased maximum `nmse` in `ets()` to 30.

  * Made `tsoutliers()` more robust to weak seasonality

  * Changed `tsoutliers()` to use `supsmu` on non-seasonal and seasonally adjusted data.

  * Fixed bug in `tbats()` when seasonal period 1 is a small multiple of seasonal period 2.

  * Other bug fixes

Thanks to [David Shaub](https://github.com/dashaub) for contributing most of the unit tests.

Please submit bug reports and feature requests to the [github page](https://github.com/robjhyndman/forecast/issues). Don't forget to provide a [minimal reproducible example](https://robjhyndman.com/hyndsight/minimal-reproducible-examples/) for any bug reports.
