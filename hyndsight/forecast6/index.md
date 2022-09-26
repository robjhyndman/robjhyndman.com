---
date: 2015-05-15 05:01:58+00:00
link: https://robjhyndman.com/hyndsight/forecast6/
slug: forecast6
title: New in forecast 6.0
categories:
- computing
- forecasting
- R
- statistics
- time series
---

This week I uploaded a new version of the forecast package to CRAN. As there were a lot of changes, I decided to increase the version number to 6.0.

The changes are all outlined in the [ChangeLog file](http://pkg.robjhyndman.com/forecast/news/) as usual. I will highlight some of the more important changes since v5.0 here.<!-- more -->

### ETS

One of the most used functions in the package is `ets()` and it provides a stock forecasting engine for many organizations. The default model selection is now restricted to exclude multiplicative trend models as these often give very poor forecasts due to the extrapolation of exponential trends. Multiplicative trend models can still be fitted if required. I compared the new default settings with the old defaults on the M3 data, and found a considerable difference in forecast accuracy:

<table >
<tr >
<th></th>
<th>MAPE</th>
<th>sMAPE</th>
<th>MASE</th>
</tr>
<tbody >
<tr >
<td >ETS
</td>
<td >17.38
</td>
<td >13.13
</td>
<td >1.43
</td>
</tr>
<tr >
<td >ETS (old)
</td>
<td >18.04
</td>
<td >13.36
</td>
<td >1.52
</td>
</tr>
<tr >

<td >AutoARIMA
</td>

<td >19.12
</td>

<td >13.85
</td>

<td >1.47
</td>
</tr>
</tbody>
</table>

Here "ETS" denotes the new default approach (without multiplicative trends) and "ETS (old)" is the old default approach including possibly multiplicative trends. For comparison, the results from applying `auto.arima` to the same data are also shown.

### ARIMA

The `auto.arima()` function is now stricter on near unit-roots. Even if a model can be estimated, it will not be selected if the characteristic AR or MA roots are too close to the unit circle. This prevents occasional numerical instabilities occurring. Previously the roots had to be at least 0.001 away from the unit circle. Now they have to be at least 0.01 from the unit circle.

There is a new `allowmean` argument in `auto.arima` which can be used to prevent a mean term being included in a model.

There is a new `plot.Arima()` function which plots the characteristic roots of an ARIMA model. This is based on a [blog post I wrote last year](https://robjhyndman.com/hyndsight/arma-roots/).

It is now possible to easily obtain the fitted model order for use in other functions. The function `arimaorder` applied to a fitted ARIMA model (such as that returned by `auto.arima`) will return a numeric vector of the form (p,d,q) for a nonseasonal model and (p,d,q,P,D,Q,m) for a seasonal model. Similarly, `as.character` applied to the object returned by `Arima` or `auto.arima` will give a character string with the fitted model, suitable for use in plotting or reports.

### TBATS/BATS

The models returned by `tbats` and `bats` were occasionally unstable. This problem has been fixed, again by restricting the roots to be further away from the unit circle.

### STL

`stlf` and `forecast.stl` combine forecasting with seasonal decomposition. The seasonally adjusted series are forecast, and then the forecasts are re-seasonalized. These functions now have a `forecastfunction` argument to allow user-specified methods to be used in the forecasting step.

There is a new `stlm` function and a corresponding `forecast.stlm` function to allow the model estimation to be separated from the forecasting, thus matching most other forecasting methods in the package. This allows more flexible specification of the model to be used for the seasonally adjusted series.

### ACF/PACF

The `Acf` function replaces the `acf` function to provide better plots of the autocorrelation function. The horizontal axis now highlights the seasonal lags.

I have added two new functions `taperedacf` and `taperedpacf` to implement the estimates and plots proposed in [this recent paper](/publications/mpcomments/).

### Seasonality

The `fourier()` and `fourierf()` functions produce a matrix of Fourier terms for use in regression models for seasonal time series. These were updated to work with `msts` objects so that multiple seasonalities can be fitted.

Occasionally, the period of the seasonality may not be known. The `findfrequency()` function will estimate it. This is based on an [earlier version I wrote for this blog post](https://robjhyndman.com/hyndsight/tscharacteristics/).

### Automatic forecasting

The `forecast.ts()` function takes a time series and returns some forecasts, without the user necessarily knowing what is going on under the hood. It will use `ets` with default settings (if the data are non-seasonal or the seasonal period is 12 or less) and `stlf` (if the seasonal period is 13 or more). If the seasonal period is unknown, there is an option (`find.frequency=TRUE`) to estimate it first.
