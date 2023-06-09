---
title: "Practice using relational data"
date: 2019-03-01

type: book
toc: true
draft: false
aliases: ["/datawrangle_relational_data_exercise.html", "/notes/relational-data-exercise/"]
categories: ["datawrangle"]

weight: 35
---




```r
library(tidyverse)
library(nycflights13)
theme_set(theme_minimal())
```

{{% callout note %}}

Run the code below in your console to download this exercise as a set of R scripts.

```r
usethis::use_course("css-materials/data-wrangling-relational-data-and-factors")
```

{{% /callout %}}

For each exercise, use your knowledge of relational data and joining operations to compute a table or graph that answers the question. All questions use data frames from the `nycflights13` package (if you have not previously installed it, do so using `install.packages("nycflights13")`).

{{% callout note %}}

[Review the database structure before you begin the exercises.](http://r4ds.had.co.nz/relational-data.html#nycflights13-relational)

{{% /callout %}}

## Is there a relationship between the age of a plane and its departure delays?

Hint: all the data is from 2013.

{{< spoiler text="Click for the solution" >}}

The first step is to calculate the age of each plane. To do that, use `planes` and the `age` variable:


```r
(plane_ages <- planes %>%
  mutate(age = 2013 - year) %>%
  select(tailnum, age))
```

```
## # A tibble: 3,322 x 2
##    tailnum   age
##    <chr>   <dbl>
##  1 N10156      9
##  2 N102UW     15
##  3 N103US     14
##  4 N104UW     14
##  5 N10575     11
##  6 N105UW     14
##  7 N107US     14
##  8 N108UW     14
##  9 N109UW     14
## 10 N110UW     14
## # ... with 3,312 more rows
```

The best approach to answering this question is a visualization. There are several different types of visualizations you could implement (e.g. scatterplot with smoothing line, line graph of average delay by age). The important thing is that we need to combine `flights` with `plane_ages` to determine for each flight the age of the plane. This is another mutating join. The best choice is `inner_join()` as this will automatically remove any rows in `flights` where we don't have age data on the plane.


```r
# smoothing line
flights %>%
  inner_join(y = plane_ages) %>%
  ggplot(mapping = aes(x = age, y = dep_delay)) +
  geom_smooth()
```

```
## Joining, by = "tailnum"
## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'
```

```
## Warning: Removed 9374 rows containing non-finite values (stat_smooth).
```

<img src="{{< blogdown/postref >}}index_files/figure-html/age-delay-solution-1.png" width="672" />

```r
# line graph of average delay by age
flights %>%
  inner_join(y = plane_ages) %>%
  group_by(age) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(mapping = aes(x = age, y = delay)) +
  geom_point() +
  geom_line()
```

```
## Joining, by = "tailnum"
```

```
## Warning: Removed 1 rows containing missing values (geom_point).
```

```
## Warning: Removed 1 row(s) containing missing values (geom_path).
```

<img src="{{< blogdown/postref >}}index_files/figure-html/age-delay-solution-2.png" width="672" />

In this situation, `left_join()` could also be used because `ggplot()` and `mean(na.rm = TRUE)` drop missing values (remember that `left_join()` keeps all rows from `flights`, even if we don't have information on the plane).


```r
flights %>%
  left_join(y = plane_ages) %>%
  ggplot(mapping = aes(x = age, y = dep_delay)) +
  geom_smooth()
```

```
## Joining, by = "tailnum"
## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'
```

```
## Warning: Removed 61980 rows containing non-finite values (stat_smooth).
```

<img src="{{< blogdown/postref >}}index_files/figure-html/age-delay-leftjoin-1.png" width="672" />

```r
flights %>%
  left_join(y = plane_ages) %>%
  group_by(age) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(mapping = aes(x = age, y = delay)) +
  geom_point() +
  geom_line()
```

```
## Joining, by = "tailnum"
```

```
## Warning: Removed 1 rows containing missing values (geom_point).
```

```
## Warning: Removed 1 row(s) containing missing values (geom_path).
```

<img src="{{< blogdown/postref >}}index_files/figure-html/age-delay-leftjoin-2.png" width="672" />

The important takeaway is that departure delays do not appear to increase with plane age -- in fact they seem to decrease slightly (though with an expanding confidence interval). Care to think of a reason why this may be so?

{{< /spoiler >}}

## Add the location of the origin and destination (i.e. the `lat` and `lon`) to `flights`.

{{< spoiler text="Click for the solution" >}}

This is a mutating join, and the basic function you need to use here is `left_join()`. We have to perform the joining operation twice since we want to create new variables based on both the destination airport and the origin airport. And because the name of the key variable differs between the data frames, we need to explicitly define how to join the data frames using the `by` argument:


```r
flights %>%
  left_join(y = airports, by = c(dest = "faa")) %>%
  left_join(y = airports, by = c(origin = "faa"))
```

```
## # A tibble: 336,776 x 33
##     year month   day dep_time sched_de~1 dep_d~2 arr_t~3 sched~4 arr_d~5 carrier
##    <int> <int> <int>    <int>      <int>   <dbl>   <int>   <int>   <dbl> <chr>  
##  1  2013     1     1      517        515       2     830     819      11 UA     
##  2  2013     1     1      533        529       4     850     830      20 UA     
##  3  2013     1     1      542        540       2     923     850      33 AA     
##  4  2013     1     1      544        545      -1    1004    1022     -18 B6     
##  5  2013     1     1      554        600      -6     812     837     -25 DL     
##  6  2013     1     1      554        558      -4     740     728      12 UA     
##  7  2013     1     1      555        600      -5     913     854      19 B6     
##  8  2013     1     1      557        600      -3     709     723     -14 EV     
##  9  2013     1     1      557        600      -3     838     846      -8 B6     
## 10  2013     1     1      558        600      -2     753     745       8 AA     
## # ... with 336,766 more rows, 23 more variables: flight <int>, tailnum <chr>,
## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
## #   minute <dbl>, time_hour <dttm>, name.x <chr>, lat.x <dbl>, lon.x <dbl>,
## #   alt.x <dbl>, tz.x <dbl>, dst.x <chr>, tzone.x <chr>, name.y <chr>,
## #   lat.y <dbl>, lon.y <dbl>, alt.y <dbl>, tz.y <dbl>, dst.y <chr>,
## #   tzone.y <chr>, and abbreviated variable names 1: sched_dep_time,
## #   2: dep_delay, 3: arr_time, 4: sched_arr_time, 5: arr_delay
```

Notice that with this approach, we are joining **all** of the columns in `airports`. The instructions just asked for latitude and longitude, so we can create a copy of `airports` that only includes the necessary variables (`lat` and `lon`, plus the primary key variable `faa`) and join `flights` to that data frame:


```r
airports_lite <- airports %>%
  select(faa, lat, lon)

flights %>%
  left_join(y = airports_lite, by = c(dest = "faa")) %>%
  left_join(y = airports_lite, by = c(origin = "faa"))
```

```
## # A tibble: 336,776 x 23
##     year month   day dep_time sched_de~1 dep_d~2 arr_t~3 sched~4 arr_d~5 carrier
##    <int> <int> <int>    <int>      <int>   <dbl>   <int>   <int>   <dbl> <chr>  
##  1  2013     1     1      517        515       2     830     819      11 UA     
##  2  2013     1     1      533        529       4     850     830      20 UA     
##  3  2013     1     1      542        540       2     923     850      33 AA     
##  4  2013     1     1      544        545      -1    1004    1022     -18 B6     
##  5  2013     1     1      554        600      -6     812     837     -25 DL     
##  6  2013     1     1      554        558      -4     740     728      12 UA     
##  7  2013     1     1      555        600      -5     913     854      19 B6     
##  8  2013     1     1      557        600      -3     709     723     -14 EV     
##  9  2013     1     1      557        600      -3     838     846      -8 B6     
## 10  2013     1     1      558        600      -2     753     745       8 AA     
## # ... with 336,766 more rows, 13 more variables: flight <int>, tailnum <chr>,
## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
## #   minute <dbl>, time_hour <dttm>, lat.x <dbl>, lon.x <dbl>, lat.y <dbl>,
## #   lon.y <dbl>, and abbreviated variable names 1: sched_dep_time,
## #   2: dep_delay, 3: arr_time, 4: sched_arr_time, 5: arr_delay
```

This is better, but now we have two sets of latitude and longitude variables in the data frame: one for the destination airport, and one for the origin airport. When we perform the second `left_join()` operation, to avoid duplicate variable names the function automatically adds generic `.x` and `.y` suffixes to the output to disambiguate them. This is nice, but we might want something more intuitive to explicitly identify which variables are associated with the destination vs. the origin. To do that, we override the default `suffix` argument with custom suffixes:


```r
airports_lite <- airports %>%
  select(faa, lat, lon)

flights %>%
  left_join(y = airports_lite, by = c(dest = "faa")) %>%
  left_join(y = airports_lite, by = c(origin = "faa"), suffix = c(".dest", ".origin"))
```

```
## # A tibble: 336,776 x 23
##     year month   day dep_time sched_de~1 dep_d~2 arr_t~3 sched~4 arr_d~5 carrier
##    <int> <int> <int>    <int>      <int>   <dbl>   <int>   <int>   <dbl> <chr>  
##  1  2013     1     1      517        515       2     830     819      11 UA     
##  2  2013     1     1      533        529       4     850     830      20 UA     
##  3  2013     1     1      542        540       2     923     850      33 AA     
##  4  2013     1     1      544        545      -1    1004    1022     -18 B6     
##  5  2013     1     1      554        600      -6     812     837     -25 DL     
##  6  2013     1     1      554        558      -4     740     728      12 UA     
##  7  2013     1     1      555        600      -5     913     854      19 B6     
##  8  2013     1     1      557        600      -3     709     723     -14 EV     
##  9  2013     1     1      557        600      -3     838     846      -8 B6     
## 10  2013     1     1      558        600      -2     753     745       8 AA     
## # ... with 336,766 more rows, 13 more variables: flight <int>, tailnum <chr>,
## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
## #   minute <dbl>, time_hour <dttm>, lat.dest <dbl>, lon.dest <dbl>,
## #   lat.origin <dbl>, lon.origin <dbl>, and abbreviated variable names
## #   1: sched_dep_time, 2: dep_delay, 3: arr_time, 4: sched_arr_time,
## #   5: arr_delay
```

{{< /spoiler >}}

### Acknowledgements

* Exercises drawn from [**Relational Data** in *R for Data Science*](http://r4ds.had.co.nz/relational-data.html)

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
##  date     2022-10-18
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
##  nycflights13  * 1.0.2   2021-04-12 [1] CRAN (R 4.1.3)
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
