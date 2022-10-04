---
author: Rob J Hyndman
Status: Published
date: 2006-09-16 04:29:45+00:00
slug: another-look-at-measures-of-forecast-accuracy-for-intermittent-demand
title: Another look at measures of forecast accuracy for intermittent demand
categories: Articles
tags:
- accuracy
- forecasting
- time series
details: "<em>Foresight: the International Journal of Applied Forecasting</em> <b>4</b>, 43-46"
file: foresight.pdf
---

Some of the proposed measures of forecast accuracy for intermittent demand can give infinite or undefined values. This makes them unsuitable for general use. I summarize the various measures and demonstrate what can go wrong. Then I describe a new measure (the mean absolute scaled error) which does not have these flaws. I believe it should become the standard measure for comparing forecast accuracy for multiple intermittent-demand series.

**Errata:** In the series shown in Table 2, the sixth value should be 11 (not 1). Similarly, the fifth error value should be 11 (not 1).

**Sample calculations:** [Excel spreadsheet showing MASE calculation for the example series.](https://robjhyndman.com/files/MASE.xls)

**Data:** [Data used in examples.](https://robjhyndman.com/files/HKdata.xls)
