---
date: 2014-12-17 06:24:53+00:00
link: https://robjhyndman.com/hyndsight/mefm/
slug: mefm
title: New R package for electricity forecasting
categories:
- consulting
- energy
- forecasting
- R
---

Shu Fan and I have developed a model for electricity demand forecasting that is now widely used in Australia for long-term forecasting of peak electricity demand. It has become known as the "Monash Electricity Forecasting Model". We have decided to release an R package that implements our model so that other people can easily use it. The package is called "[MEFM](https://github.com/robjhyndman/MEFM-package)" and is [available on github](https://github.com/robjhyndman/MEFM-package). We will probably also put in on CRAN eventually.

The model was first described in  [Hyndman and Fan (2010)](/publications/peak-electricity-demand/). We are continually improving it, and the latest version is decribed in the [model documentation](/publications/mefm/) which will be updated from time to time.

The package is being released under a [GPL licence](https://www.gnu.org/copyleft/gpl.html), so anyone can use it. All we ask is that our work is properly cited.

Naturally, we are not able to provide free technical support, although we welcome [bug reports](https://github.com/robjhyndman/MEFM-package/issues). We are available to undertake [paid consulting work](http://www.buseco.monash.edu.au/ebs/consulting/) in electricity forecasting.
