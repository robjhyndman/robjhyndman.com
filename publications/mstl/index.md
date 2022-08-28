---
author: Kasun&nbsp;Bandara, Rob&nbsp;J&nbsp;Hyndman, Christoph&nbsp;Bergmeir
date: 2022-05-09
slug: mstl
title: "MSTL: A Seasonal-Trend Decomposition Algorithm for Time Series with Multiple Seasonal Patterns"
kind: article
details: <i>International J Operational Research</i>, to appear
tags:
- time series
arxiv: 2107.13462
---

The decomposition of time series into components is an important task that helps to understand time series and can enable better forecasting. Nowadays, with high sampling rates leading to high-frequency data (such as daily, hourly, or minutely data), many datasets contain time series data that can exhibit multiple seasonal patterns. Although several methods have been proposed to decompose time series better under these circumstances, they are often computationally inefficient or inaccurate. We propose a procedure to decompose time series with multiple seasonal patterns that is suited to a wide range of high-frequency data. The procedure for Multiple Seasonal Trend decomposition (MSTL) introduced in this paper extends the traditional Seasonal-Trend decomposition using Loess (STL) algorithm, allowing the decomposition of time series with multiple seasonal patterns. In our evaluation on synthetic and a perturbed real-world time series dataset, compared to other decomposition benchmarks, MSTL demonstrates competitive results with lower computational cost. The implementation of MSTL is available in the R packages [forecast](https://pkg.robjhyndman.com/forecast/) and [feasts](https://feasts.tidyverts.org).
