---
author: Rob J. Hyndman, Mohsen B Mesgaran, Roger D Cousens
Status: Published
comments: false
date: 2015-08-07 04:00:48+00:00
slug: lagphase
title: Statistical issues with using herbarium data for the estimation of invasion lag-phases
aliases:
  - /lagphase/
kind: article
tags:
  - ecology
details: <em>Biological Invasions</em> <b>17</b>(12), 3371-3381
doi: 10.1007/s10530-015-0962-8
file: lagphase.pdf
---

Current methods for using herbarium data as time series, for example to estimate the length of the invasion lag phase, often make assumptions that are both statistically and logically inappropriate. We present an alternative statistical approach, estimating the lag phase based on annual rather than cumulative data, a generalized linear model incorporating a log link for overall collection effort, and piecewise linear splines. We demonstrate the method on two species representing good and poor data quality, then apply it to two data sets comprising 448 species/region combinations. Significant lags were detected in only 28 and 40 % of time series, a much lower level than the 95 and 77 % found in previous analyses of the same data. In a case with high quality data, a lag was concluded even though during the “lag” the locations of herbarium collections indicated that it was spreading rapidly at a continental scale. In species with few records, results were sensitive to the way in which zeroes were included. Overall, our method gives very good fit to the data, avoids unrealistic assumptions of other methods and gives more reliable estimates of confidence. However, given the poor representation of herbarium samples in the early stages of invasions and the fact that they do not constitute a structured survey of abundance, we warn against over-reliance on statistical analysis of such data to reach conclusions about the dynamics of invasions.

[R code](/Rfiles/lagphase.R)
