---
title: "Theoretical properties of forecast reconciliation methods"
---

## Presenter

<div class = "figure">
[Shanika Wickramasuriya](https://profiles.auckland.ac.nz/s-wickramasuriya/publications), University of Auckland, New Zealand
<img src="/img/shanika.png"  width=200px height=200px style="float:left">
</div>

## Abstract

Point forecast reconciliation of collection of time series with linear aggregation constraints is one of the research areas that has attracted a lot of attention in the last decade. A few commonly used methods are GLS (generalized least squares), OLS (ordinary least squares), WLS (weighted least squares) and MinT (minimum trace). GLS and MinT have similar mathematical expressions but they differ by the covariance matrix used. OLS and WLS can be considered as special cases of MinT where they differ by the assumptions made about the structure of the covariance matrix. All these methods ensure that the reconciled forecasts are unbiased provided that the base forecasts are unbiased. Ben Taieb & Koo (2019) proposed a method which relax the assumption of unbiasedness. There is limited research carried on probabilistic forecast reconciliation and among them, the focus is to evaluate the efficiency of aforementioned methods using simulations or real data, or to optimize a scoring rule on a holdout dataset.

In this paper we prove that (a) GLS and MinT reduces to the same solution; (b) on average, a method similar to Ben Taieb & Koo (2019) (which we refer to as MinT-U) can produce better forecasts than MinT (lowest total mean squared error) which is then followed by OLS and then by base; (c) the mean squared error of each series in the structure for MinT-U is smaller than that for MinT which is then followed by that for either OLS or base forecasts; (d) if the base predictive distribution is Gaussian then MinT minimizes the logarithmic scoring rule; and (e) the logarithmic score of MinT for each marginal predictive density is smaller than that of OLS. We show these theoretical results using a set of simulation studies. We also evaluate them using Australian domestic tourism dataset.

## Discussant

<div class = "figure">
[Lorenzo Zambon](https://scholar.google.com/citations?user=vfdwxl8AAAAJ&hl=it), IDSIA, Switzerland
<img src=/img/lorenzo.png  width=200px height=200px style="float:left">
</div>
