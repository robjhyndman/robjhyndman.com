---
date: 2013-07-03 21:19:13+00:00
link: https://robjhyndman.com/hyndsight/aic/
slug: aic
title: Facts and fallacies of the AIC
categories:
- forecasting
- R
- statistics
---

Akaike's Information Criterion (AIC) is a very useful model selection tool, but it is not as well understood as it should be. I frequently read papers, or hear talks, which demonstrate misunderstandings or misuse of this important tool. The following points should clarify some aspects of the AIC, and hopefully reduce its misuse.<!-- more -->



  1. The AIC is a penalized likelihood, and so it requires the likelihood to be maximized before it can be calculated. It makes little sense to compute the AIC if estimation is done using something else (e.g., minimizing MAPE). Normally, the residuals are assumed to be Gaussian, and then ML estimates are often (but not always) equivalent to LS estimates. In these cases, computing the AIC after minimizing the MSE is ok.

  2. A model selected by the AIC after Gaussian MLE will give predictions equal to the conditional mean. If you then compare the predictions using MAE, or MAPE, or some other criterion, they may not perform well because these other criteria are not optimal for the conditional mean. Match the error measure to the estimation method.

  3. The AIC does not assume the residuals are Gaussian. It is just that the Gaussian likelihood is most frequently used. But if you want to use some other distribution, go ahead. The AIC is the penalized likelihood, whichever likelihood you choose to use.

  4. The AIC does not require nested models. One of the neat things about the AIC is that you can compare very different models. However, make sure the likelihoods are computed on the same data. For example, you cannot compare an ARIMA model with differencing to an ARIMA model without differencing, because you lose one or more observations via differencing. That is why auto.arima uses a unit root test to choose the order of differencing, and only uses the AIC to select the orders of the AR and MA components.

  5. For a similar reason, you cannot compare the AIC from an ETS model with the AIC from an ARIMA model. The two models treat initial values differently. For example, after differencing, an ARIMA model is computed on fewer observations, whereas an ETS model is always computed on the full set of data. Even when the models are equivalent (e.g., an ARIMA(0,1,1) and an ETS(A,N,N)), the AIC values will be different. Effectively, the likelihood of an ETS model is conditional on the initial state vector, whereas the likelihood of a non-stationary ARIMA model is conditional on the first few observations, even when a diffuse prior is used for the nonstationary components.

  6. Beware of AIC values computed using conditional likelihoods because the conditioning may be different for different models. Then the AIC values are not comparable.

  7. Frequently, the constant term in the AIC is omitted. That is fine for model selection as the constant is the same for all models. But be careful comparing the AIC value between software packages, or between model classes, as they may treat the constant term differently, and then the AIC values are not comparable.

  8. The AIC is not really an "in-sample" measure. Yes, it is computed using the training data. But asymptotically, minimizing the AIC is equivalent to minimizing the leave-one-out cross-validation MSE for cross-sectional data, and equivalent to minimizing the out-of-sample one-step forecast MSE for time series models. This property is what makes it such an attractive criterion for use in selecting models for forecasting.

  9. The AIC is not a measure of forecast accuracy. Although it has the above cross-validation property, comparing AIC values across data sets is essentially meaningless. If you really want to measure the cross-validated MSE, then you will need to calculate it directly.

  10. The AIC is not a consistent model selection method. That does not bother me as I don't believe there is a true model to be selected. The AIC is optimal (in some senses) for forecasting, and that is much more important in my opinion.

There are some further helpful clarifications in [AIC Myths and Misunderstandings](https://sites.warnercnr.colostate.edu/anderson/wp-content/uploads/sites/26/2016/11/AIC-Myths-and-Misunderstandings.pdf) by Anderson and Burnham.
