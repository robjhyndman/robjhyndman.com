---
author: Rob J Hyndman, Sevvandi Kandanaarachchi, Katharine Turner
date: 2026-01-31
slug: lookout2
title: "When lookout sees crackle: Anomaly detection via kernel density estimation"
categories: Working papers
details: in preparation
tags:
- data science
- anomaly detection
github: robjhyndman/lookout2
link: https://github.com/robjhyndman/lookout2/raw/main/main.pdf
---

We present an updated version of *lookout* --- an algorithm for detecting anomalies using kernel density estimates with bandwidth based on Rips death diameters --- with theoretical guarantees. The kernel density estimator for updated *lookout* is shown to be consistent, and the proposed multivariate scaling is robust and efficient. We show our updated algorithm performs better than the previous version on diverse examples.

The R package [**lookout**](https://github.com/Sevvandi/lookout) implements this algorithm.
