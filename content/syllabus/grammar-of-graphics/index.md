---
title: "Visualizations and the grammar of graphics"
date: 2023-06-14T12:25:00-05:00
publishDate: 2019-04-03T12:25:00-05:00
draft: false

aliases: ["/cm002.html"]

# Talk start and end times.
#   End time can optionally be hidden by prefixing the line with `#`.
#time_end: 2022-08-24T14:20:00-05:00
all_day: false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors: []

# Abstract and optional shortened version.
abstract: ""
summary: "Introduction to data visualizations, the grammar of graphics, and ggplot2."

# Location of event.
location: ""

# Is this a selected talk? (true/false)
selected: false

# Tags (optional).
#   Set `tags: []` for no tags, or use the form `tags: ["A Tag", "Another Tag"]` for one or more tags.
tags: []

# Links (optional).
url_pdf: ""
url_slides: "/slides/visualizations-and-the-grammar-of-graphics/"
url_video: ""
url_code: ""

# Does the content use math formatting?
math: false
---



## Overview

* Identify the importance of graphics in communicating information
* Define the layered grammar of graphics
* Demonstrate how to use layered grammar of graphics
* Practice generating layered graphics using [`ggplot2`](https://github.com/hadley/ggplot2)

## Before class

* Required: read chapter 3 from [R for Data Science](https://r4ds.had.co.nz/data-visualisation.html). You need to read this chapter and complete some of the exercises before coming to class. Exercise solutions can be found [here](https://jrnold.github.io/r4ds-exercise-solutions/).
* Optional: read Hadley Wickham [A Layered Grammar of Graphics](https://vita.had.co.nz/papers/layered-grammar.html) -- the "pre-print" version of the article can be downloaded for free. This article is optional, but I strongly encourage you to skim through it to familiarize with the theory and language of the grammar of graphics; read especially section 3 "Components of the Layered Grammar" and section 4 "A Hierarchy of Defaults."
    

## Class materials

* [Why visualize data?](/notes/why-visualize-data/)
* [The Grammar of Graphics](/notes/grammar-of-graphics/)
* [Practice generating graphics with ggplot2](/notes/gapminder/)

<!--
Optional:
* [How to build a complicated, layered graphic](/notes/minard/)
* [Exploring Minard's 1812 plot with `ggplot2`](https://github.com/andrewheiss/fancy-minard) - a much fancier (and more complex) version
-->

## Additional resources

Graphical design
* [Tufte, Edward R. *The Visual Display of Quantitative Information*.](https://www.edwardtufte.com/tufte/books_vdqi) Classic book on statistical graphics and visualization design.
* [Healey, Kieran. *Data Visualization: A Practical Guide*.](https://socviz.co/) An applied introduction to graphical design with lots of applications in `ggplot2` and many code examples.

ggplot2
* [ggplot2: Elegant Graphics for Data Analysis, 2nd Edition](https://ggplot2-book.org/) -- Hadley Wickham. Excellent resource for learning the intricacies of `ggplot2`.
* [Documentation for ggplot2](https://ggplot2.tidyverse.org/index.html)
* [R Graphics Cookbook, 2nd edition](https://r-graphics.org/) -- Winston Chang. A practical guide with 150 examples to generate quality statistical graphics based on the data you wish to present.

<!--
* Why do we learn the `ggplot2` graphics library and not the base [`graphics`](https://cran.r-project.org/web/views/Graphics.html) system? David Robinson explains it well in [Don't teach built-in plotting to beginners (teach ggplot2)](http://varianceexplained.org/r/teach_ggplot2_to_beginners/), and follows up with a longer defense of `ggplot2` in [Why I use ggplot2](http://varianceexplained.org/r/why-I-use-ggplot2/)
-->

Cheatsheets
* [Data visualization with ggplot2 cheat sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-visualization.pdf)
* [RStudio IDE Cheat Sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/rstudio-ide.pdf)


## What you need to do after class

* Complete [Homework 1](/homework/edit-readme/) and submit the link to your repo on Canvas so we can grade it
* Review today's lecture and prepare for next class 
* This applies only if you [installed your software locally](/setup/#option-2---install-the-software-locally): 
    * Install the [`rcis`](https://github.com/CFSS-MACSS/rcis) library from GitHub. To install it run the command `remotes::install_github("CFSS-MACSS/rcis")` in the console. We will be using data from this package in class. 
    * Notice: if you do not already have the `remotes` library installed, you will get an error. Go back and install this first using `install.packages("remotes")`, then run `remotes::install_github("CFSS-MACSS/rcis")` in the console.
