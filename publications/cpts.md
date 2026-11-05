---
title: "Online conformal inference for multi-step time series forecasting"
date: "2026-11-05"
author: Xiaoqian Wang, Rob J Hyndman
github: xqnwang/cpts
link: https://github.com/xqnwang/cpts/raw/main/paper/cpts.pdf
arxiv: 2410.13115
categories: Working papers
bibkey: cpts
---

We study the construction of distribution-free prediction intervals for multi-step time series forecasting.
In this setting, forecast errors at different horizons are serially dependent, and feedback is delayed, since the error of an $h$-step-ahead forecast becomes available only after $h$ periods.
We propose autocorrelated multi-step conformal prediction (AcMCP), an online procedure that accommodates delayed feedback and explicitly incorporates the dependence among multi-step forecast errors into conformal calibration.
To characterize this dependence, we derive first-order representations of the optimal forecast errors under a general nonstationary autoregressive data-generating process, with explicit bounds on remainder terms.
AcMCP guarantees long-run coverage of at least the nominal level at every horizon, without requiring exchangeability or any assumption on how the data distribution evolves over time.
We also establish a finite-sample bound on the empirical coverage shortfall, which depends on the forecast horizon and the evaluation sample size.
Notably, these guarantees do not rely on the accuracy of the linear approximations.
Simulations and real-data applications show that AcMCP adapts to time-varying dynamics and maintains rolling coverage close to the nominal level.
By exploiting the dependence among multi-step errors, it often yields narrower intervals than its counterpart without this dependence, with similar coverage, particularly at longer horizons.

**R package**: [conformalForecast](https://xqnwang.github.io/conformalForecast/)
