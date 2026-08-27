---
author: Ingrida Steponavičė, Rob J Hyndman, Kate Smith&#8209;Miles, Laura Villanova
Status: Published
date: 2017-01-18 20:35:24+00:00
title: Dynamic Algorithm Selection for Pareto Optimal Set Approximation
categories: Articles
tags:
- data science
- optimization
file: dynamic-algorithm-selection.pdf
bibkey: dynamicpareto
---

This paper presents a meta-algorithm for approximating the Pareto optimal set of costly black-box multiobjective optimization problems given a limited number of objective function evaluations. The key idea is to switch among different algorithms during the optimization search based on the predicted performance of each algorithm at the time. Algorithm performance is modeled using a machine learning technique based on the available information. The predicted best algorithm is then selected to run for a limited number of evaluations. The proposed approach is tested on several benchmark problems and the results are compared against those obtained using any one of the candidate algorithms alone.
