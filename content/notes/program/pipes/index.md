---
title: "Pipes in R"
date: 2019-03-01

type: book
toc: true
draft: false
aliases: ["/program_pipes.html", "/notes/pipes/"]
categories: ["programming"]

weight: 81
---



Pipes are an extremely useful tool from the `magrittr` package[^magrittr] that allow you to express a sequence of multiple operations. They can greatly simplify your code and make your operations more intuitive. However they are not the only way to write your code and combine multiple operations. In fact, for many years the pipe did not exist in R. How else did people write their code?

Suppose we have the following assignment:

> Using the [`penguins`](https://github.com/allisonhorst/palmerpenguins) dataset, calculate the average body mass for Adelie penguins on different islands.

Okay, first let's load our libraries and check out the data frame.


```r
library(tidyverse)
library(palmerpenguins)
penguins
```

```
## # A tibble: 344 × 8
##    species island    bill_length_mm bill_depth_mm flipper_length_mm body_mass_g
##    <fct>   <fct>              <dbl>         <dbl>             <int>       <int>
##  1 Adelie  Torgersen           39.1          18.7               181        3750
##  2 Adelie  Torgersen           39.5          17.4               186        3800
##  3 Adelie  Torgersen           40.3          18                 195        3250
##  4 Adelie  Torgersen           NA            NA                  NA          NA
##  5 Adelie  Torgersen           36.7          19.3               193        3450
##  6 Adelie  Torgersen           39.3          20.6               190        3650
##  7 Adelie  Torgersen           38.9          17.8               181        3625
##  8 Adelie  Torgersen           39.2          19.6               195        4675
##  9 Adelie  Torgersen           34.1          18.1               193        3475
## 10 Adelie  Torgersen           42            20.2               190        4250
## # ℹ 334 more rows
## # ℹ 2 more variables: sex <fct>, year <int>
```

We can [decompose the problem](/notes/problem-solving/) into a series of discrete steps:

1. Filter `penguins` to only keep observations where the species is  "Adelie"
1. Group the filtered `penguins` data frame by island
1. Summarize the grouped and filtered `penguins` data frame by calculating the average body mass

But how do we implement the code?

## Intermediate steps

One option is to save each step as a new object:


```r
penguins_1 <- filter(penguins, species == "Adelie")
penguins_2 <- group_by(penguins_1, island)
(penguins_3 <- summarize(penguins_2, body_mass = mean(body_mass_g, na.rm = TRUE)))
```

```
## # A tibble: 3 × 2
##   island    body_mass
##   <fct>         <dbl>
## 1 Biscoe        3710.
## 2 Dream         3688.
## 3 Torgersen     3706.
```

Why do we not like doing this? **We have to name each intermediate object**. Here I just append a number to the end, but this is not good self-documentation. What should we expect to find in `penguins_2`? It would be nicer to have an informative name, but there isn't a natural one. Then we have to remember how the data exists in each intermediate step and remember to reference the correct one. What happens if we misidentify the data frame?


```r
penguins_1 <- filter(penguins, species == "Adelie")
penguins_2 <- group_by(penguins_1, island)
(penguins_3 <- summarize(penguins_1, body_mass = mean(body_mass_g, na.rm = TRUE)))
```

```
## # A tibble: 1 × 1
##   body_mass
##       <dbl>
## 1     3701.
```

We don't get the correct answer. Worse, we don't get an explicit error message because the code, as written, works. R can execute this command for us and doesn't know to warn us that we used `penguins_1` instead of `penguins_2`.

## Overwrite the original

Instead of creating intermediate objects, let's just replace the original data frame with the modified form.


```r
penguins <- filter(penguins, species == "Adelie")
penguins <- group_by(penguins, island)
(penguins <- summarize(penguins, body_mass = mean(body_mass_g, na.rm = TRUE)))
```

```
## # A tibble: 3 × 2
##   island    body_mass
##   <fct>         <dbl>
## 1 Biscoe        3710.
## 2 Dream         3688.
## 3 Torgersen     3706.
```

This works, but still has a couple of problems. What happens if I make an error in the middle of the operation? I need to rerun the entire operation from the beginning. With your own data sources, this means having to read in the `.csv` file all over again to restore a fresh copy.

## Function composition

We could string all the function calls together into a single object and forget assigning it anywhere.




```r
summarize(
  group_by(
    filter(
      penguins,
      species == "Adelie"
    ),
    island
  ),
  body_mass = mean(body_mass_g, na.rm = TRUE)
)
```

```
## # A tibble: 3 × 2
##   island    body_mass
##   <fct>         <dbl>
## 1 Biscoe        3710.
## 2 Dream         3688.
## 3 Torgersen     3706.
```

But now we have to read the function from the inside out. Even worse, what happens if we cram it all into a single line?


```r
summarize(group_by(filter(penguins, species == "Adelie"), island), body_mass = mean(body_mass_g, na.rm = TRUE))
```

```
## # A tibble: 3 × 2
##   island    body_mass
##   <fct>         <dbl>
## 1 Biscoe        3710.
## 2 Dream         3688.
## 3 Torgersen     3706.
```

**This is not intuitive for humans**. Again, the computer will handle it just fine, but if you make a mistake debugging it will be a pain.

## Back to the pipe


```r
penguins %>%
  filter(species == "Adelie") %>%
  group_by(island) %>%
  summarize(body_mass = mean(body_mass_g, na.rm = TRUE))
```

```
## # A tibble: 3 × 2
##   island    body_mass
##   <fct>         <dbl>
## 1 Biscoe        3710.
## 2 Dream         3688.
## 3 Torgersen     3706.
```

Piping is the clearest syntax to implement, as it focuses on actions, not objects. Or as [Hadley would say](http://r4ds.had.co.nz/pipes.html#use-the-pipe):

> [I]t focuses on verbs, not nouns.

`magrittr` automatically passes the output from the first line into the next line as the input.

{{< tweet 1172576445794803713 >}}

This is why `tidyverse` functions always accept a data frame as the first argument.

## Important tips for piping

* Remember though that you don't assign anything within the pipes - that is, you should not use `<-` inside the piped operation. Only use this at the beginning if you want to save the output
* Remember to add the pipe `%>%` at the end of each line involved in the piped operation. A good rule of thumb: RStudio will automatically indent lines of code that are part of a piped operation. If the line isn't indented, it probably hasn't been added to the pipe. **If you have an error in a piped operation, always check to make sure the pipe is connected as you expect**.

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
##  date     2023-07-01
##  pandoc   3.1.4 @ /usr/local/bin/ (via rmarkdown)
## 
## ─ Packages ───────────────────────────────────────────────────────────────────
##  package        * version date (UTC) lib source
##  blogdown         1.18    2023-06-19 [1] CRAN (R 4.3.0)
##  bookdown         0.34    2023-05-09 [1] CRAN (R 4.3.0)
##  bslib            0.5.0   2023-06-09 [1] CRAN (R 4.3.0)
##  cachem           1.0.8   2023-05-01 [1] CRAN (R 4.3.0)
##  cli              3.6.1   2023-03-23 [1] CRAN (R 4.3.0)
##  codetools        0.2-19  2023-02-01 [1] CRAN (R 4.3.0)
##  colorspace       2.1-0   2023-01-23 [1] CRAN (R 4.3.0)
##  digest           0.6.31  2022-12-11 [1] CRAN (R 4.3.0)
##  dplyr          * 1.1.2   2023-04-20 [1] CRAN (R 4.3.0)
##  evaluate         0.21    2023-05-05 [1] CRAN (R 4.3.0)
##  fansi            1.0.4   2023-01-22 [1] CRAN (R 4.3.0)
##  fastmap          1.1.1   2023-02-24 [1] CRAN (R 4.3.0)
##  forcats        * 1.0.0   2023-01-29 [1] CRAN (R 4.3.0)
##  generics         0.1.3   2022-07-05 [1] CRAN (R 4.3.0)
##  ggplot2        * 3.4.2   2023-04-03 [1] CRAN (R 4.3.0)
##  glue             1.6.2   2022-02-24 [1] CRAN (R 4.3.0)
##  gtable           0.3.3   2023-03-21 [1] CRAN (R 4.3.0)
##  here             1.0.1   2020-12-13 [1] CRAN (R 4.3.0)
##  hms              1.1.3   2023-03-21 [1] CRAN (R 4.3.0)
##  htmltools        0.5.5   2023-03-23 [1] CRAN (R 4.3.0)
##  jquerylib        0.1.4   2021-04-26 [1] CRAN (R 4.3.0)
##  jsonlite         1.8.5   2023-06-05 [1] CRAN (R 4.3.0)
##  knitr            1.43    2023-05-25 [1] CRAN (R 4.3.0)
##  lifecycle        1.0.3   2022-10-07 [1] CRAN (R 4.3.0)
##  lubridate      * 1.9.2   2023-02-10 [1] CRAN (R 4.3.0)
##  magrittr         2.0.3   2022-03-30 [1] CRAN (R 4.3.0)
##  munsell          0.5.0   2018-06-12 [1] CRAN (R 4.3.0)
##  palmerpenguins * 0.1.1   2022-08-15 [1] CRAN (R 4.3.0)
##  pillar           1.9.0   2023-03-22 [1] CRAN (R 4.3.0)
##  pkgconfig        2.0.3   2019-09-22 [1] CRAN (R 4.3.0)
##  purrr          * 1.0.1   2023-01-10 [1] CRAN (R 4.3.0)
##  R6               2.5.1   2021-08-19 [1] CRAN (R 4.3.0)
##  readr          * 2.1.4   2023-02-10 [1] CRAN (R 4.3.0)
##  rlang            1.1.1   2023-04-28 [1] CRAN (R 4.3.0)
##  rmarkdown        2.22    2023-06-01 [1] CRAN (R 4.3.0)
##  rprojroot        2.0.3   2022-04-02 [1] CRAN (R 4.3.0)
##  rstudioapi       0.14    2022-08-22 [1] CRAN (R 4.3.0)
##  sass             0.4.6   2023-05-03 [1] CRAN (R 4.3.0)
##  scales           1.2.1   2022-08-20 [1] CRAN (R 4.3.0)
##  sessioninfo      1.2.2   2021-12-06 [1] CRAN (R 4.3.0)
##  stringi          1.7.12  2023-01-11 [1] CRAN (R 4.3.0)
##  stringr        * 1.5.0   2022-12-02 [1] CRAN (R 4.3.0)
##  tibble         * 3.2.1   2023-03-20 [1] CRAN (R 4.3.0)
##  tidyr          * 1.3.0   2023-01-24 [1] CRAN (R 4.3.0)
##  tidyselect       1.2.0   2022-10-10 [1] CRAN (R 4.3.0)
##  tidyverse      * 2.0.0   2023-02-22 [1] CRAN (R 4.3.0)
##  timechange       0.2.0   2023-01-11 [1] CRAN (R 4.3.0)
##  tzdb             0.4.0   2023-05-12 [1] CRAN (R 4.3.0)
##  utf8             1.2.3   2023-01-31 [1] CRAN (R 4.3.0)
##  vctrs            0.6.2   2023-04-19 [1] CRAN (R 4.3.0)
##  withr            2.5.0   2022-03-03 [1] CRAN (R 4.3.0)
##  xfun             0.39    2023-04-20 [1] CRAN (R 4.3.0)
##  yaml             2.3.7   2023-01-23 [1] CRAN (R 4.3.0)
## 
##  [1] /Library/Frameworks/R.framework/Versions/4.3-arm64/Resources/library
## 
## ──────────────────────────────────────────────────────────────────────────────
```

[^magrittr]: The basic `%>%` pipe is automatically imported as part of the `tidyverse` library. If you wish to use any of the [extra tools from `magrittr` as demonstrated in R for Data Science](http://r4ds.had.co.nz/pipes.html#other-tools-from-magrittr), you need to explicitly load `magrittr`.
