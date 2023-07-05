---
title: "Getting data from the web: API access"
date: 2023-07-06T12:25:00-05:00
publishDate: 2019-06-01T12:25:00-05:00
draft: false

aliases: ["/cm015.html"]

# Talk start and end times.
#   End time can optionally be hidden by prefixing the line with `#`.
#time_end: 2022-10-31T14:20:00-05:00
all_day: false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors: []

# Abstract and optional shortened version.
abstract: ""
summary: "Define web-scraping, define APIs, and query APIs."

# Location of event.
location: ""

# Is this a selected talk? (true/false)
selected: false

# Tags (optional).
#   Set `tags: []` for no tags, or use the form `tags: ["A Tag", "Another Tag"]` for one or more tags.
tags: []

# Links (optional).
url_pdf: ""
url_slides: "/slides/getting-data-from-the-web-api-access/"
url_video: ""
url_code: ""

# Does the content use math formatting?
math: false
---



## Overview

* Identify multiple methods for obtaining data from the internet
* Define web-scraping
* Define Application Program Interface (API)
* Explain APIs authentication keys and demonstrate secure methods for storing these keys
* Interact with APIs
* Define JSON data structure and how to convert them to data frames

<!--
* Practice tidying messy JSON data objects using `tidyr`
* Demonstrate how to use canned packages in R to access APIs
* Practice gathering data from Twitter API using the `rtweet` package in R
-->

## Before class

* Chapter 1 and 4 in [Web Scraping with R](https://steviep42.github.io/webscraping/book/)
* Setup: 
    1. Go to [the geonames site](http://www.geonames.org/login/) and register an account 
    2. Click [here](http://www.geonames.org/enablefreewebservice) to enable the free web service
    3. Go to the [OMDb website and click on the "API Key" tab to generate your API key](https://www.omdbapi.com/)


Several packages are needed for this week's lectures (all installed on R workbench). If you are using R from your laptop (VS. R Workbench), I'd suggest following the lectures using R Workbench and installing the packages after class.


## Additional Resources 

* [`rvest` documentation](https://rvest.tidyverse.org/articles/harvesting-the-web.html)
* [`httr` documentation](https://cran.r-project.org/web/packages/httr/)
* [Web Scraping using R Cheat Sheet](https://github.com/yusuzech/r-web-scraping-cheat-sheet/blob/master/README.md)
* [More install-and-play API packages for R](https://github.com/ropensci/webservices)

<!--
* Read [Getting data from the web: API access](/notes/application-program-interface/)
* Read [Getting data from the web: writing API queries](/notes/write-an-api-function/)
-->

## Class materials

* Run the code below in your console to download today’s in-class exercises: `usethis::use_course("CFSS-MACSS/web-api-access")`

<!--
* [Practice getting data from the Twitter API](/notes/twitter-api-practice/)
* [Simplifying lists](/notes/simplify-nested-lists/)
-->
