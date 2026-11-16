---
author: Rob J Hyndman, David T Frazier
date: 2026-11-16
title: "Anomaly detection using surprisals"
categories: Working papers
tags:
  - data science
  - anomaly detection
github: robjhyndman/surprisal_theory
link: https://github.com/robjhyndman/Surprisal_Theory/raw/main/surprisals_R1.pdf
arxiv: 2603.09318
bibkey: surprisals
---

Anomaly detection methods are widely used but often rely on ad hoc rules or strong assumptions, and they often focus on tail events, missing “inlier” anomalies that occur in low-density gaps between modes.
We propose a unified framework that defines an anomaly as an observation with unusually low probability under a (possibly mis-specified) model.
For each observation we compute its surprisal (the negative log generalized density) and define an anomaly score as the probability of a surprisal at least as large as that observed.
This reduces anomaly detection for complex univariate or multivariate data to estimating the upper tail of a univariate surprisal distribution.
We develop two model-robust approximations to these tail probabilities: an empirical approximation based on the observed surprisal distribution and a GPD approximation that fits a Generalized Pareto Distribution above a high threshold.
For the empirical approximation we give conditions under which tail ordering is preserved and derive finite-sample confidence guarantees via the Dvoretzky--Kiefer--Wolfowitz inequality.
For the GPD approximation we establish broad tail conditions ensuring classical extreme-value behavior.
Simulations and applications to French mortality, Test-cricket and Old Faithful geyser data show the approach remains effective under substantial model mis-specification.

The R package [**weird**](https://pkg.robjhyndman.com/weird) implements the methods described in this paper.
