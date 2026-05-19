---
title: "Multivariate reconciliation for hierarchical time series"
date: "2026-05-18"
author: Ana Caroline Pinheiro, Rodrigo de Souza Bulhões, Rob J Hyndman, Paulo Canas Rodrigues
arxiv: "2605.17920"
github: robjhyndman/mvhts
link: https://github.com/robjhyndman/mvhts/raw/main/multivariate-reconciliation.pdf
categories: Working papers
tags:
- forecasting
- hierarchical time series
- reconciliation
- multivariate
---

Some time series can be hierarchically organized into levels based on certain characteristics, such as geography or other attributes of interest. These series are referred to as hierarchical time series. Typically, forecasts are generated at all levels to ensure coherence, meaning that the forecasts should satisfy the same aggregation constraints as the observed data. Various approaches have been proposed to guarantee this coherence by using a set of base forecasts. The process through which these forecasts are adjusted to become coherent is known as forecast reconciliation. Similar to the univariate case, multivariate time series can also be structured hierarchically. However, all existing approaches are limited to a single variable. As a result, ensuring coherent forecasts requires reconciling each variable separately. However, this process does not account for correlations among multiple variables. To address this limitation, this paper proposes a multivariate reconciliation methodology that ensures coherent forecasts and incorporates relationships among variables. The proposed methodology was tested through numerical simulations, considering distinct scenarios within the series hierarchy and across multiple variables. Additionally, some base forecasting models were evaluated. The methodology was also applied to real employment data of admissions and dismissals in Brazil. The results demonstrated that multivariate reconciliation yielded more accurate outcomes than the other methods considered, both in simulated data and in practical applications.
