---
author: Priyanga Dilini Talagala, Rob J Hyndman, Kate Smith&#8209;Miles
date: 2021-01-01
title: "Anomaly detection in high-dimensional data"
categories: Articles
arxiv: "1908.04000"
tags:
  - data science
  - anomaly detection
  - time series
bibkey: stray
---

The HDoutliers algorithm is a powerful unsupervised algorithm for detecting anomalies in high-dimensional data, with a strong theoretical foundation.
However, it suffers from some limitations that significantly hinder its performance level, under certain circumstances.
In this article, we propose an algorithm that addresses these limitations.
We define an anomaly as an observation that deviates markedly from the majority with a large distance gap.
An approach based on extreme value theory is used for the anomalous threshold calculation.
Using various synthetic and real datasets, we demonstrate the wide applicability and usefulness of our algorithm, which we call the stray algorithm.
We also demonstrate how this algorithm can assist in detecting anomalies present in other data structures using feature engineering.
We show the situations where the stray algorithm outperforms the HDoutliers algorithm both in accuracy and computational time.

[R implementation](https://github.com/pridiltal/stray).

[Python implementation](https://www.sktime.net/docs/api-reference/sktimedetectionstraystray/)
