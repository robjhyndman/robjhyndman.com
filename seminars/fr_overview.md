---
date: 2023-09-11
title: "Forecast reconciliation: a brief overview"
venue: Zalando, Berlin, Germany
bibliography: hts.bib
link: https://github.com/robjhyndman/fr_overview_talk/raw/main/fr_overview.pdf
---

## Abstract

Collections of time series that are formed via aggregation are prevalent in many fields. These are commonly referred to as hierarchical time series and may be constructed cross-sectionally across different variables, temporally by aggregating a single series at different frequencies, or may even be generalised beyond aggregation as time series that respect linear constraints. When forecasting such time series, a desirable condition is for forecasts to be coherent, that is to respect the constraints. The past decades have seen substantial growth in this field with the development of reconciliation methods that not only ensure coherent forecasts but can also improve forecast accuracy. This talk provides an overview of recent work on forecast reconciliation.

## Associated paper

[Athanasopoulos, G, RJ Hyndman, N Kourentzes, and A Panagiotelis. 2023. “Forecast Reconciliation: A Review”](http://robjhyndman.com/publications/hfreview.html).


## Software

* [hts package for R](https://pkg.earo.me/hts/)
* [thief package for R](http://pkg.robjhyndman.com/thief/)
* [fable package for R](https://fable.tidyverts.org)
* [FoReco package for R](https://danigiro.github.io/FoReco/)
* [hierarchicalforecast library for Python](https://nixtla.github.io/hierarchicalforecast/)
* [pyhts library for Python](https://angelpone.github.io/)
