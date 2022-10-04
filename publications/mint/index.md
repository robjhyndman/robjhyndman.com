---
author: Shanika L Wickramasuriya, George Athanasopoulos, Rob J Hyndman
Status: Published
date: 2019-06-14
slug: mint
details: "<em>J. American Statistical Association</em>, <b>114</b>(526), 804-819"
aliases:
  - /working-papers/mint
title: Optimal forecast reconciliation for hierarchical and grouped time series through trace minimization
categories: Articles
tags:
- accuracy
- arima models
- exponential smoothing
- forecasting
- hierarchical time series
- optimization
- R
- time series
- tourism
file: mint.pdf
doi: 10.1080/01621459.2018.1448825
---
Large collections of time series often have aggregation constraints due to product or geographical groupings. The forecasts for the most disaggregated series are usually required to add-up exactly to the forecasts of the aggregated series, a constraint we refer to as "coherence". Forecast reconciliation is the process of adjusting forecasts to make them coherent. The reconciliation algorithm proposed by [Hyndman et al. (2011)](/publications/hierarchical/) is based on a generalized least squares estimator that requires an estimate of the covariance matrix of the coherency errors (i.e., the errors that arise due to incoherence). We show that this matrix is impossible to estimate in practice due to identifiability conditions. We propose a new forecast reconciliation approach that incorporates the information from a full covariance matrix of forecast errors in obtaining a set of coherent forecasts. Our approach minimizes the mean squared error of the coherent forecasts across the entire collection of time series under the assumption of unbiasedness. The minimization problem has a closed form solution. We make this solution scalable by providing a computationally efficient representation. We evaluate the performance of the proposed method compared to alternative methods using a series of simulation designs which take into account various features of the collected time series. This is followed by an empirical application using Australian domestic tourism data. The results indicate that the proposed method works well with artificial and real data.
---

Associated R package: **[hts](http://pkg.earo.me/hts/)**

[Download tourism data](/data/TourismData_v3.csv)
