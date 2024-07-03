---
title: "Forecast Linear Augmented Projection (FLAP): A free lunch to reduce forecast error variance"
date: "2024-07-03"
author:  Yangzhuoran Fin Yang, George Athanasopoulos, Rob J Hyndman, Anastasios Panagiotelis
github: FinYang/paper-forecast-projection
arxiv: 2407.01868
link: https://github.com/FinYang/paper-forecast-projection/raw/main/flap.pdf
categories: Working papers
aliases:
  - /flap
---

A novel forecast linear augmented projection (FLAP) method is introduced, which reduces the forecast error variance of any unbiased multivariate forecast without introducing bias. The method first constructs new component series which are linear combinations of the original series. Forecasts are then generated for both the original and component series. Finally, the full vector of forecasts is projected onto a linear subspace where the constraints implied by the combination weights hold. It is proven that the trace of the forecast error variance is non-increasing with the number of components, and mild conditions are established for which it is strictly decreasing. It is also shown that the proposed method achieves maximum forecast error variance reduction among linear projection methods. The theoretical results are validated through simulations and two empirical applications based on Australian tourism and FRED-MD data. Notably, using FLAP with Principal Component Analysis (PCA) to construct the new series leads to substantial forecast error variance reduction.
