---
title: "Optimal forecast reconciliation with time series selection"
date: "2024-03-06"
author: Xiaoqian Wang, Rob&nbsp;J&nbsp;Hyndman, Shanika L Wickramasuriya
link: https://www.monash.edu/__data/assets/pdf_file/0003/3611901/Optimal-forecast-reconciliation-with-time-series-selection.pdf
categories: Working papers
---

Forecast reconciliation ensures forecasts of time series in a hierarchy adhere to aggregation constraints, enabling aligned decision-making. While forecast reconciliation can enhance overall accuracy in hierarchical or grouped structures, the most substantial improvements occur in series with initially poor-performing base forecasts. Nevertheless, certain series may experience deteriorations in reconciled forecasts. In practical settings, series in a structure often exhibit poor base forecasts due to model misspecification or low forecastability. To prevent their negative impact, we propose two categories of forecast reconciliation methods that incorporate time series selection based on out-of-sample and in-sample information, respectively. These methods keep “poor” base forecasts unused in forming reconciled forecasts, while adjusting weights allocated to the remaining series accordingly when generating bottom-level reconciled forecasts. Additionally, our methods ameliorate disparities stemming from varied estimates of the base forecast error covariance matrix, alleviating challenges associated with estimator selection. Empirical evaluations through two simulation studies and applications using Australian labour force and domestic tourism data demonstrate improved forecast accuracy, particularly evident in higher aggregation levels, longer forecast horizons, and cases involving model misspecification.
