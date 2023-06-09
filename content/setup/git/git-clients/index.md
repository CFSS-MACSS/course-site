---
date: "2022-09-25T00:00:00-05:00"
draft: false
weight: 30
title: "Git clients"
toc: true
type: book
aliases: ["/git02.html", "/setup/git-clients/"]
---



You can use Git for version control through the command line or through a Git client. For the first option, see [What is the Shell?](/setup/shell). Here we are going to focus on Git clients.

Learning how and why to use Git can be rough. Therefore, using a client, rather than the command line, is usually helpful when getting started. Most clients help you interface with Git and GitHub through a user-friendly Graphical User Interface (GUI), but they still perform the same underlying Git commands that you would perform through the command line.

Git and a Git client are not the same thing, just like R and RStudio are not the same thing. A Git client and the RStudio are not necessary to use Git or R, but they make the experience more pleasant by reducing the steep learning curve.

RStudio incorporates a basic Git client. For simple operations such as committing and pushing changes to GitHub, this will be sufficient. We will be using the RStudio Git client in this course, which does not require further installation -- just check everything works as expected by following the [Using Git within RStudio](/setup/git/git-with-rstudio/) instructions.

Once you start collaborating with other users, managing multiple branches in the same project, and performing complex merges, you will want another, more powerful Git client. At that point, it is also helpful, and sometimes necessary, to know how to use the command line. 

Because all Git clients are just forming and executing Git commands on your behalf, you don't have to pick a specific one. You can literally do one operation from the command line, do another from RStudio, and another from your Git client, one after the other, and it just works. Very rarely, both clients will scan the repo at the same time and you’ll get an error message about `.git/index.lock`. Try the operation again at least once before doing any further troubleshooting.

## Recommendations for Git clients

Many users rely on the free [GitHub client](https://desktop.github.com/) for Windows and Mac.  However, the GitHub client offers lots of hand-holding. Perhaps too much. It also cannot handle complex Git operations, and installation of the GitHub client also includes a version of Git that does not play nicely with default settings. In addition, because it is intended to work with Git repositories hosted on GitHub, if you ever decide to share your repositories using an alternative hoster the GitHub client does not play nicely with outsiders.

<!--
However in researching recommended Git clients, I have [heard](http://stat545.com/git02_git-clients.html) [negative](https://www.slant.co/topics/2089/~git-clients-for-windows) [reviews](http://softwarerecs.stackexchange.com/questions/1308/what-is-a-good-newbie-friendly-graphical-git-client-for-windows) about this client.
-->

If you want to use a Git client, here are some options to consider:

* [SourceTree](https://www.sourcetreeapp.com/) - the pros are that it is free, multi-platform (Mac and Windows only, sorry Linux), powerful, and has a great GUI design. Some would complain that it is perhaps too powerful and its interface is overly complicated.
* [GitKraken](https://www.gitkraken.com/) - like SourceTree, GitKraken is free, powerful, and gets kudos for a great GUI layout. Unlike SourceTree, GitKraken is available across all major operating systems (Windows, Mac, and Linux).
* [TortoiseGit](https://tortoisegit.org/) (Windows)
* [SmartGit](http://www.syntevo.com/smartgit/) (Windows, Mac, and Linux - free for non-commercial use only)
* [GitUp](http://gitup.co/) (Mac only)
* [Even more choices](https://git-scm.com/downloads/guis)

## Acknowledgments


* This page is derived in part from ["UBC STAT 545A and 547M"](http://stat545.com), licensed under the [CC BY-NC 3.0 Creative Commons License](https://creativecommons.org/licenses/by-nc/3.0/).

* This page has been developed starting from Benjamin Soltoff’s “Computing for the Social Sciences” course materials, licensed under the CC BY-NC 4.0 Creative Commons License.
