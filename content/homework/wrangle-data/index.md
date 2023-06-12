---
title: "HW03: Wrangling and visualizing data"
date: 2023-06-27T13:30:00-06:00  # Schedule page publish date
publishdate: 2019-03-01

draft: false
#type: post
aliases: ["/hw03-wrangle-data.html"]

summary: "Wrangle and explore messy datasets in practical research environments."
---



# Overview

**Due by 11:59 pm on June 27th.** 

The goal of this assignment is to practice wrangling and exploring social science data in a research context.


# Accessing the `hw03` repository

* Go [to this link](https://classroom.github.com/a/IPLnbCzi) to accept and create your private `hw3` repository on GitHub. Once you do so, your repository will be built in a few seconds. It follows the naming convention `hw3-<USERNAME>`  
* Once the your repository has been created, click on the link you see, which will take you to your repository. 
* Finally, clone the repository to your computer (or R workbench) following the process below.


# Cloning your `hw03` repository

After you have accessed the `hw03` repository (see above), follow the [same steps you completed for `hw01`](/homework/edit-readme/) to clone the repository.


# General workflow

Your general workflow will be:

* Accept the repo and clone it (see above)
* Make changes locally to the files in RStudio
* Save your changes
* Stage-Commit-Push: stage and commit your changes to your local Git repo; then push them online to GitHub. You can complete these steps using the Git GUI integrated into RStudio. In general, you do not want to directly modify your online GitHub repo (if you do so, remember to pull first); instead modify your local Git repo, then stage-commit-push your changes up to your online GitHub repo. 


# PART 1: Tidying messy data

In the `rcis` package, there is a data frame called `dadmom`.


```
## # A tibble: 3 x 5
##   famid named  incd namem  incm
##   <dbl> <chr> <dbl> <chr> <dbl>
## 1     1 Bill  30000 Bess  15000
## 2     2 Art   22000 Amy   18000
## 3     3 Paul  25000 Pat   50000
```

Tidy this data frame so that it adheres to the tidy data principles:

1. Each variable must have its own column.
1. Each observation must have its own row.
1. Each value must have its own cell.

Your final product (tidy data frame) should look like this:


```
##   famid parent name   inc
## 1     1      d Bill 30000
## 2     1      m Bess 15000
## 3     2      d  Art 22000
## 4     2      m  Amy 18000
## 5     3      d Paul 25000
## 6     3      m  Pat 50000
```

You can accomplish this task using a single or multiple piped operations using only `tidyr` functions. Code that does not use any `tidyr` functions is not acceptable. Check the [Data wrangling: tidy data](/syllabus/data-wrangling-tidy-data) lecture, readings, and in-class exercises before starting this part.

Once you have tidied the data frame, generate a plot using the exact code provided in your repo. If you tidied the data frame correctly, you will not have to make any changes to that code. If errors arise, it means the data has not been tidied correctly. 


# PART 2: Wrangling and visualizing messy(ish) data

## Description of the data: Supreme Court Database

The [Supreme Court Database](http://scdb.wustl.edu/) contains detailed information of every published decision of the U.S. Supreme Court since its creation in 1791. It is perhaps the most utilized database in the study of judicial politics.

In the `hw03` repository, you will find two data files:

1. `scdb-case.csv`
1. `scdb-vote.csv`

These contain the exact same data you would obtain if you downloaded the files from the original website, but reformatted to be stored as relational data files. That is, `scdb-case.csv` contains all **case-level** variables, whereas `scdb-vote.csv` contains all **vote-level** variables.

The data is structured in a tidy fashion.

* `scdb-case.csv` contains one row for every case and one column for every variable
* `scdb-vote.csv` contains one row for every vote by a justice in every case and one column for every variable

The current dataset contains information on every case decided from the 1791-2020 terms.[^terms] There are several ID variables which are useful for other types of research: for our purposes, the only ID variable you need to concern yourself with is `caseIssuesId`. Variables you will want to familiarize yourself with include:

* `chief`
* `dateDecision`
* `decisionDirection`
* `decisionType`
* `declarationUncon`
* `direction`
* `issueArea`
* `justice`
* `justiceName`
* `majority`
* `majVotes`
* `minVotes`
* `term`

{{% callout note %}}
Please read the [documentation](http://scdb.wustl.edu/documentation.php) to see how these variables are coded.
{{% /callout %}}


## Questions 

Once you import the data files, use your data wrangling and visualization skills to answer the following questions.

For each question, also provide 1-2 paragraphs of written interpretation of your results. Graphs and/or tables alone will not be sufficient to answer these questions. The interpretation should be descriptive (e.g., this graph shows x and y) and substantive (e.g., what do the results show substantially, what can we infer or conclude from the graph, etc.). 

Pay careful attention to the unit of analysis required to answer each question. Some questions only require case-level variables, others only require vote-level variables, and some may require combining the two data frames together. Be sure to choose an appropriate relational join function as necessary.

#### 1. What percentage of cases in each term are decided by a one-vote margin (i.e. 5-4, 4-3, etc.)?

#### 2. How often the justices who are currently serving on the Supreme Court, have voted in the conservative direction in cases of criminal procedure, civil rights, economic activity, and federal taxation?
* Select only the justices who are currently serving on the Supreme Court [see here](https://www.supremecourt.gov/about/biographies.aspx): John G. Roberts, Clarence Thomas, Samuel A. Alito, Sonia Sotomayor, Elena Kagan, Neil M. Gorsuch, Brett M. Kavanaugh, Amy Coney Barrett (Ketanji Brown Jackson is not in the data as she was only recently nominated). 
* Calculate how often they have voted in the conservative direction in cases involving criminal procedure, civil rights, economic activity, and federal taxation. 
* Produce two graphs with your results: one faceted by justice, the other by issue area.

#### 3. Which justices are most likely to agree with the Court's declaration that an act of Congress, a state or territorial law, or a municipal ordinance is unconstitutional? 
* Identify all cases where the Court declared something unconstitutional and determine the ten justices who most and least frequently agreed with this outcome as a percentage of all votes cast by the justice in these cases. 
* Filter out any justice with fewer than 30 votes in cases where the Court's outcome declares something unconstitutional.

#### 4. For each term he served on the Court, in what percentage of cases was Justice Antonin Scalia in the majority?

#### 5. In each term, what percentage of cases were decided in the conservative direction? And in the liberal direction? 


# Submit the assignment

To submit the assignment, simply push to your repository the last version of your assignment before the deadline. 

Then copy your repository URL (e.g., `https://github.com/cfss-hmwks/hw3-jmclip`) and submit it to Canvas under HW03 before the deadline.

Make sure to stage-commit-push:

- `dadmom.Rmd` (the main file you will add your code to)
- `dadmom.md` (you will generate this file from the .Rmd by simply knitting it)
- `scouts.Rmd` (the main file you will add your code to)
- `scotus.md` (you will generate this file from the .Rmd by simply knitting it)
- the folders with all the graphs you generated in your .Rmd files


# Rubric

Needs improvement: Doesn't complete all components. Code contain errors and/or is not clearly written and/or not documented. Uses the same type of plot for each graph, or doesn't use plots appropriate for the variables being analyzed. No record of commits other than the final push to GitHub.

Satisfactory: Solid effort. Hits all the elements. Finished all components of the assignment with only minor deficiencies. Easy to follow (both the code and the output). 

Excellent: Finished all components of the assignment correctly and used efficient code to complete the exercises. Code is well-documented (both self-documented and with additional comments as necessary). Graphs and tables are properly choosen and labeled. Use multiple commits to back up and show a progression in the work. Analysis and interpretation of results are clear and easy to follow.

For further details, see the [general rubric](/faq/homework-evaluations/) we adopt for grading.

[^terms]: Terms run from October through June, so the 2020 term contains cases decided from October 2020 - June 2021.


# Acknowledgments

* This page has been developed starting from Sabrina Nardin and Benjamin Soltoff’s “Computing for the Social Sciences” course materials, licensed under the CC BY-NC 4.0 Creative Commons License.
