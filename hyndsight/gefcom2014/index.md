---
date: 2014-02-19 07:12:50+00:00
link: https://robjhyndman.com/hyndsight/gefcom2014/
slug: gefcom2014
title: Global energy forecasting competitions
categories:
- energy
- forecasting
- IJF
- kaggle
- R
- hts
---

The [2012 GEFcom competition](http://www.drhongtao.com/gefcom/2012) was a great success with several new innovative forecasting methods introduced. These have been published in the IJF as follows:

  * [**Hong, Pinson and Fan**. Global Energy Forecasting Competition 2012](http://dx.doi.org/10.1016/j.ijforecast.2013.07.001)
  * [**Charleton and Singleton**. A refined parametric model for short term load forecasting](http://dx.doi.org/10.1016/j.ijforecast.2013.07.003)
  * [**Lloyd**. GEFCom2012 hierarchical load forecasting: Gradient boosting machines and Gaussian processes](http://dx.doi.org/10.1016/j.ijforecast.2013.07.002)
  * [**Nedelec, Cugliari and Goude**: GEFCom2012: Electric load forecasting and backcasting with semi-parametric models](http://dx.doi.org/10.1016/j.ijforecast.2013.07.004)
  * [**Ben Taieb and Hyndman**. A gradient boosting approach to the Kaggle load forecasting competition](http://dx.doi.org/10.1016/j.ijforecast.2013.07.005)
  * [**Silva**: A feature engineering approach to wind power forecasting: GEFCom 2012](http://dx.doi.org/10.1016/j.ijforecast.2013.07.007)
  * [**Mangalova and Agafonov**: Wind power forecasting using the k-nearest neighbors algorithm](http://dx.doi.org/10.1016/j.ijforecast.2013.07.008)

These papers will appear in print in the next issue of the journal. The data and code for each method is also available.

### GEFCom 2014

The [2014 edition of the competition](http://www.gefcom.org/) is now under way with a probabilistic focus. The great thing about these competitions and the associated papers is that they provide a serious empirical comparison of the forecast capability of different algorithms. There are lots of suggested approaches to forecasting energy, but without head-to-head comparisons like this, it is not always clear what is a good method, and what methods can be discarded.

The developers of the best performing methods in the competition will be invited to submit a paper to a [special issue of the IJF on probabilistic energy forecasting](/hyndsight/probabilistic-energy-forecasting/), to be edited by Tao Hong and Pierre Pinson.

In addition to the regular competition, there is also a competition for students where the best-performing classes can win a prize. See [Tao Hong's blog for further information](http://blog.drhongtao.com/2014/02/institute-prize-for-gefcom2014.html).

### Evaluating forecast distributions

Because this round of the competition is focusing on predicting the whole distribution, and not just a point forecast, we need a method of evaluating the forecasts which takes account of the whole distribution. We have chosen to use **quantile scoring**.

For each time period throughout the forecast horizon, the participants should provide the $0.01, 0.02, \dots, 0.99$ quantiles --- call these $q_1,\dots,q_{99}$, with $q_0=-\infty$ or the natural lower bound, and $q_{100}=\infty$ or the natural upper bound. The full predictive densities composed by these quantile forecasts are to be evaluated by the quantile score calculated through the pinball loss function.

For a quantile forecast $q_a$ with $a/100$ as the target quantile, this score $L$ is defined as:
$$
L(q_a, y) = \begin{cases}
(1 - a/100) (q_a - y), & \text{if $y< q_a$};\\
a/100 (y - q_a), & \text{if $y\ge q_a$};
\end{cases}
$$
where $y$ is the observation used for verification, and $a = 1, 2, \dots, 99$.

To evaluate the full predictive densities, this score is then averaged over all target quantiles, from 0.01 to 0.99, for all time periods over all forecast horizons. The lower the score, the better the forecasts are.

### Further information

For more information about the competition and how to enter, please visit [www.gefcom.org](http://www.gefcom.org/).
