---
date: 2022-09-23
title: "Visualization of complex seasonal patterns in time series"
venue: University of Padua, Italy
youtube: mEz81ZTvMZ8
---

### [University of Padova 800th anniversary conference](https://800years.stat.unipd.it/), 21-23 September 2023.

Time series data often contains a rich complexity of seasonal patterns. Time series that are observed at a sub-daily level can exhibit multiple seasonal patterns corresponding to different granularities. Seasonal granularities can be circular such as hour-of-the-day, day-of-the-week or month-of-the-year; or quasi-circular such as day-of-the-month. They can be nested (e.g., hour-of-the-day within day-of-the-week) and non-nested (e.g., day-of-the-year in both the Gregorian and Hijri calendars). They can also follow irregular topologies induced by public holidays and other aperiodic events. Available tools to visualize, model and forecast these seasonal patterns are currently very limited. I will discuss two new time series decomposition tools for handling seasonal data: MSTL and STR. These allow for multiple seasonal and cyclic components, covariates, seasonal patterns that may have non-integer periods, and seasonality with complex topology. They can be used for time series with any regular time index including hourly, daily, weekly, monthly or quarterly data, but tackle many more decomposition problems than other methods allow. I will also demonstrate some new tools to assist in visualizing seasonal patterns in time series, emphasising changes in the conditional distribution with respect to different time granularities. The granularities form categorical variables (ordered or unordered) which induce groupings of the observations. The resulting graphics are then displays of conditional distributions compared across combinations of these categorical variables. These are implemented in the gravitas package for R.

### Slides

<iframe src="https://pkg.robjhyndman.com/complex_seasonality_talk/padova2022.html" width="100%" height=350>
</iframe>

[Open](https://pkg.robjhyndman.com/complex_seasonality_talk/padova2022.html){.badge .badge-red}
[{{< fa brands github >}} Code](https://github.com/robjhyndman/complex_seasonality_talk/){.badge .badge-green}

### Associated papers

* [Sayani Gupta, Rob J Hyndman, Dianne Cook and Antony Unwin (2022) Visualizing probability distributions across bivariate cyclic temporal granularities. *J Computational & Graphical Statistics*, **31**(1), 14-25. robjhyndman.com/publications/gravitas/](/publications/gravitas/)
* [Sayani Gupta, Rob J Hyndman, Dianne Cook (2021) Detecting distributional differences between temporal granularities for exploratory time series analysis. working paper. robjhyndman.com/publications/hakear/](/publications/hakear/)
* [Kasun Bandara, Rob J Hyndman, Christoph Bergmeir (2022) MSTL: A Seasonal-Trend Decomposition Algorithm for Time Series with Multiple Seasonal Patterns. *International J Operational Research*, to appear. robjhyndman.com/publications/mstl/](/publications/mstl/)
* [Alex Dokumentov and Rob J Hyndman (2022) STR: Seasonal-Trend decomposition using Regression. *INFORMS Journal on Data Science*, <b>1</b>(1), 50-62. robjhyndman.com/publications/str/](/publications/str/)

### R packages

<a href="https://cran.r-project.org/package=gravitas"><img src="https://github.com/Sayani07/gravitas/raw/master/man/figures/logo.png" width=80></a><a href="https://github.com/Sayani07/hakear"><img src = "/software/stickers/hakear.png" width=80></a><a href="https://pkg.robjhyndman.com/forecast"><img src = "https://pkg.robjhyndman.com/forecast/reference/figures/logo.png" width=80></a><a href="https://feasts.tidyverts.org"><img src = "http://feasts.tidyverts.org/reference/figures/logo.png" width=80></a><a href="https://cran.r-project.org/package=stR"><img src = "https://robjhyndman.com/software/stickers/stR.png" width=80></a>
