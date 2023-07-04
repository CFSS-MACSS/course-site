---
title: "A deep dive into Git/GitHub"
date: 2023-07-05T12:25:00-05:00
publishDate: 2019-05-01T12:25:00-05:00
draft: false

# Talk start and end times.
#   End time can optionally be hidden by prefixing the line with `#`.
#time_end: 2022-09-28T14:20:00-05:00
all_day: false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors: []

# Abstract and optional shortened version.
abstract: ""
summary: "Review of Git/GitHub basics, more advanced commands, command line, good practices."

# Location of event.
location: ""

# Is this a selected talk? (true/false)
selected: false

# Tags (optional).
#   Set `tags: []` for no tags, or use the form `tags: ["A Tag", "Another Tag"]` for one or more tags.
tags: []

# Links (optional).
url_pdf: ""
url_slides: "/slides/reproducible-examples-and-git/"
url_video: ""
url_code: ""

# Does the content use math formatting?
math: false
---



## Overview

* Review Git/GitHub basic workflow using the R GUI
* Learn how to use basic Git/GitHub workflow through the command line
* Good practices
* Common problems and how to solve them

## Before class

* [Chapter 1 Why Git? Why GitHub?](https://happygitwithr.com/big-picture.html) in *"Happy Git and GitHub for the useR"*
* Read ["Excuse me, do you have a moment to talk about version control?"](https://peerj.com/preprints/3159v2/)
* Skim chapters 15, 16, and 17 included in the section [Early GitHub Wins](https://happygitwithr.com/usage-intro.html) in *"Happy Git and GitHub for the useR"*
* Skim chapters 20 to 23 in the section [Git fundamentals](https://happygitwithr.com/git-intro.html) in *"Happy Git and GitHub for the useR"*

We will be using R Workbench for the lecture and the in-class exercises. If you are using R from your laptop (VS. R Workbench), make sure your system is correctly configured, see the [Git page under Setup](/setup/git/).


## Class materials

#### Today's lecture builds upon the following two resources by *The Carpentries*:
* [Version Control with Git](https://swcarpentry.github.io/git-novice/)
* [Library Carpentry: Introduction to Git](https://librarycarpentry.org/lc-git/01-what-is-git.html)

#### We learned the following commands 

Terminal/command line commands: 
* `pwd`   to check your current directory
* `cd`    to navigate to your desired directory and move around terminal 
* `ls`    to list all visible content in your current directory
* `ls -a` to list all visible and hidden contents in your current directory
* `touch` to create a new file; provide the filename and the extension 
* `:q`    to exit and end the execution of a process

Git commands:
* `git init`       to initialize a new repo
* `git status`     to check the current status of your repo
* `git add .`      to add to the git staging area all new or changed files
* `git commit -m "your commit message"`  to commit the staged files
* `git push`       to push your committed files the online Github repo
* `git diff`       to show differences in files
* `git log`        to show all history of your commits
* `git reset --hard HEAD~1`   to delete a pushed commit (use with caution), followed by `git push -f origin main` to push the deleted commit to the online Github repo 


# After Class
* [Generating a reproducible example](/notes/reproducible-examples/)
* [Recovering from common Git predicaments](/notes/common-git-problems/)


