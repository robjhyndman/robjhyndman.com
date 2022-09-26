---
date: 2014-06-15 03:26:38+00:00
link: https://robjhyndman.com/hyndsight/gts/
slug: gts
title: Specifying complicated groups of time series in hts
categories:
- computing
- forecasting
- hts
- R
- StackExchange
- statistics
- time series
---

With the latest version of the [hts package for R](http://github.com/robjhyndman/hts), it is now possible to specify rather complicated grouping structures relatively easily.

All aggregation structures can be represented as hierarchies or as cross-products of hierarchies. For example, a hierarchical time series may be based on geography: country, state, region, store. Often there is also a separate product hierarchy: product groups, product types, packet size. Forecasts of all the different types of aggregation are required; e.g., product type A within region X. The aggregation structure is a cross-product of the two hierarchies.

This framework includes even apparently non-hierarchical data: consider the simple case of a time series of deaths split by sex and state. We can consider sex and state as two very simple hierarchies with only one level each. Then we wish to forecast the aggregates of all combinations of the two hierarchies.

Any number of separate hierarchies can be combined in this way. Non-hierarchical factors such as sex can be treated as single-level hierarchies.<!-- more -->

The hts package stores the data only at the bottom (most disaggregated) level, and records information about the various types of aggregates that are of interest. The hts() function is appropriate for a single hierarchy (i.e., strictly hierarchical data). More complicated aggregation structures can be specified using the more general gts() function.

Here is an example, based on [a question asked on stackoverflow](http://stackoverflow.com/q/24191537). The problem involves a geographical hierarchy and an industrial classification hierarchy.

Suppose there are two states with four and five counties respectively, and two industries with three and two sub-industries respectively. So there are 9x5 series at the most disaggregated level (sub-industry x county combinations). I will call the states A and B, and the counties A1,A2,A3,A4 and B1,B2,B3,B4,B5. I will call the industries X and Y with sub-industries Xa,Xb,Xc and Ya,Yb respectively. Suppose you have the bottom level series (the most disaggregated level) in a matrix `y`, with one column per series, and columns in the following order:

```
     County A1, industry Xa
     County A1, industry Xb
     County A1, industry Xc
     County A1, industry Ya
     County A1, industry Yb
     County A2, industry Xa
     County A2, industry Xb
     County A2, industry Xc
     County A2, industry Ya
     County A2, industry Yb
    ...
     County B5, industry Xa
     County B5, industry Xb
     County B5, industry Xc
     County B5, industry Ya
     County B5, industry Yb
```

So that we have a reproducible example, I will create `y` randomly:

```r
y <- ts(matrix(rnorm(900),ncol=45,nrow=20))
```

Then we can construct labels for the columns of this matrix as follows:

```r
blnames <- paste(c(rep("A",20),rep("B",25)), # State
                 rep(1:9,each=5),                # County
                 rep(c("X","X","X","Y","Y"),9),  # Industry
                 rep(c("a","b","c","a","b"),9),  # Sub-industry
                 sep="")
    colnames(y) <- blnames
```

For example, the first series in the matrix has name `"A1Xa"` meaning state A, county 1, industry X, sub-industry a.

We can then easily create the grouped time series object using

```r
gy <- gts(y, characters=list(c(1,1),c(1,1)))
```

Only the bottom level series are contained in `y`. The `characters` argument species what aggregations are of interest. In this case, the `characters` argument indicates there are two hierarchies (two elements in the list), and the first hierarchy is specified by the first two characters, with the second hierarchy specified by the next two characters. Each level of each hierarchy is specified using a single character (hence the 1s).

A slightly more complicated but analogous example (with labels taking more than one character each) is given in the help file for `gts` in v4.3 of the `hts` package.

It is possible to specify the grouping structure without using column labels. Then you have to specify the groups matrix which defines what aggregations are of interest. In the example above, the groups matrix is given by

```r
gps <- rbind(
      c(rep(1,20),rep(2,25)), # State
      rep(1:9,each=5),        # County
      rep(c(1,1,1,2,2),9),    # Industry
      rep(1:5, 9),            # Sub-industry
      c(rep(c(1,1,1,2,2),4),rep(c(3,3,3,4,4),5)), # State x industry
      c(rep(1:5, 4),rep(6:10, 5)),                # State x Sub-industry
      rep(1:18, rep(c(3,2),9))                    # County x industry
    )
```

The order of the rows does not matter. Each row is specifying an aggregation of the bottom level series which is of interest.

Then

```r
gy <- gts(y, groups=gps)
```

The advantage of using the `characters` argument is that the cross-products are handled for you. Also, if your data already comes with helpful column names that can be interpreted as specifying levels of one or more hierarchies, then there is really nothing to do but figure out what the `characters` argument should be.

Once the `gts` object has been created using the `gts()` function, you can proceed to forecast. For exmaple

```r
fc <- forecast(gy)
```

will generate forecasts for all the bottom level series, and all the aggregate series specified in the call to `gts()`. Then it will reconcile the forecasts until they add up for all the specified aggregations, and finally it returns only the reconciled bottom level series. The reconciled aggregated series can easily be constructed from these when they are required.
