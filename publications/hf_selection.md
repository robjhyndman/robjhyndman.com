---
title: "Optimal forecast reconciliation with time series selection"
date: "2025-01-01"
author: Xiaoqian Wang, Rob&nbsp;J&nbsp;Hyndman, Shanika L Wickramasuriya
link: https://github.com/xqnwang/hfs/raw/main/paper/hf_selection.pdf
categories: Articles
details: "<em>European J Operational Research</em>, to appear"
github: xqnwang/hfs
doi: 10.1016/j.ejor.2024.12.004
---

Forecast reconciliation ensures forecasts of time series in a hierarchy adhere to aggregation constraints, enabling aligned decision making. While forecast reconciliation can enhance overall accuracy in a hierarchical or grouped structure, it can lead to worse forecasts for certain series, with the greatest gains typically seen in series that originally have poorly performing base forecasts. In practical applications, some series in a structure often produce poor base forecasts due to model misspecification or low forecastability. To mitigate their negative impact, we propose two categories of forecast reconciliation methods that incorporate automatic time series selection based on out-of-sample and in-sample information, respectively. These methods keep “poor” base forecasts unused in forming reconciled forecasts, while adjusting the weights assigned to the remaining series accordingly when generating bottom-level reconciled forecasts. Additionally, our methods ameliorate disparities stemming from varied estimators of the base forecast error covariance matrix, alleviating challenges associated with estimator selection. Empirical evaluations through two simulation studies and applications using Australian labour force and domestic tourism data demonstrate the potential of the proposed methods to exclude series with high scaled forecast errors and show promising results.
