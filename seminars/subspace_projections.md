---
date: 2024-09-19
title: "Improving forecasts via subspace projections"
venue: Various
bibliography: hts.bib
aliases:
    - /curtin2024
    - /srilanka2024
    - /amazon2025
    - /vienna2025
    - /ifs2025

nocite: |
   - @hierarchical
   - @mint
   - @htsgeometry
   - @wickramasuriya2021properties
   - @coherentprob
   - @temporal-hierarchies
   - @ctprob
   - @flap
---

## Abstract

Univariate, multivariate, and hierarchical forecasts can all be improved using projections onto linear subspaces, regardless of what forecasting method is used. I will show some theoretical guarantees of this statement, and demonstrate using empirical applications how linear projections can lead to (sometimes dramatic) improvements in forecast accuracy.

The procedure involves creating new time series that are linear combinations of the observed time series. These are then forecast, along with the original series, and all forecasts are adjusted via a projection matrix to ensure they satisfy the linear constraints.

This procedure is now widely used for hierarchical forecasting. It has the potential to revolutionise multivariate forecasting as well.

## Given at

* Curtin University, Perth, Australia: 19 September 2024
* [International Statistics Conference 2024](https://isc24.iassl.lk), Sri Lanka: 28 December 2024
* Amazon “Forecasting, Macroeconomics & Finance” seminar, online: 21 February 2025
* [3rd Vienna Workshop on Economic Forecasting](https://www.ihs.ac.at/events/conference-series/forecasting-workshop/vienna-workshop-on-economic-forecasting-2025/), Institute for Advanced Studies, Vienna, Austria: 6 June 2025
* [International Forum on Statistics](http://ifs.ruc.edu.cn/dsjsy/dsjEN/index.htm), Renmin University, China: 5 July 2025

## Slides (Sri Lanka)

<iframe src="https://docs.google.com/gview?url=https://github.com/robjhyndman/subspace_projections_talk/raw/main/subspace_projections.pdf&embedded=true"  width="100%" height=465></iframe>
<a href="https://github.com/robjhyndman/subspace_projections_talk/raw/main/subspace_projections.pdf" class="badge badge-small badge-red">Download pdf</a>

* [Curtin](https://github.com/robjhyndman/subspace_projections_talk/raw/main/subspace_curtin.pdf)
* [Amazon](https://github.com/robjhyndman/subspace_projections_talk/raw/main/subspace_amazon.pdf)
* [Vienna](https://github.com/robjhyndman/subspace_projections_talk/raw/main/subspace_vienna.pdf)
* [Renmin](https://github.com/robjhyndman/subspace_projections_talk/raw/main/subspace_renmin.pdf)

## Software

* [hts package for R](https://pkg.earo.me/hts/)
* [thief package for R](http://pkg.robjhyndman.com/thief/)
* [fable package for R](https://fable.tidyverts.org)
* [FoReco package for R](https://danigiro.github.io/FoReco/)
* [flap package for R](https://cran.r-project.org/package=flap)
* [hierarchicalforecast library for Python](https://nixtla.github.io/hierarchicalforecast/)
* [pyhts library for Python](https://angelpone.github.io/)
