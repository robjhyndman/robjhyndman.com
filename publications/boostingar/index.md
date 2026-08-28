---
author: Souhaib Ben Taieb, Rob J Hyndman
date: 2014-01-09 23:00:22+00:00
title: Boosting multi-step autoregressive forecasts
categories: Conference proceedings
tags:
- boosting
- forecasting
- time series
link: https://proceedings.mlr.press/v32/taieb14.html
bibkey: boostingar
details: "<em>Proceedings of The 31st International Conference on Machine Learning</em>, pp. 109–117, Beijing, China. June 2014"
---

Multi-step forecasts can be produced recursively by iterating a one-step model, or directly using a specific model for each horizon. Choosing between these two strategies is not an easy task since it involves a trade-off between bias and estimation variance over the forecast horizon. Using a nonlinear machine learning model makes the tradeoff even more difficult. To address this issue, we propose a new forecasting strategy which boosts traditional recursive linear forecasts with a direct strategy using a boosting autoregression procedure at each horizon. First, we investigate the performance of the proposed strategy in terms of bias and variance decomposition of the error using simulated time series. Then, we evaluate the proposed strategy on real-world time series from two forecasting competitions. Overall, we obtain excellent performance with respect to the standard forecasting strategies.
