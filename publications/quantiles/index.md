---
author: Rob J Hyndman and Yanan Fan
Status: Published
date: 1996-11-16 02:45:26+00:00
slug: quantiles
title: Sample quantiles in statistical packages
details: "<em>American Statistician</em> <b>50</b> 361-365"
status: Published
categories: Articles
tag:
- software
jstor: 2684934
---

There are a large number of different definitions used for sample quantiles in statistical computer packages. Often within the same package one definition will be used to compute a quantile explicitly while other definitions may be used when producing a boxplot, a probability plot or a QQ-plot. We compare the most commonly implemented sample quantile definitions by writing them in a common notation and investigating their motivation and some of their properties. We argue that there is a need to adopt a standard definition for sample quantiles so that the same answers are produced by different packages and within each package. We conclude by recommending that the median-unbiased estimator is used since it has most of the desirable properties of a quantile estimator and can be defined independently of the underlying distribution.

**Keywords:** sample quantiles, percentiles, quartiles, statistical computer packages.

**R code:** The [quantile()](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/quantile.html) function in R from version 2.0.0 onwards implements all the methods in this paper.

**Errata:**

  * Table 1, p361. P2 should have lower bound equal to $\lfloor np\rfloor$.
  * p363, left column. P2 is satisfied if and only if $\alpha\ge0$ and $\beta\le1$.
  * p364, right column. Definition $\hat{Q}_7(p)$ only satisfies four of the six properies.

Thanks to Eric Langford and Alan Dorfman for pointing out the first two errors. 8 May 2007. <br>
Thanks to Ati Ghoreyshi for spotting the third error. 27 April 2022.

For further discussion, see [Sample quantiles 20 years later](/hyndsight/sample-quantiles-20-years-later/) on Hyndsight.
