---
date: 2023-07-03
title: Forecast reconciliation
venue: University of North Carolina at Charlotte
bibliography: hts.bib
---

**Distinguished Lecture Series for the International Institute of Forecasters**

## Abstract

It is common to forecast at different levels of aggregation. For example, a retail company will want national forecasts, state forecasts, and store-level forecasts. And they will want them for all products, for groups of products, and for individual products. It is natural to want the forecasts to be "coherent" --- that is, that the forecasts add up in the same way as the data. For example, forecasts of regional sales should add up to forecasts of state sales, which should in turn add up to give a forecast for national sales.  Coherent forecasts are needed to allow effective planning, such as the allocation of resources across an organization based on forecasts of sales. Coherent forecasts are also more accurate than incoherent forecasts.

Over the past 15 years, forecast reconciliation methods have been developed to ensure forecasts are coherent. Forecasts at all levels of aggregation are produced, and the results are "reconciled" so they are consistent with each other.

I will provide an up-to-date overview of this area, and show how reconciliation methods can lead to better forecasts and better forecasting practices.

## Outline

1. **Hierarchical time series and forecast reconciliation**

   * @hierarchical
   * @mint
   * @fasthts
   * @lhf


2. **The geometry of forecast reconciliation**

    * @Di_FonGir2022b
    * @htsgeometry
    * @nonnegmint
    * @Van_ErvCug2015

3. **Temporal and cross-temporal forecast reconciliation**

    * @temporal-hierarchies
    * @Di_FonGir2022a

4. **Probabilistic forecast reconciliation**

    * @smartmeterhts
    * @coherentprob
    * @ctprob


## Software

* [hts package for R](https://pkg.earo.me/hts/)
* [thief package for R](http://pkg.robjhyndman.com/thief/)
* [fable package for R](https://fable.tidyverts.org)
* [FoReco package for R](https://danigiro.github.io/FoReco/)
* [hierarchicalforecast library for Python](https://nixtla.github.io/hierarchicalforecast/)
* [pyhts library for Python](https://angelpone.github.io/)
