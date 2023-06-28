---
title: "HW8: Analyzing textual data"
date: 2023-07-16T13:30:00-06:00  # Schedule page publish date
publishdate: 2019-04-01

draft: false
aliases: ["/hw09-text_analysis.html"]

summary: "Collect text data and analyze it."
---



# Overview

**Due by 11:59 pm on July 16th.**

The goal of this assignment is to practice the fundamentals of text analysis in R tidyverse.


# Accessing the `hw08` repository

* Go [to this link](https://classroom.github.com/a/eey4atfa) to accept and create your private `hw08` repository on GitHub. Your repository will be built in a few seconds. It follows the naming convention `hw08-<USERNAME>`   
* Once your repository has been created, click on the link you see, which will take you to your repository. 
* Finally, clone the repository to your computer (or R workbench) following the process below.

Notice the repo you clone for this assignment is empty: **add your data and code, and push them to your GitHub repo**.


# Cloning your `hw08` repository

After you have accessed the `hw8` repository (see above), follow the [same steps you completed for `hw1`](/homework/edit-readme/) to clone the repository.


# General workflow

Your general workflow will be as follows:

* Accept the repo and clone it (see above)
* Make changes locally to the files in RStudio
* Save your changes
* Stage-Commit-Push: stage and commit your changes to your local Git repo; then push them online to GitHub. You can complete these steps using the Git GUI integrated into RStudio. DO not directly modify your online GitHub repo (if you do so, remember to pull first); instead, modify your local Git repo, then stage-commit-push your changes up to your online GitHub repo. 

# Assignment description

**Goal:** practice the fundamentals of text analysis in R (import and pre-process data, perform exploratory analyses, and perform sentiment analysis OR topic modeling).

**Instructions:**

* **Select a corpus and import it.** See below for suggestions. 

* **Clean and pre-process your corpus.** Apply the following as necessary for your project (e.g., you do not have to apply all of them): tokenize the text, convert it to lower case, remove or replace unwanted tokens, remove stop words (standard and/or domain-specific), apply stemming or lemmatization. Use regular expressions as necessary. 

* **Perform basic exploratory analyses.** This can include a count and plot of standard word frequencies, tf-idf, and/or other topics covered in class or the assigned readings (e.g., use the tidy text approach). To complete these tasks: see **“Text Mining with R” Chapters 1, 3, 4 and lectures**. Specifically:
    * Explain the analyses you perform and what constitutes your unit of analysis (e.g., what makes a document in your corpus). Briefly explain the techniques you use
    * Produce at least two visualizations, or one visualization and one descriptive table
    * Interpret the results

* **Perform sentiment analysis OR topic modeling**. To complete this part: see **“Text Mining with R” Chapters 2 and 6 and lectures**. 
Specifically:
  * Include an explanation of the method you choose, including its pros and cons. This does not have to be an in-depth theoretical or mathematical explanation, think about it as an overview of the method that you would provide to someone that knows nothing about it; use your own words, but make sure to refer to the assigned readings (for instance Blei et al. article for topic modeling) and, if you use additional references, cite them as well
  * Explain step-by-step what you do (for example, for topic modeling: data preparation, document-term-matrix, criteria used to select the number of topics, etc.)
  * Produce at least one visualization
  * Interpret the results
  * Suggestions: 
    * if you use topic modeling and your data are formatted as tidy text (one-term-per-row data frame), you first have to convert them into a matrix, specifically a document-term-matrix. "Text Mining with R”  Chapter 5 explains how to do so
    * if your corpus is big, feel free to select only a subset of documents for this assignment; the bigger the data, the more difficult it is to analyze it and make sense of 

**Examples to follow:**
* Book [Text Mining with R](https://www.tidytextmining.com/index.html), especially the assigned Chapters; among the case studies, I recommend Chapter 9 but the other case studies also provide excellent insights
* In-class materials 

**How much do you need to do?**

Your main tasks are: import and pre-process the data, analyze them for general exploratory analysis, and then apply sentiment analysis OR topic modeling (do not do both, just pick one). 

I expect you to use the class materials and the book [Tidy Text Mining with R](http://tidytextmining.com/) as templates to perform this type of analysis (do not reinvent the wheel). You can apply the templates to a novel corpus. You are also welcome to use one of the provided examples as your data source, as long as you expand on the provided code (e.g., if the readings perform sentiment analysis on a specific textual corpus, you can use the same corpus to perform topic modeling instead). 

In all circumstances, *make sure to quote your resources* (assigned readings and additional online tutorials or resources you might rely on).


# Suggested data sources

You can use **any source of textual data.** If you are not sure, here are some suggested texts you could use:

* `gutenbergr` (see also Chapter 1 of the assigned readings on this)
* [Congressional Record for the 43rd-114th Congresses: Parsed Speeches and Phrase Counts](https://data.stanford.edu/congress_text)
* [Data for Everyone](https://www.figure-eight.com/data-for-everyone/) - a bunch of open-source data sets. Some contain text data, such as *New England Patriots Deflategate sentiment*
* [Hate speech samples](https://github.com/t-davidson/hate-speech-and-offensive-language)
* [Last statements by Texas death row inmates](https://www.kaggle.com/mykhe1097/last-words-of-death-row-inmates)
* [Movie Review Data](http://www.cs.cornell.edu/people/pabo/movie-review-data/) - good for sentiment analysis
* [The musiXmatch Dataset](http://millionsongdataset.com/musixmatch/)
* [State of the Union speeches](http://www.presidency.ucsb.edu/sou.php)
    * [`sotu`](https://github.com/statsmaths/sotu) - R package with all State of the Union speeches through 2016. Easier starting point.
* [Something from here](https://docs.google.com/spreadsheets/d/1I7cvuCBQxosQK2evTcdL3qtglaEPc0WFEs6rZMx-xiE/edit#gid=0) (by Chris Bail)
* Examples provided in the readings and lectures. The [data from the book are stored in this GitHub repository](https://github.com/dgrtwo/tidy-text-mining) 


# Submit the assignment

Your GitHub repo should include everything you have used to produce your analyses, such as R scripts and/or R Markdown documents, original textual data (unless they are too large to be uploaded on GitHub – see HW6 for details), etc. Make sure to stage-commit-push your original `.Rmd` file and its `.md` 

In your `README.md`:
* explain the purpose of the repository
* include an explanation of what your code does and how to use it, and list all libraries required to reproduce your analyses 
* include a description of the textual data
* provide any other relevant information that the user needs to know in order to use your repo and replicate your results 
* quote all resources you consulted to complete the assignment
* provide 1-2 paragraphs of reflections on what was hard/easy about this homework, what was enjoyable, problems you solved and how you solved them, helpful resources, etc. + list any collaborators and their role

To submit the assignment, push to your repository the last version of your assignment before the deadline. Then copy your repository URL (e.g., `https://github.com/cfss-hmwks-s23/hw08-jmclip`) and submit it to Canvas under HW08 before the deadline.


# Rubric

Needs improvement: Not all elements listed in the instructions are addressed. Code does not run and/or has bugs. Code is short/elementary and poorly documented. No clear effort is made to pre-process the text for analysis, or no justification is provided for keeping content such as numbers, stopwords, etc. Results are poorly interpreted or misinterpreted. Visualizations do not include any element more than the basics. There is little attention to reproducibility issues and little consistency in the code's style.

Satisfactory: Solid effort. Hits all the elements. Finished all components of the assignment with only minor deficiencies. Easy to follow (both the code and the output). 

Excellent: Displays in-depth understanding of course materials, including data analysis and coding skills. Code to process and analyze the data is complex/refined. Visualizations are excellent. Explanation of the chosen technique is accurate with an assessment of the appropriate caveats for what the technique can and cannot do. Interpretation of the results is clear and in-depth and shows engagement with the content of the textual data. Code is reproducible. Uses a sentiment analysis or topic model example not directly covered in class or considerably expands on the provided examples.
