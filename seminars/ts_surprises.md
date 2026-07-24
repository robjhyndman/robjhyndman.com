---
date: TBD
title: "Surprises in time series analysis"
venue: TBD
bibliography:
  book: weird.bib
  papers: surprisals.bib
filters:
  - multibib
citeproc: false
validate-yaml: false
nocite: |
   - @lookout
   - @lookout2
   - @surprisalevt
   - @weird
---

## Abstract

I will present a statistical framework for identifying anomalies in three related time series settings: unusual observations within a single historical series, unusual series within a large collection, and real-time surveillance of incoming data streams.

In each case, anomalies are identified using a probabilistic approach based on 'surprisal values' --- equal to minus the log (conditional) density of each observation --- with extreme value theory used to model the tail of the surprisal distribution and avoid strong parametric assumptions.

The methods will be illustrated using the [{weird}](https://pkg.robjhyndman.com/weird/) package for R, with examples including French and US mortality rates, and pharmaceutical sales.

## Software

[![](https://pkg.robjhyndman.com/weird/reference/figures/weird-hex.png){width=130px fig-alt="weird package hex logo"}](https://pkg.robjhyndman.com/weird/)

## Book

::: {#refs-book}
:::
