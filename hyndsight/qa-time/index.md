---
date: 2016-10-23 11:21:35+00:00
link: https://robjhyndman.com/hyndsight/qa-time/
slug: qa-time
title: Q&A time
categories:
- consulting
- data science
- forecasting
- R
---

Someone sent me some questions by email, and I decided to answer some of them here.<!-- more -->

>How important is it that I know and understand the underlying mathematical framework to forecasting methods? I understand conceptually how most of them work, but I feel as if I may benefit from truly understanding the math.

The main benefit of understanding the mathematics behind different forecasting models is to be able to adapt the models when they don't work well for your data. I've tried to develop tools that are very easy to use even if you don't know much about time series models, but you need a deeper understanding if you want to modify the models, or develop new models. If forecasting is your main job task, it would be a good idea to get a deep level of training in how forecasting models work and how to adapt them.

>Do you offer paid training over Skype?

No.

>What are your thoughts on gradient boosted trees? It appears Kaggle winners tend to use it on time series problems by throwing many different models/features into the algorithm and let it decide which to use and how to weight them.

If you have thousands of similar time series, then building a model across all series can be very powerful. Whether that mega-model uses deep learning or gradient boosting or something else depends on the number of time series you have, the number of features you want to include, and the complexity of the relationships.

>Why don’t you create your own forecasting software like autobox/forecastX? It seems like a lucrative endeavor with your knowledge!

I _have_ created my own forecasting software. It is the [forecast package for R](https://cran.r-project.org/package=forecast).

Presumably you mean, why don't I create my own _commercial_ software? Because my life objective is not income maximization. I am well-paid by my university, and I would rather spend my time making the world a better place by developing free resources.

So many people ask me why I don't do this or that, with the underlying unstated assumption being that making more money is a good thing. I disagree. I need enough money to live comfortably, but not more.

>I know neural networks performed worse than other methods for the M3 competition. Have there been any worthwhile advances in that space that I should research (such as LSTM)?

In general, individual time series are too short for effective modelling using neural networks. And even if you have very long time series, most likely the data at the start of the series are not so useful for forecasting now, because the underlying patterns and relationships have changed. So I do not think that neural networks will ever be particularly effective for univariate time series forecasting. You would need a very long series (at least thousands of observations) from a very stable system.

The benefit of neural networks for time series comes when you have a large number of related time series, and you can build a model for all series together. I am aware of some organizations using deep learning for millions of time series and it seems to work extremely well.

I don't know anything about LSTM -- yet another development that I will eventually have to read up on.

>I recently interviewed for a tech company. During 2 of the interviews the interviewer asked me “what is your forecasting accuracy?” I attempted to explain that my answer gives them no valuable information, since all time series have different noise to signal ratios, patterns, etc. They wanted none of it and made me give them an answer. Then I found out that job performance is partly based on forecast accuracy. In my mind, these are big red flags, but what are your thoughts? Have you come across this before?

Yes, I've seen these problems before, unfortunately.

Forecast accuracy can only ever be relative -- how well can you forecast compared to other people/models on the same problem?

Job performance should not be based on forecast accuracy. Accuracy computed on a small test set is prone to so much uncertainty that the relative accuracy is largely random. Even over the 3003 time series in the M3 competition, there is no significant difference between the top 2--3 methods ([Koning et al, IJF 2005](http://dx.doi.org/10.1016/j.ijforecast.2004.10.003)).

This is the same problem that Deming observed -- rewarding employees based on measures of performance is usually a bad idea, because those measures are subject to randomness, and also because it discourages teamwork. See this great interview with him discussing the problem:
