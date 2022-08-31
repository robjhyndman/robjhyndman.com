---
date: 2014-02-12 08:26:42+00:00
link: https://robjhyndman.com/hyndsight/hts4/
slug: hts4
title: 'Hierarchical forecasting with hts v4.0 '
categories:
- computing
- forecasting
- fpp
- hts
- R
- statistics
---

A new version of my [`hts` package for R](http://cran.r-project.org/web/packages/hts/) is now on CRAN. It was completely re-written from scratch. Not a single line of code survived. There are some minor syntax changes, but the biggest change is speed and scope. This version is many times faster than the previous version and can handle hundreds of thousands of time series without complaining. <!-- more -->

The speed-up is due to some new research I am doing with [Alan Lee](https://www.stat.auckland.ac.nz/~lee/) (University of Auckland). Usually, we would write the paper first, and then release a package implementing the ideas. But this time, the package was produced first and the papers will follow in the next few weeks.

For those unfamiliar with the techniques and concepts involved with hierarchical forecasting, there is an introduction in [Section 9.4 of my forecasting textbook](http://www.otexts.org/fpp/9/4). The basic idea is that you need to forecast a large number of time series under the constraint that the forecasts of some series have to add up to equal the forecasts of other series. For example, the forecasts of sales in each state need to equal to the forecasts of sales across the country. Our approach is to forecast all series independently, ignoring the constraints. Then adjust all the forecasts so the constraints are satisfied. We have a neat result that gives the optimal (least squares) reconciliation.

Users of previous versions of the package should read [the vignette](http://cran.r-project.org/web/packages/hts/vignettes/hts.pdf) (pp.10-11) which explains some syntax and function changes.

Regular readers of this blog will have noticed a couple of references to my new research assistant, [Earo Wang](http://earo.me). She has been working with me on R package development over the Australian summer. The new version of the hts package was one of the main projects she has worked on, and the many improvements are largely due to her considerable talents!
