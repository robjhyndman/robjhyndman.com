---
date: 2010-11-24 12:52:00+00:00
link: https://robjhyndman.com/hyndsight/tfc2/
slug: tfc2
title: Tourism forecasting competition ends
categories:
- forecasting
- IJF
- kaggle
---

And the winners are ... [Jeremy Howard and Lee C Baker](http://kaggle.com/team?team_id=1145). (See my [earlier post](https://robjhyndman.com/hyndsight/tfc1/) for information about the competition.)

Jeremy describes his approach to seasonal time series in a [blog post on Kaggle.com](http://kaggle.com/blog/2010/11/24/how-we-did-it-jeremy-howard-on-winning-the-tourism-forecasting-competitoin/). Lee described his approach to annual time series in an [earlier post](http://kaggle.com/blog/2010/09/27/how-i-did-it-lee-baker-on-winning-tourism-forecasting-part-one/).

A few lessons that come out of this:


  * For data from a single industry, using a global trend (i.e., estimated across all series) can be useful.

  * Combining forecasts is a good idea. (This lesson seems to be re-learned in every forecasting competition!)

  * The MASE can be very sensitive to a few series, and to optimize MASE it is worth concentrating on these. (This is actually not a good message for forecasting overall, as we want good forecasts for all series. Maybe we need to find a metric with similar properties to MASE but with a less skewed distribution.)

  * Outlier removal before forecasting can be effective. (This is an interesting result as outlier removal algorithms used in the M3 competition did not help forecast accuracy.)

Jeremy and Lee receive $500 for their efforts and they have decided to donate their prize money to the [Fred Hollows Foundation](http://www.hollows.org.au/). $500 will restore vision to 20 people. They will also write up their methods in more detail for the _International Journal of Forecasting_. I am hopeful that Philip Brierley of team [Sali Mali](http://kaggle.com/team?team_id=1451) (who did very well in the second stage of the competition) will also write a short explanation of his methods for the _IJF_.

Thanks to everyone who participated in the competition. Thanks also to Anthony Goldbloom from [Kaggle](http://kaggle.com) for hosting the competition. [Kaggle](http://kaggle.com) is a wonderful platform for prediction competitions and I hope it will be used for many more competitions of this type in the future.
