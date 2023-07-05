---
title: "HW05: Debugging and practice working with functions"
date: 2023-07-05T13:30:00-06:00  # Schedule page publish date
publishDate: 2019-03-01T12:25:00-05:00
draft: false

summary: "Resolve code errors and practice writing and using functions with social science data."
---



# Overview

**Due by 11:59 pm on July 5th**

The goal of this assignment is to practice debugging common errors in code, and writing/using functions with social science data.


# Accessing the `hw05` repository

* Go [to this link](https://classroom.github.com/a/7REwA96x) to accept and create your private `hw05` repository on GitHub. Once you do so, your repository will be built in a few seconds. It follows the naming convention `hw05-<USERNAME>`  
* Once the your repository has been created, click on the link you see, which will take you to your repository. 
* Finally, clone the repository to your computer (or R workbench) following the process below.


# Cloning your `hw05` repository

After you have accessed the `hw05` repository (see above), follow the [same steps you completed for `hw1`](/homework/edit-readme/) to clone the repository.


# General workflow

Your general workflow will be:

* Accept the repo and clone it (see above)
* Make changes locally to the files in RStudio
* Save your changes
* Stage-Commit-Push: stage and commit your changes to your local Git repo; then push them online to GitHub. You can complete these steps using the Git GUI integrated into RStudio. In general, you do not want to directly modify your online GitHub repo (if you do so, remember to pull first); instead modify your local Git repo, then stage-commit-push your changes up to your online GitHub repo. 

# Part 1: Using functions in social science data analysis

The World Bank publishes extensive socioeconomic data on countries and economies worldwide. In the `data_world_bank` folder included in this assignment, I put a subset (n = 20) of the World Bank’s `csv` data files with economic indicators for each country ([https://data.worldbank.org/indicator](https://data.worldbank.org/indicator)). Each `csv` file contains data on a given country economy's data.

Your task is edit the `functions.Rmd` file to write and call a function (give it a meaningful name) that imports each data file and renames some of the columns in each data file:
* Your function should import a SINGLE data file (e.g., do not try to run an iterative operation inside the function -- technically this can work, but it is far harder to fix errors and write the body of the function if you are performing both tasks simultaneously). The function should take one single argument: the file path to the data file. Given this path, the function should import and rename the data, and return the cleaned data as output.
* Your function should rename the following four variables: "Country Name", "Country Code", "Indicator Name", "Indicator Code", as `country`, `country_code`, `indicator`, `indicator_code`.
* Before writing your function make sure to inspect a few of the `csv` files. For example, when you import the data you want to skip the first four rows, etc.

Once you have written this function, demonstrate that it works by importing the data files and combining them into a single data frame using an iterative operation. Follow the instructions provided in the `functions.Rmd` file for more.  


<!--
Once you have the data imported, write a brief report exploring and analyzing at least [two variables in the data](http://data.worldbank.org/indicator). Use a combination of descriptive statistics, tables, and figures, and present your results and analysis in a coherent and interpretable manner. The main point is that your report should not just be code and output from R - you also need to include your own written analysis. Submitting the report as an [Quarto document](http://rmarkdown.rstudio.com/) will make this much easier (and is in fact mandatory).
-->


# Part 2: Debugging code

The repository contains a file called `fix-errors.Rmd`. This script includes code to conduct analysis of baby name popularity in the United States using the [`babynames`](http://hadley.github.io/babynames/) package. 

Its author made some mistakes and the script currently does not work. Fix the errors/warnings in the script to generate the desired output.


# Submit the assignment

To submit the assignment, simply push to your repository the last version of your assignment before the deadline. Then copy your repository URL (e.g., `https://github.com/css-fall22/hw05-brinasab`) and submit it to Canvas under HW05 before the deadline.

Make sure to stage-commit-push:

- the revised `fix-errors.Rmd` (from this file, generate and submit also a` fix-errors.md` file)
- the completed `functions.Rmd` (from this file, generate and submit also a `functions.md` file)


# Rubric

Needs improvement: The errors script has not been successfully fixed. The functions to import the data has not been fully set up, and/or is used incorrectly. The code does not run and/or partially runs. Partial or insufficient attention to standards of reproducible research.

Satisfactory: Solid effort. Hits all the elements. Finished all components of the assignment with only minor deficiencies. Easy to follow (both the code and the output). 

Excellent: Finished all assignment components correctly and used efficient code to complete the exercises. The solutions adopted went beyond what strictly required. The code is well-documented (both self-documented and with additional comments as necessary). The function is written succinctly/comprehensibly and used correctly. Use multiple commits to back up and show a progression in work.

For further details, see the [general rubric](/faq/homework-evaluations/) we adopt for grading.

# Acknowledgments

* This page has been developed starting from Sabrina Nardin and Benjamin Soltoff’s “Computing for the Social Sciences” course materials, licensed under the CC BY-NC 4.0 Creative Commons License.
