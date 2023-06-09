---
date: "2022-09-26T00:00:00-05:00"
draft: false
weight: 40
title: "Accessing RStudio Workbench"
toc: true
type: book
aliases: ["/setup_server.html", "/setup/r-server/"]
---


Let's begin with a few definitions:

## R

[R](https://www.r-project.org/) is an open-source programming language based on the [S](https://en.wikipedia.org/wiki/S_(programming_language)) from the 1970s. It is very popular in the physical and social sciences due to it's cost (free) and versatility. Thousands of expansion libraries have been published which extend the tasks R can perform, and users can write their own custom functions and/or libraries to perform specific operations.

## RStudio

The base R distribution is not the best for developing and writing programs. Instead, we want an integrated development environment (IDE) which will allow us to write and execute code, debug programs, and automate certain tasks. In this course we will use [RStudio](https://www.rstudio.com/products/RStudio/), perhaps the most popular IDE available for R. Like R, it is open-source, expandable, and provides many useful tools and enhancements over the base R environment.

## RStudio Workbench

Rather than installing your own copy of R and RStudio, you can access R and RStudio remotely hosted on a server. Specifically, the [Social Sciences Computing Services](https://sscs.uchicago.edu/) hosts RStudio Workbench for us. Rather than running an application on your computer, you open RStudio in your web browser. All the processing and computation is done on a remote server. This means virtually all of the software is pre-configured for you. Setup is minimal.

The downside is that you only have access to this server for the duration of the class. If you intend to use R and RStudio in future classes/research projects, you will need to install and configure everything on your own computer after the course is completed.

## Accessing RStudio Workbench
*Note: we had some issues with the workbench server so hold off until you see this message gone (added 6/9/23)*

1. Go to https://macss-r.uchicago.edu/ to login to the server. Save the link somewhere since you will be using it frequently
2. Use your [CNetID](https://uchicago.service-now.com/it?id=kb_article&kb=KB06000393) and password to login (this is the same username/password you use for other UChicago online services).
3. You're done. You should see a fresh RStudio window in your browser.

{{% callout note %}}

Only students in this course who have been approved by SSCS can access this server. If you cannot log on to the server, email me or the Server Team at ssc-server-support@lists.uchicago.edu to let them know that you are enrolled in the class (MACS 30500) and you have problems accessing the server.

If you have problems with cVPN or the network, contact [ITS](https://its.uchicago.edu/)

{{% /callout %}}

## Test it

You should see something that looks like this:

{{< figure src="rstudio-server.png" caption="" >}}

The RStudio IDE is divided into 4 separate panes (one of which is hidden for now) which all serve specific functions. To make sure R and RStudio are setup correctly, type `x <- 5 + 2` into the *console* pane (the one on the left side of your screen) and execute it by pressing Enter/Return. You just created an object in R called `x`. Type `print(x)` into the console and press enter again. Your console should now contain the following output:


```r
x <- 5 + 2
print(x)
```

```
## [1] 7
```

## Acknowledgments


* This page is derived in part from ["UBC STAT 545A and 547M"](http://stat545.com), licensed under the [CC BY-NC 3.0 Creative Commons License](https://creativecommons.org/licenses/by-nc/3.0/).

* This page has been developed starting from Benjamin Soltoff’s “Computing for the Social Sciences” course materials, licensed under the CC BY-NC 4.0 Creative Commons License.
