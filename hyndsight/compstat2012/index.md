---
date: 2012-08-28 11:38:28+00:00
link: https://robjhyndman.com/hyndsight/compstat2012/
slug: compstat2012
title: COMPSTAT2012
categories:
- computing
- R
- reproducible research
- statistics
---

This week I'm in Cyprus attending the [COMPSTAT2012 conference](http://compstat2012.org). There's been the usual interesting collection of talks, and interactions with other researchers. But I was struck by two side comments in talks this morning that I'd like to mention.

### [Stephen Pollock](http://en.wikipedia.org/wiki/David_Pollock,_3rd_Viscount_Hanworth): Don't imagine your model is the truth

Actually, Stephen said something like "economists (or was it econometricians?) have a bad habit of imagining their models are true". He gave the example of people asking whether GDP "has a unit root"? GDP is an economic measurement. It no more has a unit root than I do. But the models used to approximate the dynamics of GDP may have a unit root. This is an example of confusing your data with your model. Or to put it the other way around, imagining that the model is true rather than an approximation. A related thing that tends to annoy me is to refer to the model as the "data generating process". No model is a data generating process, unless the data were obtained by simulation from the model. Models are only ever approximations, and imagining that they are data generating processes only leads to over-confidence and bad science.

### [Matías Salibián-Barrera](http://www.stat.ubc.ca/~matias/): Make all your code public

After giving an interesting survey of the [robustbase](http://cran.r-project.org/web/packages/robustbase/) and [rrcov](http://cran.r-project.org/web/packages/rrcov/) packages for R, Matías spent the last ten minutes of his talk presenting the case for reproducible research and arguing for making R code public as much as possible.  The benefits of making our code public are obvious:


  * The research can be reproduced and checked by others. This is simply good science.

  * Your work will be cited more frequently. Other researchers are much less likely to refer to your work if they have to implement your methods themselves. But if you make it easy, then people will use your methods and consequently cite your papers.

He also said something like this: "Don't wait until journals require you to submit code and data; start now by putting your code and data on a website." I agree. Every methodological paper should have an R package as a complement.  If that's too much work, at least put some code on a website so that other people can implement your method. What's the point of hiding your code? In some ways, the code is more important than the accompanying package as it represents a precise description of the method whereas the written paper may not include all the necessary details.
