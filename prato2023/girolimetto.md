---
title: "Cross-temporal probabilistic forecast reconciliation"
---

## Presenter

<div class = "figure">
[Daniele Girolimetto](https://danigiro.github.io), University of Padova, Italy
<img src="/img/danielegiro.png"  width=200px height=200px style="float:left">
</div>

## Abstract

Forecast reconciliation is a post-forecasting process that involves transforming a set of incoherent forecasts into coherent forecasts which satisfy a given set of linear constraints for a multivariate time series. In this work we extend the current state-of-the-art cross-sectional probabilistic forecast reconciliation approach to encompass a cross-temporal framework, where temporal constraints are also applied. Our proposed methodology employs both parametric Gaussian and non-parametric bootstrap approaches to draw samples from an incoherent cross-temporal distribution. To improve the estimation of the forecast error covariance matrix, we propose using multi-step residuals, especially in the time dimension where the usual one-step residuals fail. To address high-dimensionality issues, we present four alternatives for the covariance matrix, where we exploit the two-fold nature (cross-sectional and temporal) of the cross-temporal structure, and introduce the idea of overlapping residuals. We assess the effectiveness of the proposed cross-temporal reconciliation approaches through a simulation study that investigates their theoretical and empirical properties and two forecasting experiments, using the Australian GDP and the Australian Tourism Demand datasets. For both applications, the optimal cross-temporal reconciliation approaches significantly outperform the incoherent base forecasts in terms of the Continuous Ranked Probability Score and the Energy Score. Overall, the results highlight the potential of the proposed methods to improve the accuracy of probabilistic forecasts and to address the challenge of integrating disparate scenarios while coherently taking into account short-term operational, medium-term tactical, and long-term strategic planning.

[**Associated paper**](https://arxiv.org/abs/2303.17277)

## Discussant

<div class = "figure">
[Casey Lichtendahl](https://www.linkedin.com/in/casey-lichtendahl-7a2688102), Google, USA
<img src=/img/casey.png width=200px height=200px style="float:left">
</div>
