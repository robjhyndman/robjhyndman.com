---
date: 2022-08-23
venue: COMPSTAT 2022, Bologna, Italy
title: Decomposing time series with complex seasonality
slug: compstat2022
---

## [COMPSTAT 2022](http://www.compstat2022.org), Bologna, Italy, 23-26 August 2022.

Time series data often contain a rich complexity of seasonal patterns. Time series that are observed at a sub-daily level can exhibit multiple seasonal patterns corresponding to different granularities such as hour-of-the-day, day-of-the-week or month-of-the-year. They can be nested (e.g., hour-of-the-day within day-of-the-week) and non-nested (e.g., day-of-the-year in both the Gregorian and Hijri calendars). We will discuss two new time series decomposition tools for handling seasonalities in time series data: MSTL and STR. These allow for multiple seasonal and cyclic components, covariates, seasonal patterns that may have non-integer periods, and seasonality with complex topology. They can be used for time series with any regular time index including hourly, daily, weekly, monthly or quarterly data, but tackle many more decomposition problems than other methods allow.

## Slides

<iframe src="https://pkg.robjhyndman.com/complex_seasonality_talk/compstat2022.html" width="100%" height=350>
</iframe>

[Open](https://pkg.robjhyndman.com/complex_seasonality_talk/compstat2022.html){.badge .badge-red}
[{{< fa brands github >}} Code](https://github.com/robjhyndman/complex_seasonality_talk/){.badge .badge-green}

<br>

## Associated papers:

* Kasun Bandara, Rob J Hyndman, Christoph Bergmeir (2022) MSTL: A Seasonal-Trend Decomposition Algorithm for Time Series with Multiple Seasonal Patterns. *International J Operational Research*, to appear. [robjhyndman.com/publications/mstl/](https://robjhyndman.com/publications/mstl/)
* Alex Dokumentov and Rob J Hyndman (2022) STR: Seasonal-Trend decomposition using Regression. *INFORMS Journal on Data Science*, to appear. [robjhyndman.com/publications/str/](https://robjhyndman.com/publications/str/)

## R functions:

* [`forecast::mstl()`](https://pkg.robjhyndman.com/forecast/reference/mstl.html)
* [`feasts::STL()`](https://feasts.tidyverts.org/reference/STL.html)
* [`stR::AutoSTR()`](https://rdrr.io/cran/stR/man/AutoSTR.html)
* [`stR::STR()`](https://rdrr.io/cran/stR/man/STR.html)
