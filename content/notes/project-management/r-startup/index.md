---
title: "R startup procedures"
date: 2019-03-01

type: book
toc: true
draft: true
aliases: ["/notes/r-startup/"]
categories: ["project-management"]

weight: 95
---




```r
library(tidyverse)

set.seed(1234)
theme_set(theme_minimal())
```

R offers the ability to customize its startup procedures. That is, every time an R process is initiated, users can define custom R code to evaluate before the session begins. This custom code is generally stored in one of two locations:

1. [`.Renviron`](#renviron) - which contains environment variables to be set in R sessions.
2. [`.Rprofile`](#rprofile) - which contains R code to be run in each session.

## `.Renviron`

The `.Renviron` file is most useful for defining sensitive information such as [API keys](/notes/application-program-interface/#api-authentication) (such as GitHub or Twitter) as well as R specific environment variables like the history size (`R_HISTSIZE=100000`) and default library locations `R_LIBS_USER`.

The `.Renviron` file contains lists of environment variables to set. This is _not_ R code, it uses a format similar to that used on the command line shell.

The easiest way to edit `.Renviron` is by running `usethis::edit_r_environ()`.

A simple example of a `.Renviron` file is

```shell
R_HISTSIZE=100000
GITHUB_PAT=abc123
R_LIBS_USER=~/R/%p/%v
```

You will not typically need to edit this file manually. For example, `rtweet` [automatically stores your Twitter API authentication information in `.Renviron`](/notes/twitter-api-practice/#oauth-authentication).

## `.Rprofile`

The `.Rprofile` file contains R code to be run when R starts up. It is run after the `.Renviron` file is sourced. You generally have only a single `.Renviron` file on your computer. However you can have multiple `.Rprofile` files stored on a single computer.

* Typically `.Rprofile` is located in the users' home directory (`~/.Rprofile` on MacOS/Linux). This `.Rprofile` is run whenever you start up R.
* Each R Project folder can also contain a separate `.Rprofile`. This `.Rprofile` is specific to that project and will only be run if you open that R Project in RStudio.

The easiest way to edit `.Rprofile` is by running `usethis::edit_r_profile()`.

Some common things people often add to their `.RProfile`

1. Set a default CRAN mirror
1. Write a welcome message
1. Customize their R prompt
1. Change options, screen width, numeric display
1. Store API keys/tokens that are necessary for only a single project

### Git tracking of `.Rprofile`

You can commit `.Rprofile` inside of a Git repository, however you should only do this for a private repository or if `.Rprofile` does not contain API keys. If you commit `.Rprofile` to a public repo, anybody can access and view the file. If it contains an API key, anyone can use it to access that API (which is typically a violation of your user agreement, not to mention if it is a paid API you will be charged for these queries).

## Reproducibility

A good rule of thumb is you should only put things in your `.Rprofile` that you run interactively in the R terminal. If it ever appears in a R script or R Markdown file it should **not** be in your `.Rprofile`.

If you set these options in your `.Rprofile`, then try to run one of your scripts on another system without your `.Rprofile` it will no longer be reproducible. Some problematic examples are loading packages used in analysis (such as `dplyr` or `ggplot2`) or changing default options which change the _value_ of outputs, such as `options(stringsAsFactors = FALSE)`. 

In addition because the `.Rprofile` is run by **every** R process (including those started by R itself) it is important to guard most of the code with `interactive()`, so it is only run in interactive sessions (sessions you are controlling with a terminal).

A simple example of a `.Rprofile` is

```r
options(repos = c(CRAN = "https://cran.rstudio.org"))
if (interactive()) {
  options(width = 120)
}
```

## Acknowledgments

* Substantial material drawn from [What They Forgot To Teach You About R](https://whattheyforgot.org/) by Jenny Bryan and Jim Hester. Licensed under the licensed under the [CC BY-SA 4.0 Creative Commons License](https://creativecommons.org/licenses/by-sa/4.0/).

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
