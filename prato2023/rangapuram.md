---
title: "Coherent probabilistic forecasting of temporal hierarchies"
---

## Presenter

<div class = "figure">
[Syama Rangapuram](https://de.linkedin.com/in/syama-sundar-rangapuram-0164379), Amazon, Germany
<img src="/img/rangapuram.png" style="float:left;width=200px;height=200px">
</div>

## Abstract

Forecasts at different time granularities are required in practice for addressing various business problems starting from short-term operational to medium-term tactical and to long-term strategic planning. These forecasting problems are usually treated independently by learning different ML models which results in forecasts that are not consistent with the temporal aggregation structure, leading to inefficient decision making. Some of the recent work addressed this problem, however, it uses a post-hoc reconciliation strategy, which results in sub-optimal results and cannot produce probabilistic forecasts. In this paper, we present a global model that produces coherent, probabilistic forecasts for different time granularities by learning joint embeddings for the different aggregation levels with graph neural networks and temporal reconciliation. Temporal reconciliation not only enables consistent decisions for business problems across different planning horizons but also improves the quality of forecasts at finer time granularities. A thorough empirical evaluation illustrates the benefits of the proposed method.
