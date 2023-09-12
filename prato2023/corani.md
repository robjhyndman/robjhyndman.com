---
title: "Probabilistic reconciliation by conditioning"
---

## Presenter

<div class = "figure">
[**Giorgio Corani**](https://sites.google.com/site/awerbhjkl678214/), IDSIA, Switzerland
<img src="/img/corani.png"  width=200px height=200px style="float:left">
</div>

## Abstract

I will show how to perform probabilistic reconciliation via conditioning. First we create an incoherent joint distribution $p(B,U)$ on bottom and upper time series, based on the base forecast. Then we condition it on the constraint $AB=U$, where $A$ is the aggregation matrix specifying how bottom-level series are aggregated to form the upper ones. The conditioning can be solved analytically for Gaussian base forecasts; in this case the reconciled distribution has the same point forecast and variance of MinT. I will then show how to compute the reconciled distribution via sampling for count time series and I will discuss some properties of the reconciled distributions.

* [**Slides**](https://robjhyndman.com/files/prato/corani-Prato2023.pdf)

**Related papers**

* [G. Corani, D. Azzimonti and N. Rubattu, "Probabilistic Reconciliation of   Count Time Series." *International Journal of Forecasting*. 2023](https://www.sciencedirect.com/science/article/pii/S0169207023000390)
* [Zambon, Azzimonti and Corani, Efficient probabilistic reconciliation of forecasts for real-valued and count time series. Arxiv:  2210.02286v2 (2022)](https://arxiv.org/abs/2210.02286)
*  [L. Zambon, A. Agosto, P. Giudici and G. Corani, Properties of the reconciled   distributions for Gaussian and count forecasts. ArXiv:2303.15135 (2023)](https://arxiv.org/abs/2303.15135)
* [G. Corani, D. Azzimonti, J. Augusto and M.Zaffalon., "Probabilistic reconciliation of hierarchical forecast via Bayes' rule.",  Proc. ECML PKDD 2020: Machine Learning and Knowledge Discovery in Databases](https://ipg.idsia.ch/preprints/corani2020a.pdf)

## Discussant

<div class = "figure">
[**Anastasios Panagiotelis**](https://anastasiospanagiotelis.netlify.app), University of Sydney, Australia
<img src=/img/tas.png  width=200px height=200px style="float:left">
</div>

* [**Slides**](https://robjhyndman.com/files/prato/ResponseCorani.pdf)
