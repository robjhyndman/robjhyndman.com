---
author: Fan Cheng, Rob J Hyndman, Anastasios Panagiotelis
date: 2024-09-12
slug: kderm
title: "Distortion corrected kernel density estimator on Riemannian manifolds"
categories: Working papers
tags:
- data science
- anomaly detection
- manifold learning
link: https://raw.githubusercontent.com/ffancheng/kderm/master/jcgs/kderm_jcgs.pdf
github: ffancheng/kderm
---

Manifold learning obtains a low-dimensional representation of an underlying Riemannian manifold supporting high-dimensional data. Kernel density estimates of the low-dimensional embedding with a fixed bandwidth fail to account for the way manifold learning algorithms distort the geometry of the Riemannian manifold. We propose a novel distortion-corrected kernel density estimator (DC-KDE) for any manifold learning embedding, with a bandwidth that depends on the estimated Riemannian metric at each data point. Exploiting the geometric information of the manifold leads to more accurate density estimation, which subsequently could be used for anomaly detection. To compare our proposed estimator with a fixed-bandwidth kernel density estimator, we run two simulations including one with data lying in a 100 dimensional ambient space. We demonstrate that the proposed DC-KDE improves the density estimates as long as the manifold learning embedding is of sufficient quality, and has higher rank correlations with the true manifold density. Further simulation results are provided via a supplementary  R shiny app. The proposed method is applied to density estimation in statistical manifolds of electricity usage with the Irish smart meter data.
