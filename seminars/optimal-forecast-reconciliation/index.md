---
author: Rob&nbsp;J&nbsp;Hyndman
comments: false
venue: Stanford University, USA
date: 2015-10-06 05:49:18+00:00
slug: optimal-forecast-reconciliation
title: Optimal forecast reconciliation for big time series data
wordpress_id: 3499
figshare: 1566647
---

## Seminar given at Stanford University on 6th October, and University of California (Davis) on 8th October.

Time series can often be naturally disaggregated in a hierarchical or grouped structure. For example, a manufacturing company can disaggregate total demand for their products by country of sale, retail outlet, product type, package size, and so on. As a result, there can be millions of individual time series to forecast at the most disaggregated level, plus additional series to forecast at higher levels of aggregation.

A common constraint is that the disaggregated forecasts need to add up to the forecasts of the aggregated data. This is known as forecast reconciliation. I will show that the optimal reconciliation method involves fitting an ill-conditioned linear regression model where the design matrix has one column for each of the series at the most disaggregated level. For problems involving huge numbers of series, the model is impossible to estimate using standard regression algorithms. I will also discuss some fast algorithms for implementing this model that make it practicable for implementing in business contexts.
