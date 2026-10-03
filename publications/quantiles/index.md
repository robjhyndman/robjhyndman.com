---
author: Rob J Hyndman, Yanan Fan
Status: Published
date: 1996-11-16 02:45:26+00:00
title: "Sample quantiles in statistical packages"
status: Published
categories: Articles
tag:
  - software
jstor: 2684934
file: sample_quantiles.pdf
bibkey: HF96
details: "<em>The American Statistician</em> <b>50</b>(4), 361–365"
doi: 10.1080/00031305.1996.10473566
---

There are a large number of different definitions used for sample quantiles in statistical computer packages.
Often within the same package one definition will be used to compute a quantile explicitly while other definitions may be used when producing a boxplot, a probability plot or a QQ-plot.
We compare the most commonly implemented sample quantile definitions by writing them in a common notation and investigating their motivation and some of their properties.
We argue that there is a need to adopt a standard definition for sample quantiles so that the same answers are produced by different packages and within each package.
We conclude by recommending that the median-unbiased estimator is used since it has most of the desirable properties of a quantile estimator and can be defined independently of the underlying distribution.

**Keywords:** sample quantiles, percentiles, quartiles, statistical computer packages.

**R code:** The [quantile()](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/quantile.html) function in R from version 2.0.0 onwards implements all the methods in this paper.

**Errata:**

- Table 1, p361.
  P2 should have lower bound equal to $\lfloor np\rfloor$.
- p362, right column.
  The upper-tail frequency for Definition 3 should be
  $$
    \text{Freq}(X_k \ge \hat{Q}_3(1 - p)) = \begin{cases}
                                              \lceil pn + \frac{1}{2}\rceil + 1 & \text{if } g = 0 \text{ and } \lfloor (1 - p)n\rfloor \text{ even}, \\
                                              \lceil pn + \frac{1}{2}\rceil     & \text{otherwise.}
                                            \end{cases}
  $$
- p363, left column.
  The upper-tail frequency for Definitions 4--9 should be $\text{Freq}(X_k \ge \hat{Q}_i(1 - p)) = \lfloor pn + \beta + p(1 - \alpha - \beta)\rfloor$, because $m$ must be evaluated at $1 - p$.
  The printed expression is correct only for Definitions 4 and 5, where $m$ does not depend on $p$.
- p363, left column.
  P2 is satisfied if and only if $\alpha \ge 0$ and $\beta \le 1$.
- p363, left column.
  P3 is satisfied for all $p$ if and only if $\alpha = \beta$.
- p364, Table 3.
  Definitions 6--9 also satisfy P3.
- p364, right column.
  $\hat{Q}_5(p)$, $\hat{Q}_6(p)$, $\hat{Q}_8(p)$ and $\hat{Q}_9(p)$ satisfy all six properties, and $\hat{Q}_7(p)$ satisfies five (all except P5).

The frequency expressions on pp.362--363 assume distinct observations.
With tied observations, P3 can fail for every definition; for example, $x = (1, 2, 2)$ with $p = 0.5$.

Thanks to Eric Langford and Alan Dorfman for pointing out the errors concerning P2 (8 May 2007), to Ati Ghoreyshi for pointing out the inconsistency between Table 3 and the text on p364 (27 April 2022), and to Takanori Kawabata for pointing out the errors concerning Definition 3 and P3 (3 October 2026).

For further discussion, see [Sample quantiles 20 years later](/hyndsight/sample-quantiles-20-years-later/) on Hyndsight.
