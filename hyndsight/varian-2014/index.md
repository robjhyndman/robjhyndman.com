---
date: 2014-06-15 22:45:21+00:00
link: https://robjhyndman.com/hyndsight/varian-2014/
slug: varian-2014
title: Varian on big data
categories:
- computing
- econometrics
- forecasting
- R
- references
- research team
- statistics
---

Last week my research group discussed Hal Varian's interesting new paper on ["Big data: new tricks for econometrics"](http://www.aeaweb.org/articles.php?doi=10.1257/jep.28.2.3), _Journal of Economic Perspectives_, **28**(2): 3-28.

It's a nice introduction to trees, bagging and forests, plus a very brief entree to the LASSO and the elastic net, and to slab and spike regression. Not enough to be able to use them, but ok if you've no idea what they are. <!-- more -->

It was more disappointing on boosting (completely ignoring the fact that boosting can be applied in a regression context as well as a classification context), and his comments on causality seemed curiously naive. His suggested approach involved forecasting using all variables but the one that is considered causal, and then comparing the results against what actually happened. That seems at least as likely to lead to false conclusions on causality as instrumental variables or differences-in-differences. Although Varian cites [Pearl's work](http://buy.geni.us/Proxy.ashx?TSID=140570\&GR_URL=http%3A%2F%2Fwww.amazon.com%2Fdp%2F0521773628/) approvingly, I doubt that Pearl would return the favour.

On a positive note, his Bayesian Structural Time Series model (which I heard him speak about in Rome 12 months ago) seems interesting and very useful. I wonder when the promised R package will appear?
