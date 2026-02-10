---
title: "ggtime: A grammar of temporal graphics"
date: "2025-10-30"
author:  Cynthia A Huang, Mitchell O'Hara-Wild, Rob&nbsp;J&nbsp;Hyndman, Matthew Kay
arxiv: 2510.25656
categories: Working papers
---

Visualizing changes over time is fundamental to learning from the past and anticipating the future. However, temporal semantics can be complicated, and existing visualization tools often struggle to accurately represent these complexities. It is common to use bespoke plot helper functions designed to produce specific graphics, due to the absence of flexible general tools that respect temporal semantics. We address this problem by proposing a grammar of temporal graphics, and an associated software implementation, [`ggtime`](https://pkg.mitchelloharawild.com/ggtime/dev), that encodes temporal semantics into a declarative grammar for visualizing temporal data. The grammar introduces new composable elements that support visualization across linear, cyclical, quasi-cyclical, and other granularities; standardization of irregular durations; and alignment of time points across different granularities and time zones. It is designed for interoperability with other semantic variables, allowing navigation across the space of visualizations while preserving temporal semantics.

[R package: **ggtime**](https://pkg.mitchelloharawild.com/ggtime/dev)
