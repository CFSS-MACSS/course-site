---
title: "Text analysis: topic modeling and sentiment analysis"
date: 2023-07-13T12:25:00-05:00
publishDate: 2019-06-01T12:25:00-05:00
draft: false

aliases: ["/cm018.html"]

# Talk start and end times.
#   End time can optionally be hidden by prefixing the line with `#`.
#time_end: 2022-11-16T14:20:00-05:00
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
url_slides: "/slides/text-analysis-classification-and-topic-modeling/"
url_video: ""
url_code: ""

# Does the content use math formatting?
math: false
---



## Overview

* Introduce supervised and unsupervised text classification
* Define sentiment analysis and demonstrate its use (Chapter 2)
* Define topic modeling with Latent Dirichlet allocation and demonstrate its use (Chapter 6)


## Before class

* Read Chapter 2 and Chapter 6 in [Tidy Text Mining with R](http://tidytextmining.com/)
* Read [Probabilistic Topic Models](http://www.cs.columbia.edu/~blei/papers/Blei2012.pdf) by Blei, David (2012)

<!--
*[Topic modeling](/notes/topic-modeling/) from the lecture notes demonstrates how to implement this in a (semi)-tidy workflow
-->

## Class materials

* Run the code below in your console to download today’s in-class materials: `usethis::use_course("CFSS-MACSS/text-analysis-fundamentals-and-sentiment-analysis-and-tm")`

<!--
* [Predicting song artist from lyrics](/notes/predicting-song-artist/)
* [Text analysis: topic modeling](/notes/topic-modeling/)
-->

## Additional resources

* See additional resources for the previous lecture on text analysis and regular expressions
* Original [Topic Modeling (LDA) article](https://www.jmlr.org/papers/volume3/blei03a/blei03a.pdf?ref=https://githubhelp.com) by Blei, David M., Andrew Y. Ng, and Michael I. Jordan. 2003. “Latent Dirichlet Allocation.”
* For an introduction to supervised classification with text data, read [Classification](https://smltar.com/mlclassification.html) in Supervised Machine Learning for Text Analysis in R
* Two blog posts by David Robinson (co-author of `tidytext`) analyzing Donald J. Trump's twitter account. Regardless of your political affiliations, these are excellent examples demonstrating of the key principles of reproducible research that we've learned in this course (e.g., R Markdown documents and knitting code with output; Retrieving data from APIs; Textual analysis with `tidytext`; Visualizations with `ggplot2)
    * [Text analysis of Trump's tweets confirms he writes only the (angrier) Android half](http://varianceexplained.org/r/trump-tweets/)
    * [Trump's Android and iPhone tweets, one year later](http://varianceexplained.org/r/trump-followup/)
