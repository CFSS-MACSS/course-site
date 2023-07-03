---
title: "Text analysis: fundamentals"
date: 2023-07-11T12:25:00-05:00
publishDate: 2019-06-03T12:25:00-05:00
draft: false

aliases: ["/cm017.html"]

# Talk start and end times.
#   End time can optionally be hidden by prefixing the line with `#`.
#time_end: 2022-11-14T14:20:00-05:00
all_day: false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors: []

# Abstract and optional shortened version.
abstract: ""
summary: "Introduce methods for text data in R."

# Location of event.
location: ""

# Is this a selected talk? (true/false)
selected: false

# Tags (optional).
#   Set `tags: []` for no tags, or use the form `tags: ["A Tag", "Another Tag"]` for one or more tags.
tags: []

# Links (optional).
url_pdf: ""
url_slides: "/slides/text-analysis-fundamentals-and-sentiment-analysis/"
url_video: ""
url_code: ""

# Does the content use math formatting?
math: false
---



## Overview

* Introduce regular expressions
* Identify the basic workflow for conducting text analysis
* Define the tidy text formats (Chapter 1)
* Word frequencies and tf-idf (Chapter 1 and 3)

<!-- 
* Demonstrate how to conduct sentiment analysis using twitter
* Explain how to generate and interpret a wordcloud -->


## Before class

For this and the following lecture we use the book [*Tidy Text Mining with R*](http://tidytextmining.com/). Before this class: read Chapter 1, 3, and 4. Before next class: read chapters 2 and 6

## Class materials

* Run the code below in your console to download today’s in-class materials: `usethis::use_course("CFSS-MACSS/text-analysis-fundamentals")`


<!--
* [Text analysis: basic workflow](/notes/text-analysis-workflow/)
* [Practicing `tidytext` with song titles](/notes/song-titles-exercise/)
* [Practicing sentiment analysis with Harry Potter](/notes/harry-potter-exercise/)
* Trump twitter account: https://twitter.com/realdonaldtrump
* [Practicing tidytext with Hamilton](/notes/hamilton/)
-->


## Additional resources

**Basic text analysis:**
* The three case studies included in the book "Text Mining with R" (see assigned readings) provide in-depth examples on how to preform text analysis from A-Z. I recommend Chapter 9  [Case study: analyzing usenet text](https://www.tidytextmining.com/usenet.html)
* For an excellent theoretical explanation of these topics see [Speech and Language Processing](https://web.stanford.edu/~jurafsky/slp3/) by Daniel Jurafsky & James H. Martin, especially Chapter 2, 3, and 4

**Regular Expressions:**
* [Chapter 14](https://r4ds.had.co.nz/strings.html#strings) of our textbook *R for Data Science* 
* [Chapter 15](https://plsc-31101.github.io/course/strings-and-regular-expressions.html#applying-regex)  by Rochelle Terman, explains `stringr()` (using the *R for Data Science* textbook)  
* For an overview of regular expressions in R see [Chapter 17](https://bookdown.org/rdpeng/rprogdatascience/regular-expressions.html#the-stringr-package) from *R Programming for Data Science*. This book covers the entire range of regular expressions packages and functions; in-class we focus only on the `stringr()` package
* [`stringr()` documentation and cheatsheet](https://stringr.tidyverse.org/)
