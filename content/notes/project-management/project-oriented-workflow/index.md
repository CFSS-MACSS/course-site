---
title: "Project-oriented workflow"
date: 2019-03-01

type: book
toc: true
draft: false 
aliases: ["/notes/project-oriented-workflow/"]
categories: ["project-management"]

weight: 92 
---




```r
library(tidyverse)
library(here)

set.seed(1234)
theme_set(theme_minimal())
```

In [saving the source and blank slates](/notes/saving-the-source-and-blank-slates/), we discouraged the habit of starting R scripts with `rm(list = ls())`, because it doesn't actually achieve the intended goal: to reset things. Restarting R is a better way to power-cycle.

But what if you want to shift focus from project A to project B? Restarting R, alone, is not enough. It doesn't change R's working directory, which is needed if projects A and B live in different directories, which they should. Also, what if you want to have project A and B available for work at the same time?

My strong recommendation is to use a development tool with first-class support for projects. But first ...

## We need to talk about `setwd("path/that/only/works/on/my/machine")`

A common response to the working directory problem is to set the working directory at the beginning of each script via `setwd()`. For example:

```r
library(ggplot2)
setwd("/Users/jeanclipperton/cuddly_broccoli/verbose_funicular/foofy/data")
df <- read.delim("raw_foofy_data.csv")
p <- ggplot(df, aes(x, y)) + geom_point()
ggsave("../figs/foofy_scatterplot.png")
```

The chance of the `setwd()` command having the desired effect -- making the file paths work -- for anyone besides its author is 0%. It's also unlikely to work for the author one or two years or computers from now. To recreate and perhaps extend this plot, the lucky recipient will need to hand edit one or more paths to reflect where the project has landed on their machine.

Hard-wired, absolute paths, especially when sprinkled throughout the code, make a project brittle. Such code does not travel well across time or space.

## Dilemma and a solution

Problem statement:

* We want to work on project A with R's working directory set to `path/to/projectA` and on project B with R's working directory set to `path/to/projectB`.
* But we also want to keep code like `setwd("path/to/projectA")` out of our `.R` scripts.

The solution is to use a **project-based workflow**.

## Organize work into projects (colloquial definition)

Here's what I mean by "project-based workflow":

* File system discipline: put all the files related to a single project in a designated folder.
    * This applies to data, code, figures, notes, etc.
    * Depending on project complexity, you might enforce further organization into subfolders.
* Working directory intentionality: when working on project A, make sure working directory is set to project A's folder.
    * Ideally, this is achieved via the development workflow and tooling, not by baking absolute paths into the code.
* File path discipline: all paths are relative and, by default, relative to the project's folder.

These habits are synergistic: you'll get the biggest payoff if you practice all of them together.

These habits guarantee that the project can be moved around on your computer or onto other computers and will still "just work". I argue that this is the only practical convention that creates reliable, polite behavior across different computers or users and over time. This convention is neither new, nor unique to R.

It's like agreeing that we will all drive on the left or the right. A hallmark of civilization is following conventions that constrain your behavior a little, in the name of public safety.

## RStudio Projects

The RStudio IDE has a notion of a (capital "P") [Project](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects), which is a very effective implementation of the (small "p") projects described above. 

You can designate a new or existing folder as a Project. All this means is that RStudio leaves a file, e.g., `foofy.Rproj`, in the folder, which is used to store settings specific to that project. Use *File > New Project ...* to get started.

Double-click on a `.Rproj` file to open a fresh instance of RStudio, with the working directory and file browser pointed at the project folder.

Once RStudio is running, you can open an existing Project, switch to another Project, launch a second instance of RStudio in a new or existing Project, and much more, via various menus and keyboard shortcuts (more below).

Here's a screenshot of the Mac OS app switcher invoked via Command+Tab, showing multiple simultaneous instances of RStudio.

{{< figure src="multiple-rstudio-projects.png" caption="" >}}

This allows rapid context switching across several projects, such as an R package, teaching material, and a data analysis. There is no danger of crosstalk between the projects: each has its own R process, global workspace, and working directory.

## Tricks for opening Projects

Once you decide "I want to do some work in Project K", there are various ways to accelerate the startup process. I'll review a few going from general and low-tech to more specific.

**Have a dedicated folder for your Projects.** I keep the vast majority of my R work in RStudio Projects in the folder `~/Projects/`. What I call this folder and where I keep it is not important. The main point is if you have One Main Place for Projects, then you can go there in Finder or File Explorer and drill down to the `.Rproj` file needed to launch any specific project.

**RStudio knows about recently used Projects.** Once you are in RStudio, there are several ways to access other Projects you've recently worked in. In the upper right corner is a drop-down menu with various Project- and session-related goodies in it.

{{< figure src="rstudio-project-switching.png" caption="" >}}

Use the "arrow and paper" icon to open a Project in a separate RStudio instance, while also leaving the Project you're launching it from open. Click on a Project's name to switch the current RStudio instance from one Project to another. The *File* menu also offers ways to switch project or open new, additional instances.

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
