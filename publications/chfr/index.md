---
author: Mahdi Abolghasemi, Rob J Hyndman, Evangelos Spiliotis, Christoph Bergmeir
date: 2022-01-14
slug: chfr
title: "Model selection in reconciling hierarchical time series"
kind: article
details: <em>Machine Learning</em>, <b>111</b>, 739–789
tags:
- hierarchical forecasting
- forecasting
- time series
arxiv: 2010.10742
doi: 10.1007/s10994-021-06126-z
---

Model selection has been proven an effective strategy for improving accuracy in time series forecasting applications. However, when dealing with hierarchical time series, apart from selecting the most appropriate forecasting model, forecasters have also to select a suitable method for reconciling the base forecasts produced for each series to make sure they are coherent. Although some hierarchical forecasting methods like minimum trace are strongly supported both theoretically and empirically for reconciling the base forecasts, there are still circumstances under which they might not produce the most accurate results, being outperformed by other methods. In this paper we propose an approach for dynamically selecting the most appropriate hierarchical forecasting method and succeeding better forecasting accuracy along with coherence. The approach, to be called conditional hierarchical forecasting, is based on Machine Learning classification methods and uses time series features as leading indicators for performing the selection for each hierarchy examined considering a variety of alternatives. Our results suggest that conditional hierarchical forecasting leads to significantly more accurate forecasts than standard approaches, especially at lower hierarchical levels.
