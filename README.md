
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
synthetic data for Australia on population and deaths, disaggregated by
age, sex, Indigenous status, state/territory and time. The methods used
to split age groups and impute deaths have introduced substantial errors
into the synthetic data, and they do *not* accurately measure actual
mortality patterns in Australia. They are intended purely for developing
code that can subsequently be used on real data.

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
