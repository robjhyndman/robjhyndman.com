---
date: 2014-01-21 04:24:48+00:00
link: https://robjhyndman.com/hyndsight/nlts/
slug: nlts
title: Estimating a nonlinear time series model in R
categories:
- computing
- forecasting
- R
- statistics
- time series
---

There are quite a few [R packages available for nonlinear time series analysis](http://cran.r-project.org/web/views/TimeSeries.html), but sometimes you need to code your own models. Here is a simple example to show how it can be done.

The model is a first order threshold autoregression:

<div>
$$
y_t = \begin{cases}
\alpha y_{t-1} + e_t & \text{if $y_{t-1} \le r$}\\
\beta y_{t-1} + \gamma e_t & \text{if $y_{t-1}>r$}
\end{cases}
$$
</div>

where $e_t$ is a Gaussian white noise series with variance $\sigma^2$. The following function will generate some random data from this model.<!-- more -->


    simnlts <- function(n, alpha, beta, r, sigma, gamma, burnin=100)
    {
      # Generate noise
      e <- rnorm(n+burnin, 0, sigma)
      # Create space for y
      y <- numeric(n+burnin)
      # Generate time series
      for(i in 2:(n+burnin))
      {
        if(y[i-1] <= r)
          y[i] <- alpha*y[i-1] + e[i]
        else
          y[i] <- beta*y[i-1] + gamma*e[i]
      }
      # Throw away first burnin values
      y <- ts(y[-(1:burnin)])
      # Return result
      return(y)
    }


The "burn-in" parameter allows the first value of the series to be a random draw from the stationary distribution of the process (assuming it is stationary).

We will estimate the model by minimizing the sum of squared errors across both regimes. Other approaches that take account of the different variances in the two regimes may be better, but it is useful to keep it simple, at least initially. The following function uses a non-linear optimizer to estimate $\alpha$, $\beta$ and $r$. To ensure good starting values, we begin the optimization with $\alpha=\beta=0$ and set the initial value of $r$ to be the mean of the observed data.


    fitnlts <- function(x)
    {
      ss <- function(par,x)
      {
        alpha <- par[1]
        beta <- par[2]
        r <- par[3]
        n <- length(x)
        # Check that each regime has at least 10% of observations
        if(sum(x<=r) < n/10 | sum(x>r) < n/10)
          return(1e20)
        e1 <- x[2:n] - alpha*x[1:(n-1)]
        e2 <- x[2:n] - beta*x[1:(n-1)]
        regime1 <- (x[1:(n-1)] <= r)
        e <- e1*(regime1) + e2*(!regime1)
        return(sum(e^2))
      }
      fit <- optim(c(0,0,mean(x)),ss,x=x,control=list(maxit=1000))
      if(fit$convergence > 0)
        return(rep(NA,3))
      else
        return(c(alpha=fit$par[1],beta=fit$par[2],r=fit$par[3]))
    }


There are a few things to notice here.


  * I have used a function inside a function. The `ss` function computes the sum of squared errors. It would have been possible to define this outside `fitnlts`, but as I don't need it for any other purpose it is neater to define it locally.

  * Occasionally the optimizer will not converge, and then `fitnlts` will return missing values.

  * I have avoided the use of a loop by computing the errors in both regimes. This is much faster than the alternatives.

  * If $r$ is outside the range of the data, then either $\alpha$ or $\beta$ will be unidentifiable. To avoid this problem, I force $r$ to be such that each regime must contain at least 10% of the data. This is an arbitrary value, but it makes the estimation more stable.

  * The function being optimized is not continuous in the $r$ direction. This will cause gradient-based optimizers to fail, but the Nelder-Mead optimizer used here is relatively robust to such problems.

  * This particular model can be more efficiently estimated by exploiting the conditional linearity. For example, we could loop over a grid of $r$ values (e.g., at the mid-points between consecutive ordered observations) and use linear regression for the other parameters. But the above approach is more general and can be adapted to other nonlinear time series models.

The functions can be used as follows (with some example parameters):


    y <- simnlts(100, 0.5, -1.8, -1, 1, 2)
    fitnlts(y)


A similar approach can be used for other time series models.
