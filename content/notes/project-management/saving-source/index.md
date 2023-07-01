---
title: "Saving the source and blank slates"
date: 2019-03-01

type: book
toc: true
draft: false
aliases: ["/notes/saving-source/"]
categories: ["project-management"]

weight: 91
---




```r
library(tidyverse)
library(here)

set.seed(1234)
theme_set(theme_minimal())
```

## Save source, not the workspace

Your **workspace** in R is the current working environment. It includes any libraries you have loaded using `library()`, any user-defined objects (e.g. data frames, lists, functions). At the end of an R session, you can save an image of the current workspace that is automatically reloaded the next time R is started.

**This is not good practice.** I recommend you cultivate a workflow in which you treat R processes (a.k.a. "sessions") as disposable. Any individual R process and the associated workspace is disposable. Why might this be unappealing? This sounds terrible if your workspace is a pet, i.e. it holds precious objects and you aren't 100% sure you can reproduce them. This fear is worth designing away, because attachment to your workspace indicates you have a non-reproducible workflow. This is guaranteed to lead to heartache.

Everything that really matters should be achieved through code that you save.

{{< figure src="if-you-liked-it-you-should-have-saved-the-source-for-it.jpg" caption="" >}}

All important objects or figures should be explicitly saved to file, in a granular way. This is in contrast to storing them implicitly or explicitly, as part of an entire workspace, or saving them via the mouse. These recommendations make useful objects readily available for use in other scripts or documents, with the additional assurance that they can be regenerated on-demand.

Saving code -- not workspaces -- is incredibly important because it is an absolute requirement for reproducibility. Renouncing `.Rdata` and restarting R often are not intrinsically important or morally superior behaviours. They are important because they provide constant pressure for you to do the right thing: save the source code needed to create all important artifacts of your analysis.

## Always save commands

When working with R, save your commands in a `.R` file, a.k.a. a script, or in `.Rmd`, a.k.a. an R Markdown document. It doesn't have to be polished. Just save it!

## Always start R with a blank slate

When you quit R, do not save the workspace to an `.Rdata` file. When you launch, do not reload the workspace from an `.Rdata` file.

In RStudio, set this via *Tools > Global Options*.

{{< figure src="rstudio-workspace.png" caption="" >}}

## Restart R often during development

> Have you tried turning it off and then on again?
>
> -- timeless troubleshooting wisdom, applies to everything

If you use RStudio, use the menu item *Session > Restart R* or the associated keyboard shortcut Ctrl+Shift+F10 (Windows and Linux) or Command+Shift+F10 (Mac OS). Additional keyboard shortcuts make it easy to restart development where you left off, i.e. to say "re-run all the code up to HERE":

* In an R script, use Ctrl+Alt+B (Windows and Linux) or Command+Option+B (Mac OS)
* In R markdown, use Ctrl+Alt+P (Windows and Linux) or Command+Option+P (Mac OS)

## What's wrong with `rm(list = ls())`?

{{< youtube GiPe1OiKQuk >}}

It's fairly common to see data analysis scripts that begin with this object-nuking command:

```r
rm(list = ls())
```

This is highly suggestive of a non-reproducible workflow.

This line is meant to reset things, either to power-cycle the current analysis or to switch from one project to another. But there are better ways to do both:

* To power-cycle the current analysis, restart R! See above.
* To switch from one project to another, either restart R or, even better, use an IDE with proper support for projects, where each project gets its own R process (i.e. RStudio).

**The problem with `rm(list = ls())` is that, given the intent, it does not go far enough.** All it does is delete user-created objects from the global workspace. Many other changes to the R landscape persist invisibly and can have profound effects on subsequent development. Any packages that have ever been attached via `library()` are still available. Any options that have been set to non-default values remain that way. Working directory is not affected (which is, of course, why we see `setwd()` so often here too!).

Why does this matter? It makes your script vulnerable to hidden dependencies on things you ran in this R process before you executed `rm(list = ls())`.

* You might use functions from a package without including the necessary `library()` call. Your collaborator won't be able to run this script.
* You might code up an analysis assuming that `stringsAsFactors = FALSE` but next week, when you have restarted R, everything will inexplicably be broken.
* You might write paths relative to some random working directory, then be puzzled next month when nothing can be found or results don't appear where you expect.

The solution is to write every script assuming it will be run in a fresh R process. The best way to do that is ... develop scripts in a fresh R process! 

There is nothing inherently evil about `rm(list = ls())`. It's a red flag, because it is indicative of a non-reproducible workflow. Since it appears to "work" ~90% of the time, it's very easy to deceive yourself into thinking your script is self-contained, when it is not.

## Objects that take a long time to create

Power-cycling your analysis regularly can be very painful if there are parts that take a long time to execute.

This indicates it's time for a modular approach that breaks the analysis into natural phases, each with an associated script and outputs. Isolate each computationally demanding step in its own script and write the precious object to file with `readr::save_rds(my_precious,
here("results", "my_precious.rds"))`. Now you can develop scripts to do
downstream work that reload the precious object via `my_precious <-
readr::read_rds(here("results", "my_precious.rds"))`. Breaking an analysis into logical steps, with clear inputs and outputs, is a good idea anyway.

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
##  here        * 1.0.1   2020-12-13 [1] CRAN (R 4.3.0)
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
