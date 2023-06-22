---
title: "Practice using relational data"
date: 2019-03-01

type: book
toc: true
draft: false
output: md_document
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
usethis::use_course("CFSS-MACSS/data-wrangling-relational-data-and-factors")
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
## # A tibble: 3,322 × 2
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
## # ℹ 3,312 more rows
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
## Joining with `by = join_by(tailnum)`
## `geom_smooth()` using method = 'gam' and formula = 'y ~ s(x, bs = "cs")'
```

```
## Warning: Removed 9374 rows containing non-finite values (`stat_smooth()`).
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
## Joining with `by = join_by(tailnum)`
```

```
## Warning: Removed 1 rows containing missing values (`geom_point()`).
```

```
## Warning: Removed 1 row containing missing values (`geom_line()`).
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
## Joining with `by = join_by(tailnum)`
## `geom_smooth()` using method = 'gam' and formula = 'y ~ s(x, bs = "cs")'
```

```
## Warning: Removed 61980 rows containing non-finite values (`stat_smooth()`).
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
## Joining with `by = join_by(tailnum)`
```

```
## Warning: Removed 1 rows containing missing values (`geom_point()`).
```

```
## Warning: Removed 1 row containing missing values (`geom_line()`).
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
## # A tibble: 336,776 × 33
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     1     1      517            515         2      830            819
##  2  2013     1     1      533            529         4      850            830
##  3  2013     1     1      542            540         2      923            850
##  4  2013     1     1      544            545        -1     1004           1022
##  5  2013     1     1      554            600        -6      812            837
##  6  2013     1     1      554            558        -4      740            728
##  7  2013     1     1      555            600        -5      913            854
##  8  2013     1     1      557            600        -3      709            723
##  9  2013     1     1      557            600        -3      838            846
## 10  2013     1     1      558            600        -2      753            745
## # ℹ 336,766 more rows
## # ℹ 25 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>, name.x <chr>, lat.x <dbl>,
## #   lon.x <dbl>, alt.x <dbl>, tz.x <dbl>, dst.x <chr>, tzone.x <chr>,
## #   name.y <chr>, lat.y <dbl>, lon.y <dbl>, alt.y <dbl>, tz.y <dbl>,
## #   dst.y <chr>, tzone.y <chr>
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
## # A tibble: 336,776 × 23
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     1     1      517            515         2      830            819
##  2  2013     1     1      533            529         4      850            830
##  3  2013     1     1      542            540         2      923            850
##  4  2013     1     1      544            545        -1     1004           1022
##  5  2013     1     1      554            600        -6      812            837
##  6  2013     1     1      554            558        -4      740            728
##  7  2013     1     1      555            600        -5      913            854
##  8  2013     1     1      557            600        -3      709            723
##  9  2013     1     1      557            600        -3      838            846
## 10  2013     1     1      558            600        -2      753            745
## # ℹ 336,766 more rows
## # ℹ 15 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>, lat.x <dbl>, lon.x <dbl>,
## #   lat.y <dbl>, lon.y <dbl>
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
## # A tibble: 336,776 × 23
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     1     1      517            515         2      830            819
##  2  2013     1     1      533            529         4      850            830
##  3  2013     1     1      542            540         2      923            850
##  4  2013     1     1      544            545        -1     1004           1022
##  5  2013     1     1      554            600        -6      812            837
##  6  2013     1     1      554            558        -4      740            728
##  7  2013     1     1      555            600        -5      913            854
##  8  2013     1     1      557            600        -3      709            723
##  9  2013     1     1      557            600        -3      838            846
## 10  2013     1     1      558            600        -2      753            745
## # ℹ 336,766 more rows
## # ℹ 15 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>, lat.dest <dbl>, lon.dest <dbl>,
## #   lat.origin <dbl>, lon.origin <dbl>
```

{{< /spoiler >}}

### Acknowledgements

* Exercises drawn from [**Relational Data** in *R for Data Science*](http://r4ds.had.co.nz/relational-data.html)

## Session Info



```r
sessioninfo::session_info()
```

```
## ─ Session info ───────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 4.3.0 (2023-04-21)
##  os       macOS Monterey 12.6.6
##  system   aarch64, darwin20
##  ui       X11
##  language (EN)
##  collate  en_US.UTF-8
##  ctype    en_US.UTF-8
##  tz       America/Chicago
##  date     2023-06-22
##  pandoc   3.1.1 @ /Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/ (via rmarkdown)
## 
## ─ Packages ───────────────────────────────────────────────────────────────────
##  package      * version date (UTC) lib source
##  blogdown       1.18    2023-06-19 [1] CRAN (R 4.3.0)
##  bookdown       0.34    2023-05-09 [1] CRAN (R 4.3.0)
##  bslib          0.5.0   2023-06-09 [1] CRAN (R 4.3.0)
##  cachem         1.0.8   2023-05-01 [1] CRAN (R 4.3.0)
##  cli            3.6.1   2023-03-23 [1] CRAN (R 4.3.0)
##  colorspace     2.1-0   2023-01-23 [1] CRAN (R 4.3.0)
##  digest         0.6.31  2022-12-11 [1] CRAN (R 4.3.0)
##  dplyr        * 1.1.2   2023-04-20 [1] CRAN (R 4.3.0)
##  evaluate       0.21    2023-05-05 [1] CRAN (R 4.3.0)
##  fansi          1.0.4   2023-01-22 [1] CRAN (R 4.3.0)
##  fastmap        1.1.1   2023-02-24 [1] CRAN (R 4.3.0)
##  forcats      * 1.0.0   2023-01-29 [1] CRAN (R 4.3.0)
##  generics       0.1.3   2022-07-05 [1] CRAN (R 4.3.0)
##  ggplot2      * 3.4.2   2023-04-03 [1] CRAN (R 4.3.0)
##  glue           1.6.2   2022-02-24 [1] CRAN (R 4.3.0)
##  gtable         0.3.3   2023-03-21 [1] CRAN (R 4.3.0)
##  here           1.0.1   2020-12-13 [1] CRAN (R 4.3.0)
##  hms            1.1.3   2023-03-21 [1] CRAN (R 4.3.0)
##  htmltools      0.5.5   2023-03-23 [1] CRAN (R 4.3.0)
##  jquerylib      0.1.4   2021-04-26 [1] CRAN (R 4.3.0)
##  jsonlite       1.8.5   2023-06-05 [1] CRAN (R 4.3.0)
##  knitr          1.43    2023-05-25 [1] CRAN (R 4.3.0)
##  lifecycle      1.0.3   2022-10-07 [1] CRAN (R 4.3.0)
##  lubridate    * 1.9.2   2023-02-10 [1] CRAN (R 4.3.0)
##  magrittr       2.0.3   2022-03-30 [1] CRAN (R 4.3.0)
##  munsell        0.5.0   2018-06-12 [1] CRAN (R 4.3.0)
##  nycflights13 * 1.0.2   2021-04-12 [1] CRAN (R 4.3.0)
##  pillar         1.9.0   2023-03-22 [1] CRAN (R 4.3.0)
##  pkgconfig      2.0.3   2019-09-22 [1] CRAN (R 4.3.0)
##  purrr        * 1.0.1   2023-01-10 [1] CRAN (R 4.3.0)
##  R6             2.5.1   2021-08-19 [1] CRAN (R 4.3.0)
##  readr        * 2.1.4   2023-02-10 [1] CRAN (R 4.3.0)
##  rlang          1.1.1   2023-04-28 [1] CRAN (R 4.3.0)
##  rmarkdown      2.22    2023-06-01 [1] CRAN (R 4.3.0)
##  rprojroot      2.0.3   2022-04-02 [1] CRAN (R 4.3.0)
##  rstudioapi     0.14    2022-08-22 [1] CRAN (R 4.3.0)
##  sass           0.4.6   2023-05-03 [1] CRAN (R 4.3.0)
##  scales         1.2.1   2022-08-20 [1] CRAN (R 4.3.0)
##  sessioninfo    1.2.2   2021-12-06 [1] CRAN (R 4.3.0)
##  stringi        1.7.12  2023-01-11 [1] CRAN (R 4.3.0)
##  stringr      * 1.5.0   2022-12-02 [1] CRAN (R 4.3.0)
##  tibble       * 3.2.1   2023-03-20 [1] CRAN (R 4.3.0)
##  tidyr        * 1.3.0   2023-01-24 [1] CRAN (R 4.3.0)
##  tidyselect     1.2.0   2022-10-10 [1] CRAN (R 4.3.0)
##  tidyverse    * 2.0.0   2023-02-22 [1] CRAN (R 4.3.0)
##  timechange     0.2.0   2023-01-11 [1] CRAN (R 4.3.0)
##  tzdb           0.4.0   2023-05-12 [1] CRAN (R 4.3.0)
##  utf8           1.2.3   2023-01-31 [1] CRAN (R 4.3.0)
##  vctrs          0.6.2   2023-04-19 [1] CRAN (R 4.3.0)
##  withr          2.5.0   2022-03-03 [1] CRAN (R 4.3.0)
##  xfun           0.39    2023-04-20 [1] CRAN (R 4.3.0)
##  yaml           2.3.7   2023-01-23 [1] CRAN (R 4.3.0)
## 
##  [1] /Library/Frameworks/R.framework/Versions/4.3-arm64/Resources/library
## 
## ──────────────────────────────────────────────────────────────────────────────
```
