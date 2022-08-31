---
date: 2010-09-20 09:23:19+00:00
slug: tfc1
title: 'Tourism forecasting competition results: part one'
categories:
- forecasting
- kaggle
---

The first stage of the [tourism forecasting competition on kaggle](https://www.kaggle.com/c/tourism1) has finished. This stage involved forecasting 518 annual time series. Twenty one teams beat [our Theta method benchmark](https://robjhyndman.com/hyndsight/tourism-forecasting-competition/) which is a great result, and well beyond our expectations. Congratulations to [Lee Baker](http://www.leecbaker.com/) for winning stage one.

I am yet to learn what methods the top teams were using, but we hope to write up a paper for the IJF describing the results. Of course, the winning team (overall) gets to write their own discussion paper for the IJF.

Stage 2 of the competition is now open and involves forecasting 366 monthly time series and 427 quarterly time series. In this case, the best result in our paper for the monthly data was the automatic ARIMA algorithm ([Hyndman & Khandakar, 2008](/publications/automatic-forecasting/)) with a MASE of 1.38. For quarterly data, the ETS(A,Ad,A) model performed slightly better than our ARIMA algorithm with a MASE of 1.43. Let's see how much better everyone else can do! Head over to [kaggle](https://www.kaggle.com/c/tourism2) and get the data. Entries close on 31 October 2010.
