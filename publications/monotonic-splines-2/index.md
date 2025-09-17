---
author: Len Smith, Rob J Hyndman, Simon N Wood
Status: Published
date: 2004-01-16 03:40:50+00:00
slug: monotonic-splines-2
title: 'Spline interpolation for demographic variables: the monotonicity problem'
categories: Articles
tags:
- demography
- nonparametric smoothing
details: <em>Journal of Population Research</em> <b>21</b>(1), 95-98
doi: 10.1007/BF03032212
file: monotonic_splines.pdf
---

In demography, it is often necessary to obtain a monotonic interpolation of data. A solution to this problem is available using the Hyman filter for cubic splines. However, this does not seem to be well-known amongst demographers, and no implementation of the procedure is readily available. We remedy these problems by outlining the relevant ideas here, and providing a function for the R package.

**[R code](http://github.com/robjhyndman/demography)**
