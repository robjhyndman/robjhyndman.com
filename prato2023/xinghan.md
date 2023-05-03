---
title: "Reliable Predictions for Hierarchical Time Series"
---

## Presenter

<div class = "figure">
[Xing Han](https://aaronhan223.github.io), University of Texas at Austin, USA
<img src="/img/xinghan.png" width = "200" align = "left" style="padding-right: 50px;">
</div>

## Abstract

Forecasting time series with hierarchical aggregation constraints is a common problem in many practically essential applications. For instance, commercial organizations often want to forecast inventories simultaneously at the store, city, and state levels for resource planning purposes. It is desirable that the forecasts, in addition to being reasonably accurate, are also consistent with respect to one another. In this talk, I will introduce a novel hierarchical time series (HTS) forecasting framework that optimizes quantile regression loss, coupled with suitable regularization terms to maintain the consistency of forecasts across hierarchies. This flexible framework can be tailored to the needs of different time series by dynamically combining heterogeneous forecasting models. Additionally, to reduce the computational cost when dealing with a large number of HTS, I will present a multilevel clustering approach where each time series is first assigned the forecast from its cluster representative, and it can be efficiently adjusted to accommodate the specific attributes of the HTS.
