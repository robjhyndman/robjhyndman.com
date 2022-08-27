---
author: Yanfei Kang, Rob&nbsp;J&nbsp;Hyndman, Feng Li
slug: gratis
alias: publications/tsgeneration
title: "GRATIS: GeneRAting TIme Series with diverse and controllable characteristics"
kind: article
citationn: <em>Statistical Analysis and Data Mining</em>, <b>13</b>(4), 354-376
date: 2020-04-30
tags:
- data science
- time series
arxiv: 1903.02787
doi: 10.1002/sam.11461
---

The explosion of time series data in recent years has brought a flourish of new time series analysis methods, for forecasting, clustering, classification and other tasks. The evaluation of these new methods requires either collecting or simulating a diverse set of time series benchmarking data to enable reliable comparisons against alternative approaches. We propose GeneRAting TIme Series with diverse and controllable characteristics, named GRATIS, with the use of mixture autoregressive (MAR) models. We simulate sets of time series using MAR models and investigate the diversity and coverage of the generated time series in a time series feature space. By tuning the parameters of the MAR models, GRATIS is also able to efficiently generate new time series with controllable features. In general, as a costless surrogate to the traditional data collection approach, GRATIS can be used as an evaluation tool for tasks such as time series forecasting and classification. We illustrate the usefulness of our time series generation process through a time series forecasting application.

**Associated R package**: [gratis](https://github.com/ykang/gratis)

**Associated Rshiny app**: [tsgeneration](https://ebsmonash.shinyapps.io/tsgeneration/)
