---
title: "Practice transforming and visualizing factors"
date: 2019-03-01

type: book
toc: true
draft: true
aliases: ["/datawrangle_factors_exercise.html", "/notes/factors-exercise/"]
categories: ["datawrangle"]

weight: 36
---




```r
library(tidyverse)
library(rcis)
theme_set(theme_minimal())
```

{{% callout note %}}

Run the code below in your console to download this exercise as a set of R scripts.

```r
usethis::use_course("CFSS-MACSS/data-wrangling-relational-data-and-factors")
```

{{% /callout %}}


```r
# load the data
data("gun_deaths")
gun_deaths
```

```
## # A tibble: 100,798 x 10
##       id  year month intent       police sex     age race          place educa~1
##    <dbl> <dbl> <chr> <chr>         <dbl> <chr> <dbl> <chr>         <chr> <fct>  
##  1     1  2012 Jan   Suicide           0 M        34 Asian/Pacifi~ Home  BA+    
##  2     2  2012 Jan   Suicide           0 F        21 White         Stre~ Some c~
##  3     3  2012 Jan   Suicide           0 M        60 White         Othe~ BA+    
##  4     4  2012 Feb   Suicide           0 M        64 White         Home  BA+    
##  5     5  2012 Feb   Suicide           0 M        31 White         Othe~ HS/GED 
##  6     6  2012 Feb   Suicide           0 M        17 Native Ameri~ Home  Less t~
##  7     7  2012 Feb   Undetermined      0 M        48 White         Home  HS/GED 
##  8     8  2012 Mar   Suicide           0 M        41 Native Ameri~ Home  HS/GED 
##  9     9  2012 Feb   Accidental        0 M        50 White         Othe~ Some c~
## 10    10  2012 Feb   Suicide           0 M        NA Black         Home  <NA>   
## # ... with 100,788 more rows, and abbreviated variable name 1: education
```

## Convert `month` into a factor column

{{< spoiler text="Click for the solution" >}}


```r
# create a character vector with all month values
month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

# or use the built-in constant
month.abb
```

```
##  [1] "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"
```

```r
# use mutate() and factor() to convert the column and store the result
(gun_deaths <- gun_deaths %>%
  mutate(month = factor(month,
    levels = month_levels
  )))
```

```
## # A tibble: 100,798 x 10
##       id  year month intent       police sex     age race          place educa~1
##    <dbl> <dbl> <fct> <chr>         <dbl> <chr> <dbl> <chr>         <chr> <fct>  
##  1     1  2012 Jan   Suicide           0 M        34 Asian/Pacifi~ Home  BA+    
##  2     2  2012 Jan   Suicide           0 F        21 White         Stre~ Some c~
##  3     3  2012 Jan   Suicide           0 M        60 White         Othe~ BA+    
##  4     4  2012 Feb   Suicide           0 M        64 White         Home  BA+    
##  5     5  2012 Feb   Suicide           0 M        31 White         Othe~ HS/GED 
##  6     6  2012 Feb   Suicide           0 M        17 Native Ameri~ Home  Less t~
##  7     7  2012 Feb   Undetermined      0 M        48 White         Home  HS/GED 
##  8     8  2012 Mar   Suicide           0 M        41 Native Ameri~ Home  HS/GED 
##  9     9  2012 Feb   Accidental        0 M        50 White         Othe~ Some c~
## 10    10  2012 Feb   Suicide           0 M        NA Black         Home  <NA>   
## # ... with 100,788 more rows, and abbreviated variable name 1: education
```

{{< /spoiler >}}

## Visualize the total gun deaths per month, in chronological order

{{< spoiler text="Click for the solution" >}}


```r
ggplot(
  data = gun_deaths,
  mapping = aes(x = month)
) +
  geom_bar() +
  labs(
    title = "Gun Deaths in the United States (2012-2014)",
    x = "Month",
    y = "Number of gun deaths"
  )
```

<img src="{{< blogdown/postref >}}index_files/figure-html/month-deaths-1.png" width="672" />

{{< /spoiler >}}

## Visualize the total gun deaths per month, sorted from lowest to highest

{{< spoiler text="Click for the solution" >}}


```r
# with geom_col() and fct_reorder()
gun_deaths %>%
  count(month) %>%
  mutate(month = fct_reorder(.f = month, .x = n)) %>%
  ggplot(mapping = aes(x = month, y = n)) +
  geom_col() +
  labs(
    title = "Gun Deaths in the United States (2012-2014)",
    x = "Month",
    y = "Number of gun deaths"
  )
```

<img src="{{< blogdown/postref >}}index_files/figure-html/month-deaths-sort-1.png" width="672" />

```r
# with geom_bar() and fct_infreq()
gun_deaths %>%
  mutate(month = fct_infreq(f = month) %>%
    fct_rev()) %>%
  ggplot(mapping = aes(x = month)) +
  geom_bar() +
  labs(
    title = "Gun Deaths in the United States (2012-2014)",
    x = "Month",
    y = "Number of gun deaths"
  )
```

<img src="{{< blogdown/postref >}}index_files/figure-html/month-deaths-sort-2.png" width="672" />

{{< /spoiler >}}

## Visualize the frequency of intent of gun deaths using a bar chart, sorted from most to least frequent

{{< spoiler text="Click for the solution" >}}


```r
# identify all possible types of intent
intent_levels <- c("Accidental", "Homicide", "Suicide", "Undetermined")

gun_deaths %>%
  # remove rows with missing intent values
  drop_na(intent) %>%
  # parse_factor() is a tidyverse friendly form of factor()
  # ensure values are properly ordered from highest to lowest frequency
  mutate(intent = parse_factor(intent, levels = intent_levels) %>%
    fct_infreq() %>%
    fct_rev()) %>%
  ggplot(mapping = aes(x = intent)) +
  geom_bar() +
  labs(
    title = "Gun Deaths in the United States (2012-2014)",
    x = "Intent of death",
    y = "Number of gun deaths"
  ) +
  coord_flip()
```

<img src="{{< blogdown/postref >}}index_files/figure-html/intent-1.png" width="672" />

{{< /spoiler >}}

## Visualize total gun deaths by season of the year using a bar chart.

Hint: do not use `cut()` to create the `season` column.

{{< spoiler text="Click for the solution" >}}


```r
gun_deaths %>%
  # use fct_collapse() to condense into 4 categories
  mutate(season = fct_collapse(month,
    "Winter" = c("Jan", "Feb", "Mar"),
    "Spring" = c("Apr", "May", "Jun"),
    "Summer" = c("Jul", "Aug", "Sep"),
    "Fall" = c("Oct", "Nov", "Dec")
  )) %>%
  ggplot(mapping = aes(x = season)) +
  geom_bar() +
  labs(
    title = "Gun Deaths in the United States (2012-2014)",
    x = "Season",
    y = "Number of gun deaths"
  )
```

<img src="{{< blogdown/postref >}}index_files/figure-html/season-1.png" width="672" />

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
##  date     2022-10-06
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
##  codetools       0.2-18  2020-11-04 [2] CRAN (R 4.1.3)
##  colorspace      2.0-3   2022-02-21 [1] CRAN (R 4.1.3)
##  crayon          1.5.1   2022-03-26 [1] CRAN (R 4.1.3)
##  DBI             1.1.3   2022-06-18 [1] CRAN (R 4.1.3)
##  dbplyr          2.2.1   2022-06-27 [1] CRAN (R 4.1.3)
##  digest          0.6.29  2021-12-01 [1] CRAN (R 4.1.3)
##  dplyr         * 1.0.9   2022-04-28 [1] CRAN (R 4.1.3)
##  ellipsis        0.3.2   2021-04-29 [1] CRAN (R 4.1.3)
##  evaluate        0.16    2022-08-09 [1] CRAN (R 4.1.3)
##  fansi           1.0.3   2022-03-24 [1] CRAN (R 4.1.3)
##  farver          2.1.1   2022-07-06 [1] CRAN (R 4.1.3)
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
##  highr           0.9     2021-04-16 [1] CRAN (R 4.1.3)
##  hms             1.1.2   2022-08-19 [1] CRAN (R 4.1.3)
##  htmltools       0.5.2   2021-08-25 [1] CRAN (R 4.1.3)
##  httr            1.4.4   2022-08-17 [1] CRAN (R 4.1.3)
##  jquerylib       0.1.4   2021-04-26 [1] CRAN (R 4.1.3)
##  jsonlite        1.8.0   2022-02-22 [1] CRAN (R 4.1.3)
##  knitr           1.40    2022-08-24 [1] CRAN (R 4.1.3)
##  labeling        0.4.2   2020-10-20 [1] CRAN (R 4.1.1)
##  lifecycle       1.0.1   2021-09-24 [1] CRAN (R 4.1.3)
##  lubridate       1.8.0   2021-10-07 [1] CRAN (R 4.1.3)
##  magrittr        2.0.3   2022-03-30 [1] CRAN (R 4.1.3)
##  modelr          0.1.9   2022-08-19 [1] CRAN (R 4.1.3)
##  munsell         0.5.0   2018-06-12 [1] CRAN (R 4.1.3)
##  pillar          1.8.1   2022-08-19 [1] CRAN (R 4.1.3)
##  pkgconfig       2.0.3   2019-09-22 [1] CRAN (R 4.1.3)
##  purrr         * 0.3.4   2020-04-17 [1] CRAN (R 4.1.3)
##  R6              2.5.1   2021-08-19 [1] CRAN (R 4.1.3)
##  rcis          * 0.2.5   2022-09-03 [1] Github (cis-ds/rcis@0726542)
##  readr         * 2.1.2   2022-01-30 [1] CRAN (R 4.1.3)
##  readxl          1.4.1   2022-08-17 [1] CRAN (R 4.1.3)
##  reprex          2.0.2   2022-08-17 [1] CRAN (R 4.1.3)
##  rlang           1.0.4   2022-07-12 [1] CRAN (R 4.1.3)
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
