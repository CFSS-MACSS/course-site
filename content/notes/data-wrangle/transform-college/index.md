---
title: "Practice transforming college education data"
date: 2022-10-06

type: book
toc: true
draft: false
aliases: ["/datawrangle_transform_college.html", "/notes/transform-college/"]
categories: ["datawrangle"]

weight: 33
---




```r
library(tidyverse)
```

{{% callout note %}}
Run the code below in your console to download this exercise as a set of R scripts.
```r
usethis::use_course("css-materials/data-transformation")
```
{{% /callout %}}


The Department of Education collects [annual statistics on colleges and universities in the United States](https://collegescorecard.ed.gov/). I have included a subset of this data from 2018-19 in the [`rcis`](https://github.com/css-materials/rcis) library from GitHub. 

{{% callout note %}}
If you are working on your local R you need to install the package first by running the command `remotes::install_github("css-materials/rcis")` in the console. If you don't already have the `remotes` library installed, you will get an error. Go back and install this first using `install.packages("remotes")`, then run `remotes::install_github("css-materials/rcis")`.
{{% /callout %}}


```r
library(rcis)
data("scorecard")
glimpse(scorecard)
```

```
## Rows: 1,732
## Columns: 14
## $ unitid    <dbl> 100654, 100663, 100706, 100724, 100751, 100830, 100858, 1009~
## $ name      <chr> "Alabama A & M University", "University of Alabama at Birmin~
## $ state     <chr> "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AL", ~
## $ type      <fct> "Public", "Public", "Public", "Public", "Public", "Public", ~
## $ admrate   <dbl> 0.9175, 0.7366, 0.8257, 0.9690, 0.8268, 0.9044, 0.8067, 0.53~
## $ satavg    <dbl> 939, 1234, 1319, 946, 1261, 1082, 1300, 1230, 1066, NA, 1076~
## $ cost      <dbl> 23053, 24495, 23917, 21866, 29872, 19849, 31590, 32095, 3431~
## $ netcost   <dbl> 14990, 16953, 15860, 13650, 22597, 13987, 24104, 22107, 2071~
## $ avgfacsal <dbl> 69381, 99441, 87192, 64989, 92619, 71343, 96642, 56646, 5400~
## $ pctpell   <dbl> 0.7019, 0.3512, 0.2536, 0.7627, 0.1772, 0.4644, 0.1455, 0.23~
## $ comprate  <dbl> 0.2974, 0.6340, 0.5768, 0.3276, 0.7110, 0.3401, 0.7911, 0.69~
## $ firstgen  <dbl> 0.3658281, 0.3412237, 0.3101322, 0.3434343, 0.2257127, 0.381~
## $ debt      <dbl> 15250, 15085, 14000, 17500, 17671, 12000, 17500, 16000, 1425~
## $ locale    <fct> City, City, City, City, City, City, City, City, City, Suburb~
```

`glimpse()` is part of the `tibble` package and is a transposed version of `print()`: columns run down the page, and data runs across. With a data frame with multiple columns, sometimes there is not enough horizontal space on the screen to print each column. By transposing the data frame, we can see all the columns and the values recorded for the initial rows.

Type `?scorecard` in the console to open up the help file for this data set. This includes the documentation for all the variables. Use your knowledge of the `dplyr` functions to perform the following tasks.

## Generate a data frame of schools with a greater than 40% share of first-generation students

{{< spoiler text="Click for the solution" >}}


```r
filter(.data = scorecard, firstgen > .40)
```

```
## # A tibble: 356 x 14
##    unitid name  state type  admrate satavg  cost netcost avgfa~1 pctpell compr~2
##     <dbl> <chr> <chr> <fct>   <dbl>  <dbl> <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
##  1 101189 Faul~ AL    Priv~   0.783   1066 34317   20715   54009   0.488   0.329
##  2 101365 Herz~ AL    Priv~   0.783     NA 30119   26680   54684   0.706   0.28 
##  3 101541 Juds~ AL    Priv~   0.372   1020 32691   16827   52020   0.545   0.364
##  4 101587 Univ~ AL    Publ~   0.349   1041 21657   15514   58329   0.535   0.350
##  5 102270 Stil~ AL    Priv~   0.330     NA 25413   18352   43605   0.709   0.272
##  6 104717 Gran~ AZ    Priv~   0.769     NA 31213   21020   60741   0.454   0.408
##  7 106467 Arka~ AR    Publ~   0.947     NA 18358   10772   61812   0.361   0.384
##  8 107983 Sout~ AR    Publ~   0.651   1085 22579   14270   61650   0.487   0.436
##  9 110361 Cali~ CA    Priv~   0.783   1096 46261   24707   88335   0.453   0.630
## 10 110486 Cali~ CA    Publ~   0.807     NA 16660    5318   86760   0.619   0.430
## # ... with 346 more rows, 3 more variables: firstgen <dbl>, debt <dbl>,
## #   locale <fct>, and abbreviated variable names 1: avgfacsal, 2: comprate
```

{{< /spoiler >}}

## Generate a data frame with the 10 most expensive colleges in 2018-19 based on net cost of attendance

{{< spoiler text="Click for the solution" >}}

We could use a combination of `arrange()` and `slice()` to sort the data frame from most to least expensive, then keep the first 10 rows:


```r
arrange(.data = scorecard, desc(netcost)) %>%
  slice(1:10)
```

```
## # A tibble: 10 x 14
##    unitid name  state type  admrate satavg  cost netcost avgfa~1 pctpell compr~2
##     <dbl> <chr> <chr> <fct>   <dbl>  <dbl> <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
##  1 192712 Manh~ NY    Priv~   0.355     NA 68686   54902   73863   0.129   0.876
##  2 111081 Cali~ CA    Priv~   0.253     NA 71382   50412   86760   0.248   0.614
##  3 136774 Ring~ FL    Priv~   0.639     NA 67325   49649   78435   0.284   0.672
##  4 164748 Berk~ MA    Priv~   0.514     NA 64436   49514   93870   0.166   0.652
##  5 247649 Land~ VT    Priv~   0.470     NA 73821   47373   59373   0.219   0.416
##  6 109651 Art ~ CA    Priv~   0.708     NA 64316   47080   71523   0.283   0.685
##  7 135726 Univ~ FL    Priv~   0.271   1371 67249   46949  115353   0.143   0.831
##  8 194578 Prat~ NY    Priv~   0.555   1273 67703   45571  101079   0.198   0.704
##  9 165662 Emer~ MA    Priv~   0.334   1318 68350   45365   90747   0.161   0.821
## 10 143048 Scho~ IL    Priv~   0.570   1238 67058   44815   96102   0.192   0.699
## # ... with 3 more variables: firstgen <dbl>, debt <dbl>, locale <fct>, and
## #   abbreviated variable names 1: avgfacsal, 2: comprate
```

We can also use the `slice_max()` function in `dplyr` to accomplish the same thing in one line of code.


```r
slice_max(.data = scorecard, order_by = netcost, n = 10)
```

```
## # A tibble: 10 x 14
##    unitid name  state type  admrate satavg  cost netcost avgfa~1 pctpell compr~2
##     <dbl> <chr> <chr> <fct>   <dbl>  <dbl> <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
##  1 192712 Manh~ NY    Priv~   0.355     NA 68686   54902   73863   0.129   0.876
##  2 111081 Cali~ CA    Priv~   0.253     NA 71382   50412   86760   0.248   0.614
##  3 136774 Ring~ FL    Priv~   0.639     NA 67325   49649   78435   0.284   0.672
##  4 164748 Berk~ MA    Priv~   0.514     NA 64436   49514   93870   0.166   0.652
##  5 247649 Land~ VT    Priv~   0.470     NA 73821   47373   59373   0.219   0.416
##  6 109651 Art ~ CA    Priv~   0.708     NA 64316   47080   71523   0.283   0.685
##  7 135726 Univ~ FL    Priv~   0.271   1371 67249   46949  115353   0.143   0.831
##  8 194578 Prat~ NY    Priv~   0.555   1273 67703   45571  101079   0.198   0.704
##  9 165662 Emer~ MA    Priv~   0.334   1318 68350   45365   90747   0.161   0.821
## 10 143048 Scho~ IL    Priv~   0.570   1238 67058   44815   96102   0.192   0.699
## # ... with 3 more variables: firstgen <dbl>, debt <dbl>, locale <fct>, and
## #   abbreviated variable names 1: avgfacsal, 2: comprate
```

{{< /spoiler >}}

## Generate a data frame with the average SAT score for each type of college

{{< spoiler text="Click for the solution" >}}


```r
scorecard %>%
  group_by(type) %>%
  summarize(mean_sat = mean(satavg, na.rm = TRUE))
```

```
## # A tibble: 3 x 2
##   type                mean_sat
##   <fct>                  <dbl>
## 1 Public                 1126.
## 2 Private, nonprofit     1152.
## 3 Private, for-profit    1121.
```

{{< /spoiler >}}

## Calculate for each school how many students it takes to pay the average faculty member's salary and generate a data frame with the school's name and the calculated value

Note: use the net cost of attendance.

{{< spoiler text="Click for the solution" >}}


```r
scorecard %>%
  mutate(ratio = avgfacsal / netcost) %>%
  select(name, ratio)
```

```
## # A tibble: 1,732 x 2
##    name                                ratio
##    <chr>                               <dbl>
##  1 Alabama A & M University             4.63
##  2 University of Alabama at Birmingham  5.87
##  3 University of Alabama in Huntsville  5.50
##  4 Alabama State University             4.76
##  5 The University of Alabama            4.10
##  6 Auburn University at Montgomery      5.10
##  7 Auburn University                    4.01
##  8 Birmingham-Southern College          2.56
##  9 Faulkner University                  2.61
## 10 Herzing University-Birmingham        2.05
## # ... with 1,722 more rows
```

{{< /spoiler >}}

## Calculate how many private, nonprofit schools have a smaller net cost than the "University of Chicago"

Hint: the result should be a data frame with one row for UChicago, and a column containing the requested value. 

### Report the number as the total number of schools

{{< spoiler text="Click for the solution" >}}


```r
scorecard %>%
  filter(type == "Private, nonprofit") %>%
  arrange(netcost) %>%
  # use row_number() but subtract 1 since UChicago is not cheaper than itself
  mutate(school_cheaper = row_number() - 1) %>%
  filter(name == "University of Chicago") %>%
  glimpse()
```

```
## Rows: 1
## Columns: 15
## $ unitid         <dbl> 144050
## $ name           <chr> "University of Chicago"
## $ state          <chr> "IL"
## $ type           <fct> "Private, nonprofit"
## $ admrate        <dbl> 0.0617
## $ satavg         <dbl> 1528
## $ cost           <dbl> 78555
## $ netcost        <dbl> 27315
## $ avgfacsal      <dbl> 166923
## $ pctpell        <dbl> 0.1135
## $ comprate       <dbl> 0.9473
## $ firstgen       <dbl> 0.2024353
## $ debt           <dbl> 13000
## $ locale         <fct> City
## $ school_cheaper <dbl> 808
```

{{< /spoiler >}}

### Report the number as the percentage of schools

{{< spoiler text="Click for the solution" >}}


```r
scorecard %>%
  filter(type == "Private, nonprofit") %>%
  mutate(netcost_rank = percent_rank(netcost)) %>%
  filter(name == "University of Chicago") %>%
  glimpse()
```

```
## Rows: 1
## Columns: 15
## $ unitid       <dbl> 144050
## $ name         <chr> "University of Chicago"
## $ state        <chr> "IL"
## $ type         <fct> "Private, nonprofit"
## $ admrate      <dbl> 0.0617
## $ satavg       <dbl> 1528
## $ cost         <dbl> 78555
## $ netcost      <dbl> 27315
## $ avgfacsal    <dbl> 166923
## $ pctpell      <dbl> 0.1135
## $ comprate     <dbl> 0.9473
## $ firstgen     <dbl> 0.2024353
## $ debt         <dbl> 13000
## $ locale       <fct> City
## $ netcost_rank <dbl> 0.7516279
```

{{< /spoiler >}}

## Session Info



```r
sessioninfo::session_info()
```

```
## - Session info ---------------------------------------------------------------
##  setting  value
##  version  R version 4.1.3 (2022-03-10)
##  os       Windows 10 x64 (build 19044)
##  system   x86_64, mingw32
##  ui       RTerm
##  language (EN)
##  collate  English_United States.1252
##  ctype    English_United States.1252
##  tz       America/Chicago
##  date     2022-10-11
##  pandoc   2.17.1.1 @ C:/Program Files/RStudio/bin/quarto/bin/ (via rmarkdown)
## 
## - Packages -------------------------------------------------------------------
##  package       * version date (UTC) lib source
##  assertthat      0.2.1   2019-03-21 [1] CRAN (R 4.1.3)
##  backports       1.4.1   2021-12-13 [1] CRAN (R 4.1.2)
##  blogdown        1.11    2022-08-09 [1] CRAN (R 4.1.3)
##  bookdown        0.28    2022-08-09 [1] CRAN (R 4.1.3)
##  broom           1.0.1   2022-08-29 [1] CRAN (R 4.1.3)
##  bslib           0.4.0   2022-07-16 [1] CRAN (R 4.1.3)
##  cachem          1.0.6   2021-08-19 [1] CRAN (R 4.1.3)
##  cellranger      1.1.0   2016-07-27 [1] CRAN (R 4.1.3)
##  cli             3.3.0   2022-04-25 [1] CRAN (R 4.1.3)
##  colorspace      2.0-3   2022-02-21 [1] CRAN (R 4.1.3)
##  crayon          1.5.1   2022-03-26 [1] CRAN (R 4.1.3)
##  DBI             1.1.3   2022-06-18 [1] CRAN (R 4.1.3)
##  dbplyr          2.2.1   2022-06-27 [1] CRAN (R 4.1.3)
##  digest          0.6.29  2021-12-01 [1] CRAN (R 4.1.3)
##  dplyr         * 1.0.9   2022-04-28 [1] CRAN (R 4.1.3)
##  ellipsis        0.3.2   2021-04-29 [1] CRAN (R 4.1.3)
##  evaluate        0.16    2022-08-09 [1] CRAN (R 4.1.3)
##  fansi           1.0.3   2022-03-24 [1] CRAN (R 4.1.3)
##  fastmap         1.1.0   2021-01-25 [1] CRAN (R 4.1.3)
##  forcats       * 0.5.2   2022-08-19 [1] CRAN (R 4.1.3)
##  fs              1.5.2   2021-12-08 [1] CRAN (R 4.1.3)
##  gargle          1.2.0   2021-07-02 [1] CRAN (R 4.1.3)
##  generics        0.1.3   2022-07-05 [1] CRAN (R 4.1.3)
##  ggplot2       * 3.3.6   2022-05-03 [1] CRAN (R 4.1.3)
##  glue            1.6.2   2022-02-24 [1] CRAN (R 4.1.3)
##  googledrive     2.0.0   2021-07-08 [1] CRAN (R 4.1.3)
##  googlesheets4   1.0.1   2022-08-13 [1] CRAN (R 4.1.3)
##  gtable          0.3.1   2022-09-01 [1] CRAN (R 4.1.3)
##  haven           2.5.1   2022-08-22 [1] CRAN (R 4.1.3)
##  here            1.0.1   2020-12-13 [1] CRAN (R 4.1.3)
##  hms             1.1.2   2022-08-19 [1] CRAN (R 4.1.3)
##  htmltools       0.5.2   2021-08-25 [1] CRAN (R 4.1.3)
##  httr            1.4.4   2022-08-17 [1] CRAN (R 4.1.3)
##  jquerylib       0.1.4   2021-04-26 [1] CRAN (R 4.1.3)
##  jsonlite        1.8.0   2022-02-22 [1] CRAN (R 4.1.3)
##  knitr           1.40    2022-08-24 [1] CRAN (R 4.1.3)
##  lifecycle       1.0.2   2022-09-09 [1] CRAN (R 4.1.3)
##  lubridate       1.8.0   2021-10-07 [1] CRAN (R 4.1.3)
##  magrittr        2.0.3   2022-03-30 [1] CRAN (R 4.1.3)
##  modelr          0.1.9   2022-08-19 [1] CRAN (R 4.1.3)
##  munsell         0.5.0   2018-06-12 [1] CRAN (R 4.1.3)
##  pillar          1.8.1   2022-08-19 [1] CRAN (R 4.1.3)
##  pkgconfig       2.0.3   2019-09-22 [1] CRAN (R 4.1.3)
##  purrr         * 0.3.4   2020-04-17 [1] CRAN (R 4.1.3)
##  R6              2.5.1   2021-08-19 [1] CRAN (R 4.1.3)
##  readr         * 2.1.2   2022-01-30 [1] CRAN (R 4.1.3)
##  readxl          1.4.1   2022-08-17 [1] CRAN (R 4.1.3)
##  reprex          2.0.2   2022-08-17 [1] CRAN (R 4.1.3)
##  rlang           1.0.6   2022-09-24 [1] CRAN (R 4.1.3)
##  rmarkdown       2.16    2022-08-24 [1] CRAN (R 4.1.3)
##  rprojroot       2.0.3   2022-04-02 [1] CRAN (R 4.1.3)
##  rstudioapi      0.14    2022-08-22 [1] CRAN (R 4.1.3)
##  rvest           1.0.3   2022-08-19 [1] CRAN (R 4.1.3)
##  sass            0.4.2   2022-07-16 [1] CRAN (R 4.1.3)
##  scales          1.2.1   2022-08-20 [1] CRAN (R 4.1.3)
##  sessioninfo     1.2.2   2021-12-06 [1] CRAN (R 4.1.3)
##  stringi         1.7.6   2021-11-29 [1] CRAN (R 4.1.2)
##  stringr       * 1.4.1   2022-08-20 [1] CRAN (R 4.1.3)
##  tibble        * 3.1.8   2022-07-22 [1] CRAN (R 4.1.3)
##  tidyr         * 1.2.0   2022-02-01 [1] CRAN (R 4.1.3)
##  tidyselect      1.1.2   2022-02-21 [1] CRAN (R 4.1.3)
##  tidyverse     * 1.3.2   2022-07-18 [1] CRAN (R 4.1.3)
##  tzdb            0.3.0   2022-03-28 [1] CRAN (R 4.1.3)
##  utf8            1.2.2   2021-07-24 [1] CRAN (R 4.1.3)
##  vctrs           0.4.1   2022-04-13 [1] CRAN (R 4.1.3)
##  withr           2.5.0   2022-03-03 [1] CRAN (R 4.1.3)
##  xfun            0.30    2022-03-02 [1] CRAN (R 4.1.3)
##  xml2            1.3.3   2021-11-30 [1] CRAN (R 4.1.3)
##  yaml            2.3.5   2022-02-21 [1] CRAN (R 4.1.2)
## 
##  [1] C:/Users/Sabrina Nardin/Documents/R/win-library/4.1
##  [2] C:/Program Files/R/R-4.1.3/library
## 
## ------------------------------------------------------------------------------
```

## Acknowledgments


* This page has been developed starting from Benjamin Soltoff’s “Computing for the Social Sciences” course materials, licensed under the CC BY-NC 4.0 Creative Commons License.
