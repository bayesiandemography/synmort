
<!-- README.md is generated from README.Rmd. Please edit that file -->

# synmort

<!-- badges: start -->
<!-- badges: end -->

Synthetic data on deaths and population in Australia.

## Installation

``` r
devtools::install_github("bayesiandemography/synmort")
```

## Description

**synmort** contains a single data frame (called `synmort`) with
synthetic data on deaths and population. The data is based on a public
domain dataset from the Australian Bureau of Statistics. However, the
original broad age groups have been split into single-year age groups,
and deaths have been randomly generated from death rates and population
counts. The data no longer accurately reflects actual mortality
patterns. It should be used for developing code that that will
ultimately be used on real data.

``` r
library(synmort)
head(synmort)
#>   age    sex      indig          region time deaths popn
#> 1   0 Female Indigenous New South Wales 2003     24 2729
#> 2   1 Female Indigenous New South Wales 2003      5 2732
#> 3   2 Female Indigenous New South Wales 2003      2 2721
#> 4   3 Female Indigenous New South Wales 2003      0 2697
#> 5   4 Female Indigenous New South Wales 2003      0 2661
#> 6   5 Female Indigenous New South Wales 2003      0 2615
```
