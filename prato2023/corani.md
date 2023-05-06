---
title: "Probabilistic reconciliation by conditioning"
---

## Presenter

<div class = "figure">
[Giorgio Corani](https://sites.google.com/site/awerbhjkl678214/), IDSIA (Dalle Molle Institute for Artificial Intelligence), Switzerland
<img src="/img/corani.png" style="float:left;width=200px;height=200px">
</div>

## Abstract

I will show how to perform probabilistic reconciliation via conditioning. First we create an incoherent joint distribution $p(B,U)$ on bottom and upper time series, based on the base forecast. Then we condition it on the constraint $AB=U$, where $A$ is the aggregation matrix specifying how bottom-level series are aggregated to form the upper ones. The conditioning can be solved analytically for Gaussian base forecasts; in this case the reconciled distribution has the same point forecast and variance of MinT. I will then show how to compute the reconciled distribution via sampling for count time series and I will discuss some properties of the reconciled distributions.
