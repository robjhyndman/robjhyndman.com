---
author: Jan Verbesselt, Rob J Hyndman, Glenn Newnham, Darius Culvenor
Status: Published
date: 2010-01-14 23:21:12+00:00
slug: bfast1
title: Detecting trend and seasonal changes in satellite image time series
wordpress_id: 728
categories: Articles
tags:
- remote sensing
- seasonality
- time series
details: "<em>Remote Sensing of Environment</em> <b>114</b>(1), 106-115"
doi: 10.1016/j.rse.2009.08.014
---

A wealth of remotely sensed time series covering large areas is now available to the earth science community. Change detection methods are often not capable of detecting land cover changes within time series that are heavily influenced by seasonal climatic variations. Detecting change within the trend and seasonal components of time series enables the detection of different types of changes. Changes occurring in the trend component indicate disturbances (e.g., insect attack), while changes occurring in the seasonal component indicate phenological changes (e.g., change in land cover type). An approach is proposed for automated change detection in time series by detecting and characterizing Breaks For Additive Seasonal and Trend (BFAST). BFAST integrates the decomposition of time series into trend, seasonal, and remainder components with methods for detecting significant change within time series. BFAST iteratively estimates the time and number of changes, and characterizes change by its magnitude and direction.  We tested BFAST by simulating 16-day composites of Normalized Difference Vegetation Index (NDVI) time series with varying amounts of seasonality and noise, and by adding abrupt changes at different times and magnitudes. This revealed that BFAST can robustly detect change with different magnitudes (>0.1 NDVI) within time series with different noise levels (0.01--0.07 σ) and seasonal amplitudes (0.1--0.5 NDVI) Additionally, BFAST was applied to 16-day NDVI MODIS (Moderate Resolution Imaging Spectroradiometer) composites for a forested study area in south eastern Australia. This showed that BFAST is able to detect and characterize spatial and temporal changes in a forested landscape. BFAST is developed as a generic change detection approach, and can be applied to time series without the need to normalize for specific land cover types, select a reference period, or define a threshold or change trajectory. The method can be used to detect and characterize changes within time series or can be integrated within monitoring frameworks and used as an alarm system to flag when and where significant changes occur.

The methods in this paper are implemented in the [bfast package for R](http://cran.rstudio.com/package=bfast).
