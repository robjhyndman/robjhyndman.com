---
author: Souhaib Ben Taieb, James W Taylor, Rob J Hyndman
date: 2017-06-02
slug: probhts
title: Coherent Probabilistic Forecasts for Hierarchical Time Series
details: Proceedings of the 34th International Conference on Machine Learning, PMLR 70:3348-3357
categories: Conference proceedings
tags:
- data science
- density estimation
- electricity
- forecasting
- hierarchical time series
file: 2017_icml_probhts.pdf
online: http://proceedings.mlr.press/v70/taieb17a.html
---

Many applications require forecasts for a hierarchy comprising a set of time series along with aggregates of subsets of these series. Although forecasts can be produced independently for each series in the hierarchy, typically this does not lead to coherent forecasts — the property that forecasts add up appropriately across the hierarchy. State-of-the-art hierarchical forecasting methods usually reconcile these independently generated forecasts to satisfy the aggregation constraints. A fundamental limitation of prior research is that it has looked only at the problem of forecasting the mean of each time series. We consider the situation where probabilistic forecasts are needed for each series in the hierarchy. We define forecast coherency in this setting, and propose an algorithm to compute predictive distributions for each series in the hierarchy. Our algorithm has the advantage of synthesizing information from different levels in the hierarchy through a sparse forecast combination and a probabilistic hierarchical aggregation. We evaluate the accuracy of our forecasting algorithm on both simulated data and large-scale electricity smart meter data. The results show consistent performance gains compared to state-of-the art methods
