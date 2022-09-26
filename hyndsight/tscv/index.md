---
date: 2016-12-05 12:43:57+00:00
link: https://robjhyndman.com/hyndsight/tscv/
slug: tscv
title: Cross-validation for time series
categories:
- forecasting
- R
- statistics
- time series
---

I've added a couple of new functions to the [forecast package for R](https://github.com/robjhyndman/forecast) which implement two types of cross-validation for time series.<!-- more -->

### K-fold cross-validation for autoregression

The first is regular k-fold cross-validation for autoregressive models. Although cross-validation is sometimes not valid for time series models, it does work for autoregressions, which includes many machine learning approaches to time series. The theoretical background is provided in [Bergmeir, Hyndman and Koo (2015)](/publications/cv-time-series). So cross-validation can be applied to any model where the predictors are lagged values of the response variable.

This is implemented for NNAR models (neural network autoregressions) in R as follows:


    modelcv <- CVar(lynx, k=5, lambda=0.15)
    print(modelcv)


The output is a summary of the accuracy across folds:

    5-fold cross-validation
                      Mean          SD
    ME        -32.88142801  98.0725227
    RMSE      931.90966858 352.8705338
    MAE       608.99488205 272.1244879
    MPE       -17.84710226  15.2700638
    MAPE       53.99760978  12.7264054
    ACF1        0.04842174   0.1480883
    Theil's U   0.82984737   0.1487229


The `CVar` function is rather limited at this stage, and will only handle cross-validation for models computed using `nnetar`. If there is enough interest, I might add more functionality at a later stage.

### Time series cross-validation

In this procedure, there is a series of test sets, each consisting of a single observation. The corresponding training set consists only of observations that occurred _prior_ to the observation that forms the test set. Thus, no future observations can be used in constructing the forecast. The following diagram illustrates the series of training and test sets, where the blue observations form the training sets, and the red observations form the test sets.

![cv1-1](/files/cv1-1.png)

The forecast accuracy is computed by averaging over the test sets. This procedure is sometimes known as “evaluation on a rolling forecasting origin” because the “origin” at which the forecast is based rolls forward in time.

With time series forecasting, one-step forecasts may not be as relevant as multi-step forecasts. In this case, the cross-validation procedure based on a rolling forecasting origin can be modified to allow multi-step errors to be used. Suppose that we are interested in models that produce good 4-step-ahead forecasts. Then the corresponding diagram is shown below.

![cv4-1](/files/cv4-1.png)

Time series cross validation is implemented with the `tsCV` function. In the following example, we compare the residual RMSE with the RMSE obtained via time series cross-validation.


    library(fpp)
    e <- tsCV(dj, rwf, drift=TRUE, h=1)
    sqrt(mean(e^2, na.rm=TRUE))
    ## [1] 22.68249
    sqrt(mean(residuals(rwf(dj, drift=TRUE))^2, na.rm=TRUE))
    ## [1] 22.49681


Here I apply a random walk with drift to the Dow-Jones index time series `dj`.  The first calculation implements a one-step time series cross-validation where the drift parameter is re-estimated at every forecast origin. The second calculation estimates the drift parameter once for the whole data set, and then computes the RMSE from the one-step forecasts. As expected, the RMSE from the residuals is smaller, as the corresponding “forecasts” are based on a model fitted to the entire data set, rather than being true forecasts.

The `tsCV` function is very general, and will work for any forecasting function that returns an object of class `forecast`. You don't even have to specify the minimum sample size for model fitting, as it will silently fit models beginning with a single observation, and return a missing value whenever the model cannot be estimated.

These functions are only on the [github version](https://github.com/robjhyndman/forecast) for now, but will migrate to [CRAN](https://cran.r-project.org/package=forecast) next time I release a new stable version.
