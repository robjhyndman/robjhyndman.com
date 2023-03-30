---
title: "Cross-temporal Probabilistic Forecast Reconciliation"
date: "2023-03-31"
author:  Daniele Girolimetto, George Athanasopoulos, Tommaso Di Fonzo, Rob J Hyndman
github: daniGiro/ctprob
link: https://github.com/danigiro/ctprob/raw/main/paper/CTprob.pdf
categories: Working papers
---

Forecast reconciliation is a post-forecasting process that involves transforming a set of incoherent forecasts into coherent forecasts which satisfy a given set of linear constraints for a multivariate time series. In this paper we extend the current state-of-the-art cross-sectional probabilistic forecast reconciliation approach to encompass a cross-temporal framework, where temporal constraints are also applied. Our proposed methodology employs both parametric Gaussian and non-parametric bootstrap approaches to draw samples from an incoherent cross-temporal distribution.
To improve the estimation of the forecast error covariance matrix, we propose using multi-step residuals, especially in the time dimension where the usual one-step residuals fail.
To address high-dimensionality issues, we present four alternatives for the covariance matrix, where we exploit the two-fold nature (cross-sectional and temporal) of the cross-temporal structure, and introduce the idea of overlapping residuals. We evaluate the proposed methods through a detailed simulation study that investigates their theoretical and empirical properties. We further assess the effectiveness of the proposed cross-temporal reconciliation approach by applying it to two empirical forecasting experiments, using the Australian GDP and the Australian Tourism Demand datasets. For both applications, we show that the optimal cross-temporal reconciliation approaches significantly outperform the incoherent base forecasts in terms of the Continuous Ranked Probability Score and the Energy Score. Overall, our study expands and unifies the notation for cross-sectional, temporal and cross-temporal reconciliation, thus extending and deepening the probabilistic cross-temporal framework. The results highlight the potential of the proposed cross-temporal forecast reconciliation methods in improving the accuracy of probabilistic forecasting models.
