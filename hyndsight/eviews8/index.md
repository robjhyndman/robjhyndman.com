---
date: 2013-02-28 22:04:20+00:00
link: https://robjhyndman.com/hyndsight/eviews8/
slug: eviews8
title: ETS models now in EViews 8
categories:
- computing
- forecasting
- R
- statistics
---

The ETS modelling framework developed in my [2002 IJF paper](/publications/hksg/) (with Koehler, Snyder and Grose), and in my [2008 Springer book](http://www.exponentialsmoothing.net/) (with Koehler, Ord and Snyder), is now available in [EViews 8](https://web.archive.org/web/20130305131651/http://www.eviews.com/EViews8/ev8whatsnew.html). I had no idea they were even working on it, so it was quite a surprise to be told that EViews now includes ETS models.<!-- more -->

Here is the blurb from the [release notes](https://web.archive.org/web/20130305131651/http://www.eviews.com/EViews8/ev8eccomp_n.html#ets):

>EViews 8 now offers support for exponential smoothing using the dynamic nonlinear model framework of Hyndman, Koehler, et al. (2002).

>The ETS (Error-Trend-Seasonal or ExponenTial Smoothing) framework defines an extended class of exponential smoothing methods that encompasses standard ES models (e.g., Holt and Holt–Winters additive and multiplicative methods), but offer a variety of new methods.

>In addition ETS smoothing offers a theoretical foundation for analysis of these models using state-space based likelihood calculations, with support for model selection and calculation of forecast standard errors.

![ETS Smoothing](http://www.eviews.com/EViews8/images/ets.png)

Until now, ETS models have only been available in R (the `ets` function in the [forecast](http://github.com/robjhyndman/forecast/) package). I believe SAS has also been working on including them, but nothing has appeared yet.
