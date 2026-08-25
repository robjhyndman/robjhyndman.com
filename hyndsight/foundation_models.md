---
title: "Evaluating time series foundation model claims"
date: 2026-08-25
categories:
  - forecasting
bibliography: [foundation.bib]
image: https://otexts.com/fpp3/fpp_files/figure-html/cv1-1.png
csl: ../files/apa-single-spaced.csl
description: >-
  *I was emailed by a journalist writing an article about time series foundation models.*
  *Here is my response.*
  *While the questions were about a specific new transformer model, the comments are more widely applicable, so I've edited my answer to be more generic.*
---

As background, I would point you to my online forecasting textbook where we have a chapter on foundation models\ [@fpppy].
Another excellent reference on this topic is Christoph Bergmeir's paper "LLMs and Foundational Models: Not (Yet) as Good as Hoped"\ [@Bergmeir2024llms].

**1.\ How significant a change do time series foundation models represent for the practice of forecasting?**

They're a real shift in how forecasts get *produced*, but not yet a demonstrated shift in how *accurate* forecasts are in general.
The genuine change is architectural and operational: instead of building, tuning and maintaining a separate model for every series, an organisation can point a single pre-trained model at a new dataset and get a forecast with no dataset-specific training or model selection.
That lowers the barrier to entry for forecasting at scale, particularly for teams without in-house statistical expertise.

What it hasn't yet done is replace the case for careful statistical modelling.
The strongest independent critique of the field is @Bergmeir2024llms who found that when you check the reported empirical results, the performance is often nowhere near as good as claimed.
Often the statistical benchmarks are implemented poorly, or missing altogether, or highly selective.
So these foundation models are an important development, but they are not close to being the panacea that many of the companies behind them are claiming.

**2.\ How should organisations compare foundation models with well-tuned statistical or task-specific approaches, particularly considering accuracy and cost?**

First, make sure the statistical baseline is actually well implemented.
This is the single biggest problem @Bergmeir2024llms identifies in the foundation-model literature: papers routinely compare against under-tuned or de-ensembled versions of classical methods, then claim victory.
So I would be asking: what exactly were the statistical benchmarks, how were they tuned, and were they given the same advantages (ensembling, proper cross-validation) as in the studies that established them as strong benchmarks in the first place?

Second, evaluate on your own data with proper rolling-origin backtesting, not on a vendor's leaderboard, or even a public community leaderboard.
Public benchmark scores are increasingly unreliable as measures of genuine out-of-sample skill because the data used in comparisons was also used in training.
This "leakage" is a growing problem -- see @meyer2025rethinking who found that of 401 datasets used across 22 published time-series foundation models, only 6% had never appeared in any model's pre-training or fine-tuning corpus.
Also, historical series that are not in the training data can be correlated with series that are in the training data due to being subject to the same environmental shocks (e.g., COVID).
So even if there is not direct leakage, there can be indirect leakage induced by correlations.
Therefore, these comparisons on historical data are not a great guide to what the models will do on new data.

Third, weigh total cost, not just error metrics.
Well-implemented statistical models (ETS, ARIMA, Theta, and simple combinations of these) are cheap, transparent, fast, and easy to explain.
Foundation models bring inference cost, latency, hosting/vendor dependency, and limited interpretability.
Even if the accuracy gain over a well-tuned statistical model is real, the operational cost may not be worth it.

**3.\ What do current benchmarks fail to tell us about how these models will perform in real production settings?**

1. Public leaderboards report an aggregate score across many datasets and domains at once, which can hide wide variance in performance on the specific kind of series a given business actually needs to forecast.
2. As noted above, they carry a real contamination risk which may render the benchmark unreliable.
3. Benchmarks rarely report the things that determine whether a model is usable in production: inference latency at the volumes a business needs, hosting and total compute cost, robustness to structural breaks and regime changes, how the model handles exogenous variables and irregular/missing data, and how failures are detected and explained when they occur.
   A model that tops a MASE leaderboard by a small margin but takes an order of magnitude longer to run, or performs poorly on genuinely new data, may be the wrong choice operationally even if it's the "best" model on paper.
