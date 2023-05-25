---
title: "Conditional normalization in time series analysis"
date: "2023-05-26"
author:  Puwasala Gamakumara, Edgar Santos-Fernandez, Priyanga Dilini Talagala, Rob J Hyndman, Kerrie Mengersen, Catherine Leigh
arxiv: 2305.12651
categories: Working papers
---

Time series often reflect variation associated with other related variables. Controlling for the effect of these variables is useful when modeling or analysing the time series. We introduce a novel approach to normalize time series data conditional on a set of covariates. We do this by modeling the conditional mean and the conditional variance of the time series with generalized additive models using a set of covariates. The conditional mean and variance are then used to normalize the time series. We illustrate the use of conditionally normalized series using two applications involving river network data. First, we show how these normalized time series can be used to impute missing values in the data. Second, we show how the normalized series can be used to estimate the conditional autocorrelation function and conditional cross-correlation functions via additive models. Finally we use the conditional cross-correlations to estimate the time it takes water to flow between two locations in a river network.

[R package: **conduits**](https://github.com/PuwasalaG/conduits)
