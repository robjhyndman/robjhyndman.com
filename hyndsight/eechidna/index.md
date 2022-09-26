---
date: 2016-05-27 04:07:11+00:00
link: https://robjhyndman.com/hyndsight/eechidna/
slug: eechidna
title: Explore Australian Elections Data with R
categories:
- data science
- graphics
- R
- statistics
---

This is a guest post by my colleague [Professor Di Cook](http://dicook.org), cross-posted from her [Visiphilia blog](http://visiphilia.org/2016/05/26/eechidna). Di and I are two of the authors of the new [eechidna package for R](https://github.com/ropenscilabs/eechidna), now [on CRAN](https://cran.r-project.org/package=eechidna).<!-- more -->

* * *

The `eechidna` package has just been [posted on CRAN](https://cran.r-project.org/package=eechidna), in time for the longest election campaign in Australia since the 1950s. The next Federal election scheduled for 2nd July was announced a few weeks ago. A little before this a handful of academics met at the first ever Australian ROpenSci Unnconference at the Microsoft headquarters in Brisbane in an event primarily organised by students at the Queensland University of Technology.

Making it easier to examine data associated with the Australian electorate was one of the projects tackled, and this led to the eechidna (Exploring Election and Census Highly Informative Data Nationally for Australia) package for R, a collaboration between Ben Marwick, Heike Hofmann, Rob Hyndman, Carson Sievert, Nick Tierney, Nathaniel Tomasetti, Thomas Lumley, Di Cook and Fan Zhou. The package has several key components:


  * **Data**: (1) results from the 2013 election by electorate and polling place, (2) demographic information on each electorate from the most recent Census, (3) spatial boundaries of electorates for map drawing, (4) Dorling cartogram locations for each electorate to enable even the densest packed population bases to be examined

  * **Code**: (1) Functions for pulling new electorate boundaries and wrangling these into point and line data sets for plotting with census and election results data, (2) cartogram functions to produce new electorate layouts on-the-fly

  * **Vignettes**: Five vignettes describing how to use the package to examine the Census data, the election results, convert the GIS shape files into R objects, how to plot the resulting polygons, or cartogram views, and how to download the location of polling stations and overlay these on the map

  * **App**: a shiny app using the plotly package to explore election results in relation to demographics.

The purpose of this exercise is to demonstrate the usefulness of open data, and what open source software can provide to users who want to learn about the Australian electorate. And most importantly to provide tools so that you, with a little knowledge of R, can explore on your own too.

These are some of the things that you can look at:

## Census data

Median income in each electorate plotted by state (below) shows that the ACT is uniformly high (only two electorates), followed the Northern Territory with one high and one low, and the three highest median income electorates of all are in NSW.

![](http://visiphilia.github.io/assets/eechidna-figures/income-boxplot.png)

You can also look at population size, %unemployed, %educational qualifications, religious affiliation, age profiles, family structure, home language and %born overseas.

## Election results

The results of the past election can be explored. Below a bar chart of the senate makeup for each state is shown, and a dotplot of number of electorates won by party.

![](http://visiphilia.github.io/assets/eechidna-figures/senate.png)

![](http://visiphilia.github.io/assets/eechidna-figures/electorate-count.png)

## Mapping results

The current party elected in each electorate can be displayed on the map, or on a cartogram, as shown below.

![](http://visiphilia.github.io/assets/eechidna-figures/electorate-results.png)

![](http://visiphilia.github.io/assets/eechidna-figures/electorate-carto.png)

## Explore interactively

The best part of the package is the shiny app, where you can explore association between demographics and political leanings. The video below shows how it can be used. The electorates with a Liberal Party member electorate are selected and coloured green, and those with an Australian Labor Party member elected are selected and coloured burnt orange. These electorates have some characteristics that are expected:

Labor electorates tend to have:


  * higher proportions of young voters,

  * higher percentages of unemployed,

  * higher populations.

This last one is a surprise, and actually could indicate an unfairness in the current electoral boundaries. Because the labor electorates tend to have larger numbers of people, it means that these peoples' votes count less than those in the smaller populated electorate dominated by liberal members. Ideally, for "one person=one vote" all electorates would be of equal population size . This is a goal, and there are some geographic limitations, which force some discreteness. An example is Tasmania, where electorate boundaries are limited to the island, and cannot be merged with chunks of the mainland. So if the small electorates corresponded to Tasmania it would be reasonable, BUT the smaller electorates are distributed across the country. This strongly suggests that "one person=one vote" is not in practice in Australia, and there is a bias towards upweighting Liberal Party votes.

[Exploring the Australian electorate](https://vimeo.com/167367369) from [Di Cook](https://vimeo.com/user14048736) on [Vimeo](https://vimeo.com).
