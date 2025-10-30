---
date: 2025-06-30
title: "Forecasting the age structure of the scientific workforce in Australia"
venue: Various
aliases:
  - /isf2025
  - /asc2025
github: robjhyndman/age_structure_forecasts
---

## Abstract

I will demonstrate how to forecast the age structure of a workforce using demographic growth-balance equations that incorporate functional data components for graduate influx, international mobility, retirement, and mortality. This model adapts the stochastic population framework proposed by [Hyndman and Booth (IJF, 2008)](https://robjhyndman.com/publications/stochastic-population-forecasts/), substituting the birth component at age 0 with a graduation process at any age, and integrating retirement dynamics alongside a standard mortality process. It accommodates variable graduate influx, international mobility, and aging, through functional data components.

The model is illustrated by forecasting the future age structure of scientific disciplines in Australia, utilising a variety of data sources. Data limitations are addressed through cohort interpolation and constrained penalised regression splines in order to obtain a workable data set. A combination of local and global ARIMA models is employed to address the temporal dynamics in the time series components.

By forecasting age structures in disciplines such as Physics and Astronomy, Mathematical Sciences, Chemical Sciences, Earth Sciences, and Biological Sciences, the model informs strategic workforce planning and policy development.

This forecasting framework not only aids in strategic planning and policy formulation within the scientific community, but also offers a blueprint for other professional sectors seeking to understand workforce dynamics amid demographic shifts.

## Given at

* [International Symposium on Forecasting 2025](https://isf.forecasters.org/), Beijing, China: 30 June.
* [Australian Statistics Conference 2025](https://www.asc2025.net/), Perth, Australia: 1-5 December 2025.

## Slides

<iframe src="https://docs.google.com/gview?url=https://github.com/robjhyndman/age_structure_forecasts/raw/main/age_structure_talk.pdf&embedded=true"  width="100%" height=465></iframe>

* [ISF 2025 slides](https://github.com/robjhyndman/age_structure_forecasts/raw/63898251377b53a39186e6058b7aebc7a97653db/age_structure_talk.pdf)
* [ASC 2025 slides](https://github.com/robjhyndman/age_structure_forecasts/raw/main/age_structure_talk.pdf)