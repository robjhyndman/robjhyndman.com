---
date: 2010-10-04 12:39:20+00:00
link: https://robjhyndman.com/hyndsight/arimax/
slug: arimax
title: The ARIMAX model muddle
categories:
- forecasting
- R
- statistics
---

There is often confusion about how to include covariates in ARIMA models, and the presentation of the subject in various textbooks and in R help files has not helped the confusion. So I thought I'd give my take on the issue. To keep it simple, I will only describe non-seasonal ARIMA models although the ideas are easily extended to include seasonal terms. I will include only one covariate in the models although it is easy to extend the results to multiple covariates. And, to start with, I will  assume the data are stationary, so we only consider ARMA models.

Let the time series be denoted by $y_1,\dots,y_n$. First, we will define an ARMA$(p,q)$ model with no covariates:
$$
y_t = \phi_1 y_{t-1} + \cdots + \phi_p y_{t-p} - \theta_1 z_{t-1} - \dots - \theta_q z_{t-q} + z_t,
$$
where $z_t$ is a white noise process (i.e., zero mean and iid).

## ARMAX models

An ARMAX model simply adds in the covariate on the right hand side:
$$
y_t = \beta x_t + \phi_1 y_{t-1} + \cdots + \phi_p y_{t-p} - \theta_1 z_{t-1} - \dots - \theta_q z_{t-q} + z_t
$$
where $x_t$ is a covariate at time $t$ and $\beta$ is its coefficient. While this looks straight-forward, one disadvantage is that the covariate coefficient is hard to interpret. The value of $\beta$ is _not_ the effect on $y_t$ when the $x_t$ is increased by one (as it is in regression). The presence of lagged values of the response variable on the right hand side of the equation mean that $\beta$ can only be interpreted conditional on the value of previous values of the response variable, which is hardly intuitive.

If we write the model using backshift operators, the ARMAX model is given by
$$
\phi(B)y_t = \beta x_t + \theta(B)z_t
\qquad\text{or}\qquad
y_t = \frac{\beta}{\phi(B)}x_t + \frac{\theta(B)}{\phi(B)}z_t,
$$
where $\phi(B)=1-\phi_1B -\cdots - \phi_pB^p$ and $\theta(B)=1-\theta_1B-\cdots-\theta_qB^q$. Notice how the AR coefficients get mixed up with both the covariates and the error term.

## Regression with ARMA errors

For this reason, I prefer to use regression models with ARMA errors, defined as follows.
\begin{align}
y_t &= \beta x_t + n_t\\
n_t &= \phi_1 n_{t-1} + \cdots + \phi_p n_{t-p} - \theta_1 z_{t-1} - \dots - \theta_q z_{t-q} + z_t
\end{align}
In this case, the regression coefficient has its usual interpretation. There is not much to choose between the models in terms of forecasting ability, but the additional ease of interpretation in the second one makes it attractive.

Using backshift operators, this model can be written as
$$
y_t = \beta x_t + \frac{\theta(B)}{\phi(B)}z_t.
$$

## Transfer function models

Both of these models can be considered as special cases of transfer function models, popularized by Box and Jenkins:
$$
y_t = \frac{\beta(B)}{v(B)} x_t + \frac{\theta(B)}{\phi(B)}z_t.
$$
This allows for lagged effects of covariates (via the $\beta(B)$ operator) and for decaying effects of covariates (via the $v(B)$ operator).

Sometimes these are called "dynamic regression models", although different books use that term for different models.

The method for selecting the orders of a transfer function model that is described in Box and Jenkins is cumbersome and difficult, but continues to be described in textbooks. A much better procedure is given in [Pankratz (1991)](http://buy.geni.us/Proxy.ashx?TSID=140570\&GR_URL=http%3A%2F%2Fwww.amazon.com%2Fdp%2F0471615285), and repeated in my [1998 forecasting textbook](https://robjhyndman.com/forecasting/).

## Non-stationary data

For ARIMA errors, we simply replace $\phi(B)$ with $\nabla^d\phi(B)$ where $\nabla=(1-B)$ denotes the differencing operator. Notice that this is equivalent to differencing both $y_t$ and $x_t$ before fitting the model with ARMA errors. In fact, it is necessary to difference all variables first as estimation of a model with non-stationary errors is not consistent and can lead to "spurious regression".

## R functions

The `arima()` function in R (and `Arima()` and `auto.arima()` from the [forecast package](http://github.com/robjhyndman/forecast/)) fits a regression with ARIMA errors. Note that R reverses the signs of the moving average coefficients compared to the standard parameterization given above.

The `arimax()` function from the [TSA package](http://cran.r-project.org/web/packages/TSA/) fits the transfer function model (but not the ARIMAX model). This is a new package and I have not yet used it, but it is nice to finally be able to fit transfer function models in R. Sometime I plan to write a function to allow automated order selection for transfer functions as I have done with `auto.arima()` for regression with ARMA errors (part of the [forecast package](http://github.com/robjhyndman/forecast/))
