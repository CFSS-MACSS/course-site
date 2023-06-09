---
date: "2022-09-25T00:00:00-05:00"
draft: false
weight: 10
title: "General Questions & Info"
toc: true
type: book
#aliases: ["/hw00_peer-review.html"]
---

## Should I take this course?

Meet some of the types of students you will find in this class.

### Jeri

{{< figure src="jeri.jpg" >}}

* Starting points
    * Ph.D. student in Sociology
    * Has experience analyzing data in Stata
    * Feels comfortable with regression and other stats methods 
    * Tried to learn Git on her own once, quickly became frustrated and gave up
* Needs
    * Wants to transition from Stata to R 
    * Will be analyzing a large-scale dataset for her dissertation
    * Seeks a reproducible workflow to manage her data projects

### Ryan

{{< figure src="ryan.jpg" >}}

* Starting points
    * Entering the [MAPSS program](https://mapss.uchicago.edu/)
    * Undergraduate degree in journalism
    * Hasn't taken a statistics class in years
    * Took an online course of introduction to R, but hasn't used it in his day-to-day work
* Needs
    * Writing a master's thesis in a single year
    * Expects to analyze a collection of published news articles 
    * Wants to understand code samples found online and adapt them to his own work


### Fernando

{{< figure src="fernando.jpg" >}}

* Starting points
    * Third-year undergraduate student
    * Majoring in political science
    * Has taken general education math/stats courses
    * Does not have programming experience, but isn't afraid to tackle a new challenge
* Needs
    * Wants to work as a research assistant on a project exploring the onset of civil conflict, which is run exclusively in R
    * Will start contributing to a new research paper next quarter
    * Wants to produce high-quality visualizations
    

### Fang

{{< figure src="fang.jpg" >}}

* Starting points
    * First year grad-student
    * Background in psychology, plans to apply for doctoral programs in marketing
    * Has experience using Excel, SPSS, and Stata
* Needs
    * Is going to analyze data collected by her lab members in the next six months
    * Wants to produce analysis notebooks that are easily shareable with her colleagues
    * Expects to take courses in machine learning and statistics which require a background in R


## General description

This course is open to any graduate (or advanced undergraduate) at the University of Chicago. I anticipate drawing students from a wide range of departments such as Information Science, Sociology, Psychology, Political Science, etc. Typically these students are looking to learn basic computational and analytic skills they can apply to master's projects or dissertation research.

If you have never programmed before or don't know what the [shell](/setup/shell/) is, **prepare for a shock**. This class will prove to be very beneficial if you stick with it, but that will require you to commit for the full quarter. I do not presume any prior programming experience, so everyone starts from the same knowledge level. I guarantee that the first few weeks and assignments will be rough - but the good news is that they will be rough for everyone! Your classmates are struggling with you and you can lean on one another to get through the worst part of the learning curve.

<!--
A highly selective sampling of feedback from when I taught [a similar course at the University of Chicago](https://cfss.uchicago.edu):

> I think this class is really well-organized. The homework is craftily designed as a way to solidify the materials learned in class. Dr. Soltoff is wonderful and helpful! He came to class fully prepared and made the lectures enjoyable and productive. I suggest that all Ph.D. students in Political Science (at least in my field), who likes to conduct quantitative research, should choose this class in the first year, because this class can well set students up with a good understanding of programming techniques.

> Very useful material that I hated learning until 2/3 through the quarter.

> This class can set you up really nicely with conversant knowledge in R programming and a large amount of coding materials that are helpful for future research. And it also provides students with a first-hand experience of using some of the cutting edge methods and makes students have a taste of them.

> I'm so so so glad I ended up taking this course. I had a lot of doubts about my own (lack of) skills and my inability to to handle so many things in one quarter. I had a lot of apprehensions about this course but they all quickly disappeared. It's quite honestly been one of the most valuable courses I've taken at this University and I attribute all of that to your excellence as a lecturer. You and the TAs have always been extremely accessible to everyone and I can't appreciate that enough. In other classes, I would've been more hesitant to ask "dumb questions" but you all have made me comfortable doing so, and I have benefited immensely from it.

> I feel like every time I have a question or want to participate, I am always acknowledged. I also built a strong relationship with my classmates which is crucial for some of the difficult assignments.
-->

## Textbooks/Readings

### Required 

* [R for Data Science](http://r4ds.had.co.nz/) -- Garrett Grolemund and Hadley Wickham. We will be reading several chapters from this book. The open-source online version is available for free; the hardcover version available for purchase online.

    > Completing the exercises in the book? No official solution manual exists, but several can be found online. I recommend [this version by Jeffrey B. Arnold](https://jrnold.github.io/r4ds-exercise-solutions/). Your exact solutions may vary, but these can be a good starting point.

### Additional resources

* [ggplot2: Elegant Graphics for Data Analysis, 3rd Edition](https://ggplot2-book.org/) -- Hadley Wickham. Excellent resource for the [`ggplot2`](https://cran.r-project.org/web/packages/ggplot2/index.html) graphics library.
* [Advanced R](https://adv-r.hadley.nz/) -- Hadley Wickham. A deep dive into R as a programming language, not just a tool for data science.
* [An Introduction to Statistical Learning: with Applications in R](https://www.statlearning.com/) -- Gareth James, Daniela Witten, Trevor Hastie, and Robert Tibshirani. A thorough introduction to statistical learning and machine learning methods, focusing on the fundamentals of how these methods work and the assumptions that go into them. See also [ISLR `tidymodels` Labs](https://emilhvitfeldt.github.io/ISLR-tidymodels-labs/). This site demonstrates how to implement all the labs.
* [RStudio Cheatsheets](https://www.rstudio.com/resources/cheatsheets/) - printable cheat sheets for common R tasks and features.
    
### Resources for under-represented groups in programming

Thanks to [Angela Li](https://angela-li.github.io/) for compiling these recommendations:

* [R LGBTQ Twitter](https://twitter.com/r_lgbtq): Affinity group for queer people in the R community -- Twitter often promotes events, panels and talks by and for queer R users. 
* [Gayta Science Twitter](https://twitter.com/gaytascience): Alliance that uses data science techniques to give LGBTQ+ experiences a voice -- Twitter will often share data-driven work concerning the LGBTQ+ community. 
* [RLadies Community Slack](http://bit.ly/rladies-slack): A global programming meetup for non-binary, trans, and female R users. 
* [RLadies Remote Twitter](https://twitter.com/RLadiesRemote): Remote chapter of R Ladies -- has Slack coffee chats to discuss programming topics in a supportive environment. 
* [People of Color Code Meetup](https://www.meetup.com/People-of-Color-Code/): A meetup for POC software developers -- has events where POC developers can work on personal projects, collaborate, and learn. 
* [R Forwards](https://forwards.github.io/): A task force set up by the R Foundation to address the under-representation of under-represented groups in the R community -- collects representation data in the R community, produces workshops and teaching materials 
* [R Community Diversity and Inclusion Working Group](https://github.com/RConsortium/RCDI-WG): Working group set up by the R Consortium to encourage and support diversity and inclusion across a variety of events and platforms in the R community 


## What do I need for this course?

**You will need to bring a computer to class each day.** Class sessions are a mix of lecture, demonstration, and live coding. It is essential to have a computer so you can follow along and complete the exercises.

By the end of the first week, you should make sure you can access the following software:

* [R](https://www.r-project.org/) - the easiest approach is to select a [pre-compiled binary appropriate for your operating system](https://cran.rstudio.com/).
* [RStudio's IDE](https://www.rstudio.com/products/RStudio/) - this is a powerful user interface for programming in R.
* [Git](https://git-scm.com/) - Git is a [version control system](https://en.wikipedia.org/wiki/Version_control) which is used to manage projects and track changes in computer files. Once installed, it can be integrated into RStudio to manage your course assignments and other projects.

Comprehensive instructions for downloading and setting up this software can be found [here](/setup/).

## How will I be evaluated?

Students will complete a series of (roughly) weekly programming assignments linked to class materials.Each assignment will be evaluated by myself or a TA.

Assignments will initially come with starter code, or an initial version of the program where you need to fill in the blanks to make it work. As the quarter moves on and your skills become more developed, less help upfront will be provided. 

While students are encouraged to assist one another in debugging programs and solving problems in these assignments, it is imperative students also learn how to do this for themselves. That is, **students need to understand, write, and submit their own work.**

For further information see:
* [Evaluation criteria for homework](/faq/homework-evaluations/)
* [How to properly ask for help](/faq/asking-questions/)

<!--
* [General guidelines for submitting homework](/faq/homework-guidelines/)
-->

## Academic integrity

Each student in this course is expected to abide by the [University of Chicago Code of Academic Integrity](https://college.uchicago.edu/student-services/academic-integrity-student-conduct). Under the provisions of the Code, anyone who gives or receives unauthorized assistance in the preparation of work at home or during tests in class will be subject to disciplinary action. A student's name on any piece of work is our assurance that they have neither given nor received any unauthorized help in its preparation. Students may assist each other on assignments by answering questions and explaining various concepts. However, one student should not allow another student to copy their work directly. All University policies with respect to cheating will be enforced.


## Statement on diversity, inclusion, and disability

The University of Chicago (as an institution) and I (as a human being and instructor of this course) am committed to diversity and rigorous inquiry from multiple perspectives. The MAPSS, CIR, and Computation programs share this commitment and seek to foster productive learning environments based upon inclusion in education, open communication, and mutual respect for a diverse range of identities, experiences, and positions.

Services and reasonable accommodations are available to persons with temporary and permanent disabilities, to students with DACA or undocumented status, to students facing mental health or other personal challenges, and to students with other kinds of learning challenges. Please, feel free to let me know if there are circumstances affecting your ability to participate in class. 

If you have, or think you may have a disability, please contact Student Disability Services for a confidential discussion and for requesting accommodation: [SDS](https://disabilities.uchicago.edu/about-3-2-2/contact-us/). Once SDS approves your accommodation, it will be emailed to both you and me. Please, follow up with me to discuss the necessary logistics of your accommodations. If you need immediate accommodation, please speak with me after class or send an email message to me and [SDS](https://disabilities.uchicago.edu/about-3-2-2/contact-us/).

Any suggestions for how we might further such objectives both in and outside the classroom are appreciated and will be given serious consideration. Please share your suggestions or concerns with your instructors, your preceptor, or your program’s Diversity and Inclusion representatives: Darcy Heuring (MAPSS), Matthias Staisch (CIR), and Chad Cyrenne (MACSS). You are also welcome and encouraged to contact the Faculty Director of your program.

Some resources that might be of use include:
- [Office of Student Disability Services](https://disabilities.uchicago.edu/)
- [UChicago Student Wellness](https://wellness.uchicago.edu/)
- [Center for Identity and Inclusion](https://inclusion.uchicago.edu/)

<!--
### Disability accommodations

Your access in this course is important to me. Please request your accommodation letter early in the semester, or as soon as you become registered with Student Disability Services (SDS), so that we have adequate time to arrange your approved academic accommodations.
 
- Once SDS approves your accommodation letter, it will be emailed to both you and me. Please follow up with me to discuss the necessary logistics of your accommodations.
- If you experience any access barriers in this course, such as with printed content, graphics, online materials, or any communication barriers, reach out to me or SDS right away.
- If you need immediate accommodation, please speak with me after class or send an email message to me and [SDS](mailto:sds_cu@cornell.edu).
 
If you have, or think you may have a disability, please contact Student Disability Services for a confidential discussion: [SDS](mailto:sds_cu@cornell.edu) or visit [sds.cornell.edu](https://sds.cornell.edu) to learn more. 
-->

## Covid-19 Policies

All students on campus are required to adhere to the University of Chicago guidelines. See [UChicago Go Forward](https://goforward.uchicago.edu/) for the latest updates.


## Acknowledgments

* Stock photos of student learners by [Generated Photos](https://generated.photos/)
* This page has been developed starting from Benjamin Soltoff’s “Computing for the Social Sciences” course materials, licensed under the CC BY-NC 4.0 Creative Commons License.



<!--
As part of this course you will be reviewing, commenting on, and marking other students' assignments. This is a mandatory part of the course: failure to complete peer reviews will result in a mark down on your final grade.

## Expectations for peer reviewer

* Identify three **specific things** your peer did well
* Identify three **specific things** the student could improve upon (and ideally provide a suggested approach or solution)

## How to do peer review well

* Give thoughtful, constructive and considerate comments
* Be specific and concise
* Use [the rubric](/faq/homework-evaluations/) for ideas about criteria to evaluate and comment on
* Try to learn something new and, if you succeed, point that out
* If you can't find anything to praise or that you found helpful, then at least offer some suggestions in a kind way
* See [here](https://help.github.com/articles/reviewing-proposed-changes-in-a-pull-request/) for useful instructions on how to initiate and submit reviews using GitHub's built-in tools
* To ensure reproducibility, you might find it useful to clone your classmate's repo and attempt to run their script(s). If you cannot execute them, then the code is not reproducible. Also be aware your classmates will hold you to a similar standard.

## How to do peer review bad

* Your review is so generic that it's hard to determine which assignment you're reviewing
* Your review is mean
* You can't find anything to praise/learn and yet you don't offer any suggestions either

Performing good peer review is difficult! In graduate school we are taught to criticize and tear down others' work and find the flaws. We need to be better at this and not just criticize, but highlight good aspects and suggest how to improve the work. This is still a habit I am struggling to break, so start working on it now before you leave grad school.

## Acknowledgments


* This page is derived in part from ["UBC STAT 545A and 547M"](http://stat545.com), licensed under the [CC BY-NC 3.0 Creative Commons License](https://creativecommons.org/licenses/by-nc/3.0/).
-->
