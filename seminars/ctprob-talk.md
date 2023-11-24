---
date: 2023-12-08
title: "Probabilistic cross-temporal forecast reconciliation"
venue: "International Association of Statistical Computing: Asian Regional Section Conference 2023"
link: https://github.com/robjhyndman/ctprob-talk/raw/main/iasc_2023.pdf
---

## Abstract

Forecast reconciliation is a post-forecasting process that involves transforming a set of incoherent forecasts into coherent forecasts which satisfy a given set of linear constraints for a multivariate time series. We extend the current state-of-the-art cross-sectional probabilistic forecast reconciliation approach to encompass a cross-temporal framework, where temporal constraints are also applied. Our proposed methodology employs both parametric Gaussian and non-parametric bootstrap approaches to draw samples from an incoherent cross-temporal distribution. To improve the estimation of the forecast error covariance matrix, we propose using multi-step residuals, especially in the time dimension where the usual one-step residuals fail. We evaluate the proposed methods through a detailed simulation study that investigates their theoretical and empirical properties. We further assess the effectiveness of the proposed cross-temporal reconciliation approach by applying it to two empirical forecasting experiments, using the Australian GDP and the Australian Tourism Demand datasets. For both applications, we show that the optimal cross-temporal reconciliation approaches significantly outperform the incoherent base forecasts in terms of the Continuous Ranked Probability Score and the Energy Score. Overall, our study expands and unifies the notation for cross-sectional, temporal and cross-temporal reconciliation, thus extending and deepening the probabilistic cross-temporal framework. The results highlight the potential of the proposed cross-temporal forecast reconciliation methods in improving the accuracy of probabilistic forecasting models.

## Associated paper

[Girolimetto, Athansopoulos, Di Fonzo, Hyndman (2024) "Cross-temporal probabilistic forecast reconciliation: Methodological and practical issues", *International Journal of Forecasting*, to appear.](https://robjhyndman.com/publications/ctprob.html)


## Software

* [FoReco package for R](https://danigiro.github.io/FoReco/)

## Slides for IASC-ARS 2023
