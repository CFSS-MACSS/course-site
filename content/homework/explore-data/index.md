---
title: "HW02: Exploring and visualizing data"
date: 2023-06-20T13:30:00-06:00  # Schedule page publish date
publishdate: 2019-03-01

draft: false
#type: post
aliases: ["/hw02-explore-data.html"]

summary: "Transform and explore a cleaned dataset on gun deaths in the United States."
---



# Overview

**Due by 11:59 pm on June 20th.**

Now that you've demonstrated knowledge of your software is setup, the goal of this assignment is to practice transforming and visually exploring data.


# Accessing your `hw02` repository

* Go [to this link](https://classroom.github.com/a/J7TCyxwa) to accept and create your private `hw02` repository on GitHub. Once you do so, your repository will be built in a few seconds. It follows the naming convention `hw02-<USERNAME>`  
* Once the your repository has been created, click on the link you see, which will take you to your repository. 
* Finally, clone the repository to your computer (or R workbench) following the process below.


# Cloning your `hw02` repository

After you have accessed the `hw02` repository (see above), follow the [same steps you completed for `hw01`](/homework/edit-readme/) to clone the repository.


# General workflow

Your general workflow will be:

* Accept the repo and clone it (see above)
* Make changes locally to the files in RStudio
* Save your changes
* Stage-Commit-Push: stage and commit your changes to your local Git repo; then push them online to GitHub. You can complete these steps using the Git GUI integrated into RStudio. In general, you do not want to directly modify your online GitHub repo (if you do so, remember to pull first); instead modify your local Git repo, then stage-commit-push your changes up to your online GitHub repo. 

<!--
Please notice for this assignment we expect you to do some more work in terms of formatting and reproducibility: submit a homework that fully complies with the [Homework Guidelines](/faq/homework-guidelines/#homework-workflow).
--> 
 
<!-- NOTE: ADD THE GENERAL WORKFLOW STEPS ABOVE TO THE GENERAL WORKFLOW GUIDELINES AND REVEIW -->


# Exploring the mass shooting dataset

Your goal for this assignment is to apply what you have learned about data visualization and data exploration on a cleaned dataset that we provide: the "mass shooting" dataset.

The United States experiences far more mass shooting events than any other developed country in the world. While policymakers, politicians, the media, activists, and the general public recognize the widespread prevalence of these tragic events, policies intended to stop these events should be grounded in evidence and empirical data. 

In July 2012, in the aftermath of a mass shooting in a movie theater in Aurora, Colorado,
[Mother Jones](https://www.motherjones.com/politics/2012/07/mass-shootings-map/) published a report on mass shootings in the United States since 1982. Importantly, they provided the underlying data set as [an open-source database](https://www.motherjones.com/politics/2012/12/mass-shootings-mother-jones-full-data/) for anyone interested in studying and understanding this criminal behavior.


## Obtain the data

I have included this dataset in the [`rcis`](https://github.com/CFSS-MACSS/rcis) library on GitHub. 

* If you are working on R workbench, you should have everything already installed. Simply load the library by typing in your console `library(rcis)` and then load the dataset by typing `data("mass_shootings")`.  Use the help function in R `?mass_shootings` to get detailed information on the variables and coding information.

* If you are using R on your local computer, you first need to install the `rcis` package. Type in your console `remotes::install_github("CFSS-MACSS/rcis")`. If you don't already have the `remotes` library installed, you will get an error. Go back and install this first using `install.packages()`, then install `rcis`. Finally, the mass shootings dataset can be loaded using `data("mass_shootings")`. Use the help function in R `?mass_shootings` to get detailed information on the variables and coding information.


## Explore the data

### Very specific questions

1. Generate a data frame that summarizes the number of mass shootings per year. Print the data frame as a formatted `kable()` table (see below).
1. Generate a bar chart that identifies the number of mass shooters associated with each race category. The bars should be sorted from highest to lowest.
1. Generate a boxplot visualizing the number of total victims, by type of location. Then, redraw the same plot, but remove the Las Vegas Strip massacre from the dataset.

### More open-ended questions

Answer the following questions. Generate appropriate figures/tables to support your conclusions.

1. How many white males with prior signs of mental illness initiated a mass shooting after 2000?
1. How does the distribution of mass shooting fatalities differ between White and Black shooters? What about White and Latino shooters?
<!--
1. Which month of the year has the most mass shootings? Generate a bar chart sorted in chronological order to provide evidence of your answer.
-->

### Very open-ended question

Answer the following question. Generate appropriate figures/tables to support your conclusions. Provide 1-2 paragraphs of written interpretation of your results. Graphs and/or tables alone will not be sufficient to answer this question.

1. Are mass shootings with shooters suffering from mental illness different from mass shootings with no signs of mental illness in the shooter? Your graphs should assess the relationship between mental illness and total victims, between mental illness and location type, and intersection of all three variables.


## Formatting Guide

### Formatting graphs

While you are practicing exploratory data analysis, your final graphs should be appropriate for sharing with outsiders. That means your graphs should have:

* [A title](http://r4ds.had.co.nz/graphics-for-communication.html#label)
* Labels on the axes (see `?labs` for details)

This is just a starting point. Consider adopting your own color scales, [taking control of your legends (if any)](http://www.cookbook-r.com/Graphs/Legends_(ggplot2)/), playing around with [themes](https://ggplot2.tidyverse.org/reference/index.html#section-themes), etc.


### Formatting tables

When presenting tabular data (aka `dplyr::summarize()`), make sure you format it correctly. Use the `kable()` function from the `knitr` package to format the table for the final document. For instance, this is a poorly presented table summarizing where gun deaths occurred:




```r
# calculate total gun deaths by location
count(mass_shootings, location_type)
```

```
## # A tibble: 6 x 2
##   location_type     n
##   <chr>         <int>
## 1 Airport           1
## 2 Military          6
## 3 Other            49
## 4 Religious         6
## 5 School           18
## 6 Workplace        45
```

Instead, use `kable()` to format the table, add a caption, and label the columns:


```r
count(mass_shootings, location_type) %>%
  kable(
    caption = "Mass shootings in the United States by location",
    col.names = c("Location", "Number of incidents")
  )
```



Table: Table 1: Mass shootings in the United States by location

|Location  | Number of incidents|
|:---------|-------------------:|
|Airport   |                   1|
|Military  |                   6|
|Other     |                  49|
|Religious |                   6|
|School    |                  18|
|Workplace |                  45|

Run `?kable` in the console to see how additional options.


# Submit the assignment

To submit the assignment, simply push to your repository the last version of your assignment before the deadline. Then copy your repository URL (e.g., `https://github.com/cfss-hmwks-s23/hw2-jmclip`) and submit it to Canvas under HW02 before the deadline.

Your assignment should be submitted as a R Markdown document `.Rmd`. Need a refresher on R Markdown? [Read this](http://rmarkdown.rstudio.com/lesson-1.html) or [this](http://r4ds.had.co.nz/r-markdown.html). 

Make sure to stage-commit-push:
* `mass-shootings.Rmd` (the main file you will add your code to)
* `mass-shootings.md` (you will generate this from the .Rmd by simply knitting it)
* `mass-shootings_files/` (this folder contains all the graphs you generated in your `.Rmd`)

As part of your submission, write 1-2 paragraphs of reflections on what was hard/easy about this homework, problems you solved and how, helpful resources you consulted, etc. Please, list the first and last name of eventual collaborators with whom you worked with to complete this assignment.

<!--
Please notice for this assignment we expect you to do some more work in terms of formatting and reproducibility: submit a homework that fully complies with the [Homework Guidelines](/faq/homework-guidelines/#homework-workflow).
-->

# Rubric

Needs improvement: Displays minimal effort. Doesn't complete all components. Code is poorly written and not documented. Uses the same type of plot for each graph, or doesn't use plots appropriate for the variables being analyzed. Shows incomplete understanding of the packages needed for the assignment. No record of commits other than the final push to GitHub.

Satisfactory: Solid effort. Hits all the elements. Minor omissions but no clear mistakes. Easy to follow (both the code and the output). Shows sufficient understanding of the packages needed for the assignment.

Excellent: Finished all components of the assignment correctly. Code is well-documented (both self-documented and with additional comments as necessary). Graphs and tables are properly labeled. Uses multiple commits to back up and show a progression in the work. Analysis is clear and easy to follow, either because graphs are labeled clearly or you've written additional text to describe how you interpret the output. Shows solid understanding of the packages needed for the assignment.

For further details, see the [general rubric](/faq/homework-evaluations/) we adopt for grading.


# Acknowledgments


* This page has been developed starting from Sabrina Nardin and Benjamin Soltoff’s “Computing for the Social Sciences” course materials, licensed under the CC BY-NC 4.0 Creative Commons License.

<!--
[^clean]: For the purposes of this assignment, some data cleaning of the underlying raw data have been performed. You can view the data cleaning code [here](https://github.com/CFSS-MACSS/rcis/blob/main/data-raw/mass-shootings.R).
-->
