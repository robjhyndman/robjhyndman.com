---
title: "Detecting distributional differences between temporal granularities for exploratory time series analysis"
author: Sayani Gupta, Rob J Hyndman, Dianne Cook
date: 2021-11-17
slug: hakear
categories: Working papers
tags:
  - data science
  - time series
  - graphics
link: https://bridges.monash.edu/ndownloader/files/38164341
---

Cyclic temporal granularities are temporal deconstructions of a time period into units such as hour-of-the-day and work-day/weekend. They can be useful for measuring repetitive patterns in large univariate time series data, and feed new approaches to exploring time series data. One use is to take pairs of granularities, and make plots of response values across the categories induced by the temporal deconstruction. However, when there are many granularities that can be constructed for a time period, there will also be too many possible displays to decide which might be the more interesting to display. This work proposes a new distance metric to screen and rank the possible granularities, and hence choose the most interesting ones to plot. The distance measure is computed for a single or pairs of cyclic granularities and can be compared across different cyclic granularities or on a collection of time series. The methods are implemented in the open-source R package [`hakear`](https://github.com/Sayani07/hakear).
