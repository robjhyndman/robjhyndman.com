---
date: 2017-11-19
slug: m4comp
title: "M4 Forecasting Competition"
categories:
  - forecasting
  - R
  - reproducible research
  - time series
image: /img/m4.png
---

The ["M" competitions](https://en.wikipedia.org/wiki/Makridakis_Competitions) organized by Spyros Makridakis have had an enormous influence on the field of forecasting. They focused attention on what models produced good forecasts, rather than on the mathematical properties of those models. For that, Spyros deserves congratulations for changing the landscape of forecasting research through this series of competitions.

[Makridakis & Hibon, (JRSSA 1979)](http://www.jstor.org/stable/2345077) was the first serious attempt at a large empirical evaluation of forecast methods. It created heated discussion, and was followed by the M-competition comprising 1001 time series that participants were invited to forecast. The results were published in [Makridakis et al (JF 1982)](https://doi.org/10.1002/for.3980010202)

The M2 competition focused on different issues and involved a much smaller data set, but with richer contextual information about each series.

Twenty years after the first competition, the M3 competition was held, involving 3003 time series. Unfortunately, many of the algorithms used are not discussed in sufficient detail to replicate the results, but the resulting comparisons are published in [Makridaks & Hibon, (IJF 2000)](https://doi.org/10.1016/S0169-2070(00)00057-1). The M3 data have continued to be used since 2000 for testing new time series forecasting methods. In fact, unless a proposed forecasting method is competitive against the original M3 participating methods, it is difficult to get published in the IJF.

Now, almost 20 years later again, Makridakis is organizing the M4 competition. Details are available at [https://mofc.unic.ac.cy/m4/](https://mofc.unic.ac.cy/m4/). This time there are 100,000 time series -- surely enough to ensure any differences in accuracy between methods are statistically significant. Astute readers might recall an aborted attempt at an M4 competition a few years ago. For various reasons, that never got off the ground.

Since the M3 competition, I have talked to Spyros a few times about what a new competition should look like. My view is that it should not just be a repeat of old competitions with larger data sets, but should look at new features of forecasting, or new types of data.
So I am pleased to see that this new competition involves two additions to the previous ones:

  1. Participants are encouraged (but not required) to produce prediction intervals. It has not been specified what probability coverage is required, and the website suggests that the accuracy of the intervals will not be part of the evaluation of the competition winners.
  2. Participants are required to submit a detailed description of their approach, and a source or execution file for reproducing the forecasts. This is an important addition, as replicability has been a problem with the previous competitions. Makridakis is allowing executable files rather than code to be submitted, so this allows for reproducibility rather than replication, but still, it is better than nothing.

While these are both welcome additions, I am disappointed that the M4 was not more innovative.

Rather than prediction intervals, participants could have been asked to provide full forecast distributions (e.g., by submitting the percentiles from 1% to 99%), and a probability scoring method such as CRPS could be used for evaluation. This was done in the [GEFCom 2014 competition](/hyndsight/gefcom2014/), for example. Even if we just stick to intervals, at least we could have a range of probability coverages (e.g., 50%, 80%, 95%, 99%) to give some more detailed idea of the forecast distribution in each case.
Unfortunately, once again only annual, quarterly and monthly data are included. Given the widespread availability of more frequent data these days, this seems anachronistic, and limits comparisons to relatively simple seasonal methods. I would have liked to see daily and hourly data included, so that multiple seasonal patterns could be present in some of the time series.

It does not appear that there will be multiple submissions allowed over time, with a leaderboard tracking progress (as there is, for example, in a Kaggle competition). This is unfortunate, as this element of a competition seems to lead to much better results. See my paper on [The value of feedback in forecasting competitions](/publications/kaggle/) with George Athanasopoulos for a discussion. I am disappointed that this feature does not appear to be part of the plans for the M4 competition.

Despite my misgivings, I hope this competition will produce some useful results that guide future forecasting research. At the very least, a large collection of 100,000 time series will provide a much needed replacement for the M3 data which have been "done to death" over the years.

-----

***Follow-up: Spyros Makridakis has provided [a response to this post](/hyndsight/m4comp-response).***
