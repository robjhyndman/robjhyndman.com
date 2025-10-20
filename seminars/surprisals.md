---
date: 2025-10-28
title: "Anomaly detection using surprisals"
venue: Various
bibliography: surprisals.bib
aliases:
    - /toptime2025
    - /abudhabi2025
nocite: |
   - @lookout
   - @lookout2
   - @surprisalevt
---

## Abstract

I will discuss a probabilistic approach to anomaly detection based on extreme 'surprisal values' aka log scores, equal to minus the log density at each observation. The surprisal approach can be used for any collection of data objects, provided a probability density can be defined on the sample space. It can distinguish anomalies from legitimate observations in a heavy tail, and will identify anomalies that are undetected using methods based on distance measures. I will demonstrate the idea in various real data examples including univariate, multivariate and regression contexts, and when exploring more complicated data objects. I will also briefly outline the underlying theory when the density is known, and when it is estimated using a kernel density estimate. In the latter case, an innovative bandwidth selection method is used based on persistent homology.

## Given at

* [TopTime Conference](https://maths.anu.edu.au/news-events/events/topological-methods-time-varying-data-theory-and-applications-top-time), Australian National University, Canberra, Australia: 27-31 October 2025.
* [Frontiers of Statistical Inference 2025](https://stat-ml.github.io/frontiers-stat-inf-2025/), MBZUAI, Abu Dhabi, UAE: 24-27 November 2025.

## Slides (ANU)

<a href="https://github.com/robjhyndman/surprisal_talk/raw/main/surprisals.pdf" class="badge badge-small badge-red">Download pdf</a>
<iframe src="https://docs.google.com/gview?url=https://github.com/robjhyndman/surprisal_talk/raw/main/surprisals.pdf&embedded=true"  width="100%" height=465></iframe>

## Software

* [lookout package for R](https://sevvandi.github.io/lookout/)
* [weird package for R](http://pkg.robjhyndman.com/weird-package/)
