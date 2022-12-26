---
date: 2014-04-16 12:11:06+00:00
link: https://robjhyndman.com/hyndsight/smape/
slug: smape
title: Errors on percentage errors
bibliography: refs.bib
categories:
- forecasting
- fpp
- IJF
- R
- references
- reproducible research
- statistics
---

The MAPE (mean absolute percentage error) is a popular measure for forecast accuracy and is defined as
$$
\text{MAPE} = 100\text{mean}(|y_t - \hat{y}_t|/|y_t|)
$$
where $y_t$ denotes an observation and $\hat{y}_t$ denotes its forecast, and the mean is taken over $t$.

@Armstrong1985 [p348] was the first (to my knowledge) to point out the asymmetry of the MAPE saying that "it has a bias favoring estimates that are below the actual values".<!-- more --> A few years later, @AC92 argued that the MAPE "puts a heavier penalty on forecasts that exceed the actual than those that are less than the actual". @Makridakis1993 took up the argument saying that "equal errors above the actual value result in a greater APE than those below the actual value". He provided an example where $y_t=150$ and $\hat{y}_t=100$, so that the relative error is 50/150=0.33, in contrast to the situation where $y_t=100$ and $\hat{y}_t=150$, when the relative error would be 50/100=0.50.

Thus, the MAPE puts a heavier penalty on negative errors (when $y_t < {\hat{y}_t}$) than on positive errors. This is what is stated in [my textbook](http://www.otexts.org/fpp/2/5). Unfortunately, Anne Koehler and I got it the wrong way around in [our 2006 paper on measures of forecast accuracy](/publications/another-look-at-measures-of-forecast-accuracy/) [@HK06], where we said the heavier penalty was on positive errors. We were probably thinking that a forecast that is too large is a positive error. However, forecast errors are defined as $y_t - \hat{y}_{t}$, so positive errors arise only when the forecast is too small.

To avoid the asymmetry of the MAPE, @Armstrong1985 proposed the "adjusted MAPE", which he defined as
$$
\overline{\text{MAPE}} = 100\text{mean}(2|y_t - \hat{y}_t|/(y_t + \hat{y}_t))
$$
By that definition, the adjusted MAPE can be negative (if $y_t+\hat{y}_t < 0$), or infinite (if $y_t+\hat{y}_t=0$), although Armstrong claims that it has a range of (0,200). Presumably he never imagined that data and forecasts can take negative values. Strangely, there is no reference to this measure in @AC92.

@Makridakis1993 proposed almost the same measure, calling it the "symmetric MAPE" (sMAPE), but without crediting @Armstrong1985, defining it
$$
\text{sMAPE} = 100\text{mean}(2|y_t - \hat{y}_t|/|y_t + \hat{y}_t|)
$$
However, in the M3 competition paper by @M3comp, sMAPE is defined equivalently to Armstrong's adjusted MAPE (without the absolute values in the denominator), again without reference to Armstrong (1985). Makridakis and Hibon claim that this version of sMAPE has a range of $(-200,200)$.

@Flores1986 proposed a modified version of Armstrong's measure, defined as exactly half of the adjusted MAPE defined above. He claimed (again incorrectly) that it had an upper bound of 100.

Of course, the true range of the adjusted MAPE is $(-\infty,\infty)$ as is easily seen by considering the two cases $y_t+\hat{y}_t = \varepsilon$ and $y_t+\hat{y}_t = -\varepsilon$, where $\varepsilon>0$, and letting $\varepsilon\rightarrow0$. Similarly, the true range of the sMAPE defined by @Makridakis1993 is $(0,\infty)$. I'm not sure that these errors have previously been documented, although they have surely been noticed.

@Goodwin1999 point out that on a percentage scale, the MAPE is symmetric and the sMAPE is asymmetric. For example, if $y_t =100$, then $\hat{y}_t=110$ gives a 10% error, as does $\hat{y}_t=90$. Either would contribute the same increment to MAPE, but a different increment to sMAPE.

@Koehler2001 in a commentary on the M3 competition, made the same point, but without reference to Goodwin and Lawton.

Whether symmetry matters or not, and whether we want to work on a percentage or absolute scale, depends entirely on the problem, so these discussions over (a)symmetry don't seem particularly useful to me.

@chen2004assessing, in an unpublished working paper, defined the sMAPE as
$$
\text{sMAPE} = \text{mean}(2|y_t - \hat{y}_t|/(|y_t| + |\hat{y}_t|)).
$$
They still called it a measure of "percentage error" even though they dropped the multiplier 100. At least they got the range correct, stating that this measure has a maximum value of two when either $y_t$ or $\hat{y}_t$ is zero, but is undefined when both are zero. The range of this version of sMAPE is (0,2). Perhaps this is the definition that Makridakis and Armstrong intended all along, although neither has ever managed to include it correctly in one of their papers or books.

As will be clear by now, the literature on this topic is littered with errors. The [Wikipedia page on sMAPE](http://en.wikipedia.org/wiki/Symmetric_mean_absolute_percentage_error) contains several as well, which a reader might like to correct.

If all data and forecasts are non-negative, then the same values are obtained from all three definitions of sMAPE. But more generally, the last definition above from Chen and Yang is clearly the most sensible, if the sMAPE is to be used at all. In the M3 competition, all data were positive, but some forecasts were negative, so the differences are important. However, I can't match the published results for any definition of sMAPE, so I'm not sure how the calculations were actually done.

Personally, I would much prefer that either the original MAPE be used (when it makes sense), or the [mean absolute scaled error (MASE)](http://en.wikipedia.org/wiki/Mean_absolute_scaled_error) be used instead. There seems little point using the sMAPE except that it makes it easy to compare the performance of a new forecasting algorithm against the published M3 results. But even there, it is not necessary, as the forecasts submitted to the M3 competition are all available in the [Mcomp package for R](http://cran.r-project.org/web/packages/Mcomp/), so a comparison can easily be made using whatever measure you prefer.

* * *

Thanks to Andrey Kostenko for alerting me to the different definitions of sMAPE in the literature.
