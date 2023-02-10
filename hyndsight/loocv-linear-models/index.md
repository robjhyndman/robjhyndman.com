---
date: 2014-03-17 10:08:42+00:00
slug: loocv-linear-models
title: Fast computation of cross-validation in linear models
categories:
- computing
- forecasting
- fpp
- otexts
- R
- statistics
- teaching
---

The leave-one-out cross-validation statistic is given by
$$
  \text{CV} = \frac{1}{N} \sum_{i=1}^N e_{[i]}^2,
$$
where $e_{[i]} = y_{i} - \hat{y}_{[i]}$, the observations are given by $y_{1},\dots,y_{N}$, and $\hat{y}_{[i]}$ is the predicted value obtained when the model is estimated with the $i\text{th}$ case deleted. This is also sometimes known as the PRESS (Prediction Residual Sum of Squares) statistic.

It turns out that for linear models, we do not actually have to estimate the model $N$ times, once for each omitted case. Instead, CV can be computed after estimating the model once on the complete data set.

Suppose we have a linear regression model $\boldsymbol{Y} = \boldsymbol{X}\boldsymbol{\beta} + \boldsymbol{e}$. Then $\hat{\boldsymbol{\beta}} = (\boldsymbol{X}'\boldsymbol{X})^{-1}\boldsymbol{X}'\boldsymbol{Y}$ and $\boldsymbol{H} = \boldsymbol{X}(\boldsymbol{X}'\boldsymbol{X})^{-1}\boldsymbol{X}'$ is the "hat-matrix". It has this name because it is used to compute $\boldsymbol{\hat{Y}} = \boldsymbol{X}\hat{\boldsymbol{\beta}} = \boldsymbol{H}\boldsymbol{Y}$. If the diagonal values of $\boldsymbol{H}$ are denoted by $h_{1},\dots,h_{N}$, then the leave-one-out cross-validation statistic can be computed using
$$
  \text{CV} = \frac{1}{N}\sum_{i=1}^N [e_{i}/(1-h_{i})]^2,
$$
where $e_i = y_i - \hat{y}_i$ and $\hat{y}_i$ is the predicted value obtained when the model is estimated with all data included. This is a remarkable result, and is given without proof in [Section 5.5 of my forecasting textbook](https://otexts.com/fpp2/selecting-predictors.html).

What follows is the simplest proof I know (adapted from [Seber and Lee, 2003](http://buy.geni.us/Proxy.ashx?TSID=140570\&GR_URL=http%3A%2F%2Fwww.amazon.com%2Fdp%2F0471415405/?tag=prorobjhyn-20)).

### Proof

Let $\boldsymbol{X}_{[i]}$ and $\boldsymbol{Y}_{[i]}$ be similar to $\boldsymbol{X}$ and $\boldsymbol{Y}$ but with the $i$th row deleted in each case. Let $\boldsymbol{x}'_i$ be the $i$th row of $\boldsymbol{X}$ and let
$$
\hat{\boldsymbol{\beta}}_{[i]} = (\boldsymbol{X}_{[i]}'\boldsymbol{X}_{[i]})^{-1}\boldsymbol{X}_{[i]}' \boldsymbol{Y}_{[i]}
$$
be the estimate of $\boldsymbol{\beta}$ without the $i$th case. Then $e_{[i]} = y_i - \boldsymbol{x}_i'\hat{\boldsymbol{\beta}}_{[i]}$.

Now $\boldsymbol{X}_{[i]}'\boldsymbol{X}_{[i]} = (\boldsymbol{X}'\boldsymbol{X} - \boldsymbol{x}_i\boldsymbol{x}_i')$ and $\boldsymbol{x}_i'(\boldsymbol{X}'\boldsymbol{X})^{-1}\boldsymbol{x}_i = h_i$. So by the [Sherman--Morrison--Woodbury formula](http://en.wikipedia.org/wiki/Sherman%E2%80%93Morrison_formula),
$$
(\boldsymbol{X}_{[i]}'\boldsymbol{X}_{[i]})^{-1} = (\boldsymbol{X}'\boldsymbol{X})^{-1} + \frac{(\boldsymbol{X}'\boldsymbol{X})^{-1}\boldsymbol{x}_i\boldsymbol{x}_i'(\boldsymbol{X}'\boldsymbol{X})^{-1}}{1-h_i}.
$$
Also note that $\boldsymbol{X}_{[i]}' \boldsymbol{Y}_{[i]} = \boldsymbol{X}'\boldsymbol{Y} - \boldsymbol{x}_iy_i$. Therefore
\begin{align*}
\boldsymbol{\hat{\beta}}_{[i]}
&=  \left[ (\boldsymbol{X}'\boldsymbol{X})^{-1}  + \frac{ (\boldsymbol{X}'\boldsymbol{X})^{-1}\boldsymbol{x}_i\boldsymbol{x}_i'(\boldsymbol{X}'\boldsymbol{X})^{-1} }{1-h_i} \right] (\boldsymbol{X}'\boldsymbol{Y} - \boldsymbol{x}_i y_i)\\
&=  \hat{\boldsymbol{\beta}} - \left[ \frac{ (\boldsymbol{X}'\boldsymbol{X})^{-1}\boldsymbol{x}_i}{1-h_i}\right] \left[y_i(1-h_i) -  \boldsymbol{x}_i' \hat{\boldsymbol{\beta}} +h_i y_i \right]\\
&=  \hat{\boldsymbol{\beta}} - (\boldsymbol{X}'\boldsymbol{X})^{-1}\boldsymbol{x}_i e_i / (1-h_i)
\end{align*}

Thus
\begin{align*}
e_{[i]} &= y_i - \boldsymbol{x}_i'\hat{\boldsymbol{\beta}}_{[i]} \\
& = y_i - \boldsymbol{x}_i' \left[ \hat{\boldsymbol{\beta}} - (\boldsymbol{X}'\boldsymbol{X})^{-1}\boldsymbol{x}_ie_i/(1-h_i)\right] \\
&= e_i + h_i e_i/(1-h_i) \\
&= e_i/(1-h_i),
\end{align*}

and the result follows.

* * *

This result is implemented in the `CV()` function from the [**forecast** package for R](http://github.com/robjhyndman/forecast/).
