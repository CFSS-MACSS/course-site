---
title: "Use safe filepaths"
date: 2019-03-01

type: book
toc: true
draft: false
aliases: ["/notes/safe-filepaths/"]
categories: ["project-management"]

weight: 93
---




```r
library(tidyverse)

set.seed(1234)
theme_set(theme_minimal())
```

How can you avoid `setwd()` at the top of every script?

* Organize each logical project into a folder on your computer.
* Make sure the top-level folder advertises itself as such. This can be as simple as having an empty file named `.here`. Or, if you use RStudio and/or Git, those both leave characteristic files behind that will get the job done.
* Use the `here()` function from the [`here` package](https://CRAN.R-project.org/package=here) to build the path when you read or write a file. Create paths relative to the top-level directory.
* Whenever you work on this project, launch the R process from the project's top-level directory.

{{< figure src="allison_horst_art/here.png" caption="Artwork by  [allison_horst](https://github.com/allisonhorst/stats-illustrations)" >}}

## How to use the `here` package

1. Install [`here`](https://cran.r-project.org/web/packages/here/index.html).

    ```r
    install.packages("here")
    ```

2. Use it.

    ```r
    library(here)
    here("data", "file_i_want.csv")
    ```

## Actual demonstration of `here::here()`

What does `here` think the top-level of current project is? The package displays this on load or, at any time, you can just call `here()`.


```r
library(here)
```

```
## here() starts at /Users/jeanclipperton/Library/CloudStorage/Box-Box/Teaching/CFSS/course-site
```

```r
here()
```

```
## [1] "/Users/jeanclipperton/Library/CloudStorage/Box-Box/Teaching/CFSS/course-site"
```

Build a path to something in a subdirectory and use it.


```r
here("static", "extras", "awesome.txt")
```

```
## [1] "/Users/jeanclipperton/Library/CloudStorage/Box-Box/Teaching/CFSS/course-site/static/extras/awesome.txt"
```

```r
cat(readLines(here("static", "extras", "awesome.txt")))
```

```
## OMG this is so awesome!
```

Don't try this at home, folks! But let me set working directory to a subdirectory and prove to you that the same code as above, for getting the path to `awesome.txt`, still works.


```r
setwd(here("static"))
getwd()
```

```
## [1] "/Users/jeanclipperton/Library/CloudStorage/Box-Box/Teaching/CFSS/course-site/static"
```

```r
cat(readLines(here("static", "extras", "awesome.txt")))
```

```
## OMG this is so awesome!
```

## The fine print

`here::here()` figures out the top-level of your current project using some sane heuristics. It looks at working directory, checks a criterion and, if not satisfied, moves up to parent directory and checks again. Lather, rinse, repeat.

Here are the criteria. The order doesn't really matter because all of them are checked for each directory before moving up to the parent directory:

* Is a file named `.here` present?
* Is this an RStudio Project? Literally, can I find a file named something like `foo.Rproj`?
* Is this a checkout from a version control system? Does it have a directory named `.git` or `.svn`? Currently, only Git and Subversion are supported.

{{< figure src="allison_horst_art/cracked_setwd.png" caption="Artwork by  [allison_horst](https://github.com/allisonhorst/stats-illustrations)" >}}

## Filepaths and R Markdown documents

`here::here()` is particularly useful within R Markdown documents. Unlike `.R` scripts, R Markdown documents always knit assuming the location of the `.Rmd` file is the working directory. In an R Project, this is fine as long as the `.Rmd` is in the top-level directory. But if an R Markdown file is saved in a sub-directory, a user can quickly become confused when writing code. Say the structure is something like this:

```
data/
  scotus.csv
analysis/
  exploratory-analysis.Rmd
final-report.Rmd
scotus.Rproj
```

If you attempt to run `read_csv("data/scotus.csv")` inside of `final-report.Rmd`, it will work correctly. If you attempt to run `read_csv("data/scotus.csv")` inside of `exploratory-analysis.Rmd`, your code will fail because `data` is not a folder within `analysis`.

However, `read_csv(here("data", "scotus.csv"))` will work correctly from either `.Rmd` file because `here()` will use `scotus.Rproj` to identify the correct working directory.

## Acknowledgments

* Substantial material drawn from [What They Forgot To Teach You About R](https://whattheyforgot.org/) by Jenny Bryan and Jim Hester. Licensed under the licensed under the [CC BY-SA 4.0 Creative Commons License](https://creativecommons.org/licenses/by-sa/4.0/).
* Artwork by [allison_horst](https://github.com/allisonhorst/stats-illustrations)

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
##  date     2023-06-30
##  pandoc   3.1.4 @ /usr/local/bin/ (via rmarkdown)
## 
## ─ Packages ───────────────────────────────────────────────────────────────────
##  package     * version date (UTC) lib source
##  blogdown      1.18    2023-06-19 [1] CRAN (R 4.3.0)
##  bookdown      0.34    2023-05-09 [1] CRAN (R 4.3.0)
##  bslib         0.5.0   2023-06-09 [1] CRAN (R 4.3.0)
##  cachem        1.0.8   2023-05-01 [1] CRAN (R 4.3.0)
##  cli           3.6.1   2023-03-23 [1] CRAN (R 4.3.0)
##  colorspace    2.1-0   2023-01-23 [1] CRAN (R 4.3.0)
##  digest        0.6.31  2022-12-11 [1] CRAN (R 4.3.0)
##  dplyr       * 1.1.2   2023-04-20 [1] CRAN (R 4.3.0)
##  evaluate      0.21    2023-05-05 [1] CRAN (R 4.3.0)
##  fansi         1.0.4   2023-01-22 [1] CRAN (R 4.3.0)
##  fastmap       1.1.1   2023-02-24 [1] CRAN (R 4.3.0)
##  forcats     * 1.0.0   2023-01-29 [1] CRAN (R 4.3.0)
##  generics      0.1.3   2022-07-05 [1] CRAN (R 4.3.0)
##  ggplot2     * 3.4.2   2023-04-03 [1] CRAN (R 4.3.0)
##  glue          1.6.2   2022-02-24 [1] CRAN (R 4.3.0)
##  gtable        0.3.3   2023-03-21 [1] CRAN (R 4.3.0)
##  here          1.0.1   2020-12-13 [1] CRAN (R 4.3.0)
##  hms           1.1.3   2023-03-21 [1] CRAN (R 4.3.0)
##  htmltools     0.5.5   2023-03-23 [1] CRAN (R 4.3.0)
##  jquerylib     0.1.4   2021-04-26 [1] CRAN (R 4.3.0)
##  jsonlite      1.8.5   2023-06-05 [1] CRAN (R 4.3.0)
##  knitr         1.43    2023-05-25 [1] CRAN (R 4.3.0)
##  lifecycle     1.0.3   2022-10-07 [1] CRAN (R 4.3.0)
##  lubridate   * 1.9.2   2023-02-10 [1] CRAN (R 4.3.0)
##  magrittr      2.0.3   2022-03-30 [1] CRAN (R 4.3.0)
##  munsell       0.5.0   2018-06-12 [1] CRAN (R 4.3.0)
##  pillar        1.9.0   2023-03-22 [1] CRAN (R 4.3.0)
##  pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.3.0)
##  purrr       * 1.0.1   2023-01-10 [1] CRAN (R 4.3.0)
##  R6            2.5.1   2021-08-19 [1] CRAN (R 4.3.0)
##  readr       * 2.1.4   2023-02-10 [1] CRAN (R 4.3.0)
##  rlang         1.1.1   2023-04-28 [1] CRAN (R 4.3.0)
##  rmarkdown     2.22    2023-06-01 [1] CRAN (R 4.3.0)
##  rprojroot     2.0.3   2022-04-02 [1] CRAN (R 4.3.0)
##  rstudioapi    0.14    2022-08-22 [1] CRAN (R 4.3.0)
##  sass          0.4.6   2023-05-03 [1] CRAN (R 4.3.0)
##  scales        1.2.1   2022-08-20 [1] CRAN (R 4.3.0)
##  sessioninfo   1.2.2   2021-12-06 [1] CRAN (R 4.3.0)
##  stringi       1.7.12  2023-01-11 [1] CRAN (R 4.3.0)
##  stringr     * 1.5.0   2022-12-02 [1] CRAN (R 4.3.0)
##  tibble      * 3.2.1   2023-03-20 [1] CRAN (R 4.3.0)
##  tidyr       * 1.3.0   2023-01-24 [1] CRAN (R 4.3.0)
##  tidyselect    1.2.0   2022-10-10 [1] CRAN (R 4.3.0)
##  tidyverse   * 2.0.0   2023-02-22 [1] CRAN (R 4.3.0)
##  timechange    0.2.0   2023-01-11 [1] CRAN (R 4.3.0)
##  tzdb          0.4.0   2023-05-12 [1] CRAN (R 4.3.0)
##  utf8          1.2.3   2023-01-31 [1] CRAN (R 4.3.0)
##  vctrs         0.6.2   2023-04-19 [1] CRAN (R 4.3.0)
##  withr         2.5.0   2022-03-03 [1] CRAN (R 4.3.0)
##  xfun          0.39    2023-04-20 [1] CRAN (R 4.3.0)
##  yaml          2.3.7   2023-01-23 [1] CRAN (R 4.3.0)
## 
##  [1] /Library/Frameworks/R.framework/Versions/4.3-arm64/Resources/library
## 
## ──────────────────────────────────────────────────────────────────────────────
```
