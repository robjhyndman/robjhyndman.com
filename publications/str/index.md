---
author: Alex Dokumentov and Rob J Hyndman
date: 2021-06-03
slug: str
title: 'STR: Seasonal-Trend decomposition using Regression'
kind:
 article
details: <em>INFORMS Journal on Data Science</em>, to appear
tags:
- electricity
- forecasting
- nonparametric smoothing
- optimization
- seasonality
- time series
link: https://github.com/robjhyndman/STR_paper/raw/main/str_ijds.pdf
github: robjhyndman/STR_paper
doi: 10.1287/ijds.2021.0004
---

We propose a new method for decomposing seasonal data: STR (a Seasonal-Trend decomposition using Regression). Unlike other decomposition methods, STR allows for multiple seasonal and cyclic components, covariates, seasonal patterns that may have non-integer periods, and seasonality with complex topology. It can be used for time series with any regular time index including hourly, daily, weekly, monthly or quarterly data. It is competitive with existing methods when they exist, but tackles many more decomposition problem than other methods allow.

STR is based on a regularized optimization, and so is somewhat related to ridge regression. Because it is based on a statistical model, we can easily compute confidence intervals for components, something that is not possible with most existing decomposition methods (such as STL, X-12-ARIMA, SEATS-TRAMO, etc.).

Our model is implemented in the R package *stR*, so can be applied by anyone  to their own data.

* [R package](https://cran.r-project.org/package=stR)
