---
date: 2009-08-24 00:40:06+00:00
link: https://robjhyndman.com/hyndsight/tests/
slug: tests
title: Why I don't like statistical tests
categories:
- forecasting
- statistics
---

It may come as a shock to discover that a statistician does not like statistical tests. Isn't that what statistics is all about? Unfortunately, in some disciplines statistical analysis does seem to consist almost entirely of hypothesis testing, and therein lies the problem.

The standard practice is to construct a hypothesis test to determine if some attribute of the data is "significant" or not, with the standard p-value threshold of 5%. The analysis is perceived to be completed when the p-value comes in under 5%. However, any non-trivial hypothesis will be significant if enough data are collected. As George Box said, "all models are wrong, but some are useful". So collecting more data will demonstrate that the proposed hypothesis is wrong, but that doesn't make it useless.

Then there is the common confusion between statistically significant and practically significant. Just because something is significant, doesn't mean it is important. And just because a p-value is larger than 0.05 does not mean the null hypothesis is true. Statisticians learn all this in first year, but still the research literature is riddled with papers that imply otherwise.

The next problem is that p-values are extremely sensitive to collinearity. Consequently, to use p-values based on t-tests to determine the significance of terms in a regression is silly. Often terms will appear insignificant, yet they should be included as they improve the predictions. Yet this approach is probably the most common method for determining what variables to include in a regression, even in some standard textbooks. The situation is even worse in autoregression, where the collinearity is often very strong.

Another thing I dislike about statistical tests is the alternative hypothesis. This was not originally part of hypothesis testing as proposed by Fisher. It was introduced by Neyman and Pearson. Frankly, the alternative hypothesis is unnecessary. It is not used in the computation of p-values or for determining statistical significance. The only practical use for the alternative hypothesis that I can see is in determining the power of a test.

Finally, I hate one-sided tests even more than two-sided tests. It's little better than cheating. You claim that a parameter can only possibly move in one direction, and thereby cut your p-value in half. I suspect it is usually done to obtain significant results in order to increase the chances of publication. In reality, can we ever be really sure that a parameter can only be zero or positive?

Now a good statistician can avoid all of these errors and use statistical tests honestly and appropriately. And I do occasionally use tests in my papers, hopefully avoiding the above problems. But I strongly prefer the predictive modelling approach. That is, if you have two potential models, choose the one that predicts best. Information criteria, such as the AIC, are perfect for this task.

In forecasting, the only  place in which I find testing useful is in determining the order of integration of a time series; i.e., choosing d in an ARIMA(p,d,q) model. If I could come up with some way of doing this effectively without using a unit-root test, I would gladly do so. But so far, I have not found a reliable alternative.

For more on this topic, see my [working paper](/publications/forecasting-without-significance-tests) with Andrey Kostenko.
