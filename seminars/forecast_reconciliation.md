---
date: 2023-11-07
title: Forecast reconciliation
venue: Online
bibliography: hts.bib
aliases:
  - /fr2023
---

9am UTC+11, *November 7, 10, 14, 17*

*Available to [IIF members](https://forecasters.org/membership/join/) only*

**Distinguished Lecture Series for the International Institute of Forecasters**

## Abstract

It is common to forecast at different levels of aggregation. For example, a retail company will want national forecasts, state forecasts, and store-level forecasts. And they will want them for all products, for groups of products, and for individual products. It is natural to want the forecasts to be "coherent" --- that is, that the forecasts add up in the same way as the data. For example, forecasts of regional sales should add up to forecasts of state sales, which should in turn add up to give a forecast for national sales.  Coherent forecasts are needed to allow effective planning, such as the allocation of resources across an organization based on forecasts of sales. Coherent forecasts are also more accurate than incoherent forecasts.

Over the past 15 years, forecast reconciliation methods have been developed to ensure forecasts are coherent. Forecasts at all levels of aggregation are produced, and the results are "reconciled" so they are consistent with each other.

I will provide an up-to-date overview of this area, and show how reconciliation methods can lead to better forecasts and better forecasting practices.

## Outline

*(Click title for slides)*

1. [**Hierarchical time series and forecast reconciliation**](https://github.com/robjhyndman/fr_iif/raw/main/fr1.pdf)

   * @hierarchical
   * @mint
   * @fasthts


2. [**Perspectives on forecast reconciliation**](https://github.com/robjhyndman/fr_iif/raw/main/fr2.pdf)

    * @Di_FonGir2022b
    * @htsgeometry
    * @wickramasuriya2021properties
    * @Van_ErvCug2015
    * @Ben_TaiEtAl2019
    * @nonnegmint
    * @ZhaEtAl2022
    * @lhf
    * @hfrml

3. [**Probabilistic forecast reconciliation**](https://github.com/robjhyndman/fr_iif/raw/main/fr3.pdf)

    * @smartmeterhts
    * @coherentprob
    * @CorEtAl2022
    * @fem

4. [**Temporal and cross-temporal forecast reconciliation**](https://github.com/robjhyndman/fr_iif/raw/main/fr4.pdf)

    * @temporal-hierarchies
    * @Di_FonGir2022a
    * @ctprob


## Software

* [hts package for R](https://pkg.earo.me/hts/)
* [thief package for R](http://pkg.robjhyndman.com/thief/)
* [fable package for R](https://fable.tidyverts.org)
* [FoReco package for R](https://danigiro.github.io/FoReco/)
* [hierarchicalforecast library for Python](https://nixtla.github.io/hierarchicalforecast/)
* [pyhts library for Python](https://angelpone.github.io/)
