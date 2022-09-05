---
author: Jan Verbesselt, Rob J Hyndman, Achim Zeilis, Darius Culvenor
Status: Published
date: 2010-08-17 08:05:10+00:00
slug: bfast2
title: Phenological change detection while accounting for abrupt and gradual trends in satellite image time series
wordpress_id: 1382
kind:
 article
tags:
- remote sensing
- seasonality
- time series
details: "<em>Remote Sensing of Environment</em>, <b>114</b>(12), 2970-2980"
file: SeasonalBreakDetection_revised_4x00.pdf
doi: 10.1016/j.rse.2010.08.003
---


A challenge in phenology studies is understanding what constitutes significant phenological change amidst background  variation (e.g. noise) and ecosystem disturbances (e.g. fires). The majority of phenological studies have focussed on extracting critical points in the seasonal growth cycle (e.g. Start-of-spring), without exploiting the full temporal detail. Moreover, the high degree of phenological variability between years demonstrates the necessity of distinguishing long term phenological change from temporal variability. Here, we evaluate the phenological change detection ability of a method for detecting Breaks For Additive Seasonal and Trend (BFAST). BFAST integrates the decomposition of time series into trend, seasonal, and noise components with methods for detecting change within time series. BFAST detects significant phenological changes within time series by exploiting the full time series without needing to derive phenological metrics. The times and numbers of trend and phenological changes are iteratively estimated by fitting piecewise robust linear models, of which the parameters are used to characterize change by its magnitude and direction. We tested BFAST by simulating 16-day Normalized Difference Vegetation Index (NDVI) time series with varying amounts of seasonality and noise, containing abrupt disturbances (e.g. fires) and long term phenological changes. This revealed that BFAST is able to accurately detect the number and timing of phenological changes within time series while accounting for disturbances (e.g. fires) and noise. The simulation study also showed that the phenological change detection is influenced by the signal to noise ratio of the time series. Application of the method on 16-day NDVI MODIS images from 2000 until 2009 for a forested study area in south eastern Australia confirmed these results. Phenological change is more easily detected in grasslands where the seasonal amplitude is larger than 0.3 NDVI when compared to evergreen forests where the seasonal amplitude is approximately 0.1 NDVI while noise levels were the same. BFAST present a novel approach for the detection of significant long term phenological changes within full time series which is necessary to study spatio-temporal patterns in land cover phenology, distinguish change from interannual variability in a global change context. The method can be applied to other disciplines dealing with seasonal time series data, such as biology, hydrology, and climatology to detect and characterize change within time series. The methods described in this study are available in the [BFAST package for R](http://cran.rstudio.com/package=bfast) (R Development Core Team, 2009).

**Keywords:** seasonal change, phenology, change detection, time series, disturbance,climate change, remote sensing, NDVI, MODIS.
