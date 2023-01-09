---
date: 2011-03-14 22:28:09+00:00
link: https://robjhyndman.com/hyndsight/tests2/
slug: tests2
title: Statistical tests for variable selection
categories:
- forecasting
- R
- statistics
---

I received an email today with the following comment:

>I’m using ARIMA with Intervention detection and was planning to use your package to identify my initial ARIMA model for later iteration, however I found that sometimes the auto.arima function returns a model where AR/MA coefficients are not significant. So my question is: Is there a way to filter the search for ARIMA models that only have significant coefficients. I can remove the non-significant coefficients but I think it would be better to search for those models that only have significant coefficients.

Statistical significance is not usually a good basis for determining whether a variable should be included in a model, despite the fact that many people who should know better use them for exactly this purpose.  Even some textbooks discuss variable selection using statistical tests, thus perpetuating bad statistical practice.

Statistical tests were designed to test hypotheses, not select variables. Tests on coefficients are answering a different question from whether the variable is useful in forecasting. It is possible to have an insignificant coefficient associated with a variable that is useful for forecasting. It is also possible to have a significant variable associated with a variable that is better omitted when forecasting.

To see why the first situation occurs, think about two highly correlated predictor variables. It may be that the model that includes them both gives the best forecasts, but any statistical tests on the coefficients can give insignificant values because it is hard to distinguish their separate contributions (thus causing the standard errors on their coefficients to be large). This is almost always a problem with AR coefficients because the corresponding predictors are lagged variations of each other and often highly correlated.

The second situation occurs, for example, when a predictor has high variability and a small coefficient. When the sample size is large enough, the estimated coefficient may be statistically significant. But for forecasting purposes, including the predictor increases the variance of the forecast without contributing much additional information.

See Harrell's book _[Regression Modelling Strategies](http://buy.geni.us/Proxy.ashx?TSID=140570\&GR_URL=http%3A%2F%2Fwww.amazon.com%2Fdp%2F0387952322)_ for further discussion on the misuse of statistical tests for variable selection.

A much more reliable guide to selecting terms in any model, including ARIMA models, is to use [cross-validation or an approximation to it such as the AIC](/hyndsight/crossvalidation/). The `auto.arima()` function from the [forecast package](http://github.com/robjhyndman/forecast/) in R uses the AIC by default and usually chooses a reasonably good model for forecasting. If users wish to experiment with other models, use the AIC for comparison not significance tests of the coefficients.
