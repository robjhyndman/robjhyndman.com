---
date: 2013-07-12 22:01:57+00:00
link: https://robjhyndman.com/hyndsight/user2013/
slug: user2013
title: Reflections on UseR! 2013
categories:
- computing
- conferences
- forecasting
- graphics
- R
- reproducible research
- statistics
---

This week I've been at the [R Users conference](http://www.edii.uclm.es/~useR-2013/) in Albacete, Spain. These conferences are a little unusual in that they are not really about research, unlike most conferences I attend. They provide a place for people to discuss and exchange ideas on how R can be used.

Here are some thoughts and highlights of the conference, in no particular order.

  1. [Håvard Rue](http://www.math.ntnu.no/~hrue/index_eng.html) spoke on Bayesian computing with INLA and the [R-INLA](http://www.r-inla.org/) package. I was unaware of INLA before, but it is a much faster way than MCMC to do some Bayesian computations. It looks useful --- I might try it sometime.

  2. Christoph Bergmeir (who has just finished visiting me at Monash for a few months) talked about the Rsiopred package (not yet on CRAN) which uses a fuzzy multicriteria approach to forecasting ETS models. Essentially, it tries to optimize RMSE, MAE and MAPE simultaneously, which will give biased forecasts of course, but hopefully more robust forecasts. The optimization is also better (in the sense of getting closer to the global optimum) than the `ets()` function in the forecast package. Christoph is also responsible for the big improvement in speed of the `ets()` function from v4.05 of the forecast package.

  3. José Manuel Benítez Sánchez (Christoph's boss) talked about the efforts of his team at the University of Granada to add [machine learning tools to CRAN](http://sci2s.ugr.es/dicits/index.php?p=software). Their [RSNNS package](http://dicits.ugr.es/software/RSNNS/) looks good. Next time I fit a neural net, I'll try it out.

  4. [Duncan Murdoch](https://www.uwo.ca/stats/people/bios/duncan-murdoch.html) gave an interesting talk on the new features in R 3.0.x and beyond. The most interesting part was that future releases will include the bug fixes and performance enhancements identified by [Radford Neal](http://radfordneal.wordpress.com/2013/06/22/announcing-pqr-a-faster-version-of-r/). In question time, Duncan explained why we will probably never have packages dependent on specific versions of other packages.

  5. [Steve Scott](http://stevethebayesian.com/) from Google talked about Bayesian structural time series models with regressors. Actually, I'd heard his coauthor (and boss) [Hal Varian](http://en.wikipedia.org/wiki/Hal_Varian) speak on the same subject at the [Operations Research conference in Rome](http://euro2013.org) last week. Look out for the bsts package when it is released on CRAN. It looks very useful.

  6. As usual, there were lots of people talking about Sweave and knitR for reproducible research. I quite like [knitR](http://yihui.name/knitr/) because it uses markdown which is a very simple document markup language. However, for my purposes, I still prefer keeping the tex and R files separate as explained [here](https://robjhyndman.com/hyndsight/makefiles/).

  7. I heard two nice talks on visualizing likert scale data by Kimberly Speerschneider (on the [likert package](https://github.com/jbryer/likert) not yet on CRAN) and [Richard Heiberger](http://astro.temple.edu/~rmh/) (on the [HH](http://cran.r-project.org/web/packages/HH/index.html) package). Likert scale data are the standard fare of surveys, so it is good to see some serious thinking being done on how to graph the data usefully.

  8. I had my first experience of lightning talks, where each person gets 5 minutes. These were surprisingly effective and interesting. I especially enjoyed Andy South on [mapping half a million signatures](http://andysouth.co.uk/wp-content/uploads/2013/07/useR2013-Lightning-AndySouth.pdf).

  9. I gave a talk on the hts package entitled [_R tools for hierarchical time series_](/seminars/hts-2). I am now working actively on hierarchical time series forecasting again, after a break from it for a couple of years. So expect to see more on this topic in the coming months. It has a lot of applications, and there is a lot still to be done to develop the theory, methodology and tools for handling hierarchical time series in practice.

  10. RStudio demonstrated their new debugging features to a few of us during one lunch break. In fact, they allowed us to download the pre-release version for our own use, but I'm not allowed to tell you the URL! However, if you google [[rstudio preview release]](https://www.google.com/search?q=rstudio+preview+release) you might find it. The debugging features are excellent, so look out for v0.98 available soon.

  11. I finally met the team from [Revolution Analytics](http://www.revolutionanalytics.com/), the people who produce Revolution R. Unfortunately, Revolution R is not available for 64-bit Ubuntu which is the platform I use.

  12. I was amazed at how much effort is going into making R work with gigantically enormous and humungous data sets. For me a seriously big data set has a few hundred thousand observations, but many people are working with terabytes, petabytes and even exabytes of data. Mind-boggling.

  13. I cannot get used to the Spanish habit of eating in the very late evening, while still getting up for the first session at 9am. The conference dinner began at 9.30pm, and I left just after 12.30am as I wanted to get some sleep. The party was apparently still going well after 2am, including Steve Scott who was doing the 9am talk the following morning!

  14. This the most tweeted conference I've attended. See [the stream](https://twitter.com/search?q=%23user2013&src=hash).

  15. I got to meet several people I've known electronically for years, but never met in person including [Colin Gillespie](http://www.mas.ncl.ac.uk/~ncsg3/) (who was part of the first moderator team on [crossvalidated.com](http://crossvalidated.com)) and [Tal Galili](http://www.r-statistics.com/) (responsible for maintaining [R-bloggers](http://www.r-bloggers.com/)).

Thanks to the committee and sponsors for making it a great conference. The next one is in California: [UseR! 2014](http://user2014.stat.ucla.edu/).
