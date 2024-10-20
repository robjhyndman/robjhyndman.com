---
title: "Online conformal inference for multi-step time series forecasting"
date: "2024-10-18"
author: Xiaoqian Wang, Rob&nbsp;J&nbsp;Hyndman
github: xqnwang/cpts
link: https://github.com/xqnwang/cpts/raw/main/paper/cpts.pdf
categories: Working papers
---

We consider the problem of constructing distribution-free prediction intervals for multi-step time series forecasting, with a focus on the temporal dependencies inherent in multi-step forecast errors. We establish that the optimal $h$-step-ahead forecast errors exhibit serial correlation up to lag $(h-1)$ under a general non-stationary autoregressive data generating process. To leverage these properties, we propose the Autocorrelated Multi-step Conformal Prediction (AcMCP) method, which effectively incorporates autocorrelations in multi-step forecast errors, resulting in more statistically efficient prediction intervals. This method ensures theoretical long-run coverage guarantees for multi-step prediction intervals, though we note that increased forecasting horizons may exacerbate deviations from the target coverage, particularly in the context of limited sample sizes. Additionally, we extend several easy-to-implement conformal prediction methods, originally designed for single-step forecasting, to accommodate multi-step scenarios. Through empirical evaluations, including simulations and applications to data, we demonstrate that AcMCP achieves coverage that closely aligns with the target within local windows, while providing adaptive prediction intervals that effectively respond to varying conditions.

**R package**: [conformalForecast](https://github.com/xqnwang/conformalForecast)