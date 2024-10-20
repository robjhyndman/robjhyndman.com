---
title: "Reliable Predictions for Hierarchical Time Series"
---

## Presenter

<div class = "figure">
[**Jing Hu**](https://www.linkedin.com/in/hujing), Intuit, USA
<img src="/img/jing.png"  width=200px height=200px style="float:left">
</div>

## Abstract

Forecasting time series with hierarchical aggregation constraints is a common problem in many practically essential applications. For instance, commercial organizations often want to forecast inventories simultaneously at the store, city, and state levels for resource planning purposes. It is desirable that the forecasts, in addition to being reasonably accurate, are also consistent with respect to one another. In this talk, I will introduce a novel hierarchical time series (HTS) forecasting framework that optimizes quantile regression loss, coupled with suitable regularization terms to maintain the consistency of forecasts across hierarchies. This flexible framework can be tailored to the needs of different time series by dynamically combining heterogeneous forecasting models. Additionally, to reduce the computational cost when dealing with a large number of HTS, I will present a multilevel clustering approach where each time series is first assigned the forecast from its cluster representative, and it can be efficiently adjusted to accommodate the specific attributes of the HTS.

* [**Slides**](https://robjhyndman.com/files/prato/Hierarchical Time Series Forecasting - Prato.pdf)

**Associated papers**

* [arxiv.org/abs/2102.12612](https://arxiv.org/abs/2102.12612)
* [arxiv.org/abs/2112.11669](https://arxiv.org/abs/2112.11669)
* [arxiv.org/abs/2205.14104](https://arxiv.org/abs/2205.14104)


## Discussant

<div class = "figure">
[**Christoph Bergmeir**](https://cbergmeir.com), University of Granada, Spain
<img src=/img/christoph.png  width=200px height=200px style="float:left">
</div>
