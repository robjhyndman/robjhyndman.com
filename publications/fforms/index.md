---
author: Thiyanga S Talagala, Rob J Hyndman, George Athanasopoulos
date: 2023-01-31
slug: fforms
title: Meta-learning how to forecast time series
categories: Articles
details: "<em>J Forecasting</em>, to appear"
tags:
- accuracy
- arima models
- exponential smoothing
- forecasting
- R
- time series
- features
- classification
- algorithm selection
file: fforms.pdf
github: thiyangt/fforms
doi: 10.1002/for.2963
---

Features of time series are useful in identifying suitable models for forecasting. We present a general framework, labelled FFORMS (Feature-based FORecast Model Selection), which selects forecast models based on features calculated from each time series. The FFORMS framework builds a mapping that relates the features of a time series to the “best” forecast model using a classification algorithm such as a random forest. The framework is evaluated using time series from the M-forecasting competitions and is shown to yield forecasts that are almost as accurate as state-of-the-art methods, but are much faster to compute. We use model-agnostic machine learning interpretability methods to explore the results and to study what types of time series are best suited to each forecasting model.

Associated R package: **[seer](https://github.com/thiyangt/seer)**

Shiny app: https://thiyangt.github.io/fformsviz/fforms.html
