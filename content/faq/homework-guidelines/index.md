---
date: "2022-10-05T00:00:00-05:00"
weight: 20
title: "Homework guidelines"
toc: true
draft: true
type: book
aliases: ["/hw00_homework_guidelines"]
---

## Prerequisites

I assume [software is set up correctly](/setup/) and you can pull from and push to [GitHub from RStudio](/setup/git/git-with-rstudio/).

## Homework workflow

Homework assignments will be stored in private Git repositories managed by GitHub Classroom. Each of you will have one private repository per assignment.

A Git repository tracks and saves the history of all changes made to the files in the Git project. To complete a homework assignment, you need to:

* Accept the repo and clone it
* Make changes locally to the files from RStudio
* Save your changes
* Stage-Commit-Push: stage and commit your changes to your local Git repo; then push them online to GitHub. You can complete these steps using the Git GUI integrated into RStudio. Do not directly modify your online GitHub repo; instead modify your local Git repo, then stage-commit-push your changes up to your online GitHub repo. 

Review the [Using Git with R Studio](/setup/git/git-with-rstudio/) tutorial to get comfortable with this workflow. 

## Authoring Markdown files

Throughout this course, any basic text document should be written in [Markdown](http://daringfireball.net/projects/markdown/basics) and should always have a filename that ends in `.md`. These files are pleasant to write and read, but are also easily converted into HTML and other output formats. GitHub provides an attractive HTML-like preview for Markdown documents. 

Whenever you are editing Markdown documents in RStudio, you can display a cheat sheet by going to: "Help" tab > select "Markdown Quick Reference".

## Authoring R Markdown files

If your document is describing a data analysis, author it in [R Markdown](http://rmarkdown.rstudio.com), which is like Markdown, but with the addition of R "code chunks" that are runnable. The filename should end in `.Rmd` or `.rmd`. RStudio's "Knit HTML" button will compile the open document to actual HTML and open a preview.

Whenever you are editing Markdown documents in RStudio, you can display a cheat sheet by going to: "Help" tab > "Cheat Sheets" > select "R Markdown Cheat Sheet" or "R Markdown Reference Guide". A basic introduction to R Markdown can also be found in Chapter 27 of [R for Data Science](http://r4ds.had.co.nz/r-markdown.html)

## Which files to commit 

* Always commit the **main source document**, e.g., the R script or R Markdown or Markdown document. Commit early, commit often!
* For R Markdown source, also commit the intermediate Markdown (`.md`) file and any accompanying files, such as figures.
    * Some purists would say intermediate and downstream products do NOT belong in the repo. After all, you can always recreate them from source. But here in reality, it turns out to be incredibly handy to have this in the repo.
* Commit the **end product file**. For homework submissions this is generally the Markdown file (`.md`) because your output format is `github_document` as well as all the graphs generated from the code chunks. For other projects, this might be an HTML (`.html`) or PDF (`.pdf`) file.
* You may not want to commit the Markdown and/or HTML until the work is fairly advanced, maybe even until submission. Once these enter the repo, you really should recompile them each time you commit changes to the R Markdown source, so that the Git history reflects the way these files should evolve as an ensemble.
* **Never ever** edit the intermediate/output documents "by hand". Only edit the source and then regenerate the downstream products from that. For example, if your source is a R Markdown document, and your end product file is a html document: to modify the latter only edit the R Markdown and regenerate the html from there.

## Make your work shine!

Here are some tweaks that can make a big difference in how awesome your product is. They make your work and code easier to access and run

Please, perform the following steps before you submit your homework:

* Create a `README.md` **in the homework's main directory** to serve as the landing page for your submission. Whenever anyone visits this repo, this will be automatically rendered nicely. In particular, hyperlinks will work.

* With this `README.md` file, create **links** to the documents graders will need to access and provide some guidance for the reader. Such as:
    * Your main R Markdown document
    * The Markdown product that comes from knitting your main R Markdown document. Remember GitHub will render this into pseudo-HTML automagically. Remember the figures in `_files/` need to be available in the repo in order to appear

* In exactly one, very EARLY R code chunk:
  * **load any necessary packages** with `library()`, so your dependencies are obvious
  * **import anything coming from an external file**. This will make it easy for someone to see which data files are required, edit to reflect their locals paths if necessary, etc. There are situations where you might not keep data in the repo itself.

* In exactly one, very LAST R code chunk:
  * **report your session information** with  `sessioninfo::session_info()`. This prints version information about R, the operating system, and loaded packages so the reader knows the state of your machine when you rendered the R Markdown document. 

* Pretend you are someone else. Clone a fresh copy of your own repo from GitHub, fire up a new RStudio session and try to knit your R Markdown file. Does it "just work"? It should!

* Instead of just printing an object with R, you could format the info in a **table**. Some leads:
  * The `kable()` function from `knitr`.
  * Also look into the packages `xtable`, `pander`, `gt`.

<!--

An R chunk with `sessioninfo::session_info()` will produce something that looks like this:
    
    ```
    ## function (pkgs = c("loaded", "attached", "installed")[1], include_base = FALSE, 
    ##     info = c("auto", "all", "platform", "packages", "python", 
    ##         "external"), dependencies = NA, to_file = FALSE) 
    ## {
    ##     if (missing(info)) 
    ##         info <- "auto"
    ##     choices <- c("platform", "packages", "python", "external")
    ##     if (info != "auto" && info != "all") {
    ##         info <- match.arg(info, choices, several.ok = TRUE)
    ##     }
    ##     if ("all" %in% info) {
    ##         info <- choices
    ##     }
    ##     else if ("auto" %in% info) {
    ##         info <- c("platform", "packages", if (should_show_python(pkgs)) "python")
    ##     }
    ##     stopifnot(is_flag(to_file) || is_string(to_file))
    ##     if (is_flag(to_file) && to_file) 
    ##         to_file <- "session-info.txt"
    ##     si <- structure(drop_null(list(platform = if ("platform" %in% 
    ##         info) platform_info(), packages = if ("packages" %in% 
    ##         info) {
    ##         package_info(pkgs, include_base = include_base, dependencies = dependencies)
    ##     }, external = if ("external" %in% info) external_info(), 
    ##         python = if ("python" %in% info) python_info())), class = c("session_info", 
    ##         "list"))
    ##     if (is_string(to_file)) {
    ##         old <- options(cli.num_colors = 1)
    ##         on.exit(options(old), add = TRUE)
    ##         writeLines(format(si), to_file)
    ##         invisible(si)
    ##     }
    ##     else {
    ##         si
    ##     }
    ## }
    ## <bytecode: 0x0000000013eb95d0>
    ## <environment: namespace:sessioninfo>
    ```
{{< tweet 464132152347475968 >}}

These steps reduce the friction for graders to get the hard-working source code (the `.R` or `.Rmd` file) **and** the front-facing report (`.md` or `.html`).

-->


## Acknowledgments


* This page is derived in part from ["UBC STAT 545A and 547M"](http://stat545.com), licensed under the [CC BY-NC 3.0 Creative Commons License](https://creativecommons.org/licenses/by-nc/3.0/).

* This page has been developed starting from Benjamin Soltoff’s “Computing for the Social Sciences” course materials, licensed under the CC BY-NC 4.0 Creative Commons License.
