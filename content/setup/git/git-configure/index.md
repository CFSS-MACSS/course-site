---
date: "2022-09-27T00:00:00-05:00"
draft: false
weight: 40
title: "Configure Git"
toc: true
type: book
aliases: ["/git07.html", "/setup/git-configure/"]
---



{{% callout note %}}

If you are configuring Git on your own computer, run the following code in the R console to ensure you have the required packages installed (you should not need to run it if you are using R Workbench):

```r
install.packages(c("usethis", "gitcreds", "gh"))
```

{{% /callout %}}

To ensure minimal challenges using Git during the class, we want to configure Git now with some default settings. **You only have to do this once per machine.**


# Identify yourself

In order to track changes and attribute them to the correct user, we need to tell Git your name and email address. Run the following commands from the R console:

```r
usethis::use_git_config(user.name = "Jean Clipperton", user.email = "email@gmail.com")
```

Replace `Jean Clipperton` and `email@gmail.com` with your name and email address. Your name could be your GitHub username, or your actual first and last name. **Your email address must be the email address associated with your GitHub account.**

To check that Git got your credentials, in R Studio go to Tools > Shell and run the following command in the shell/terminal tab that opened up:

```r
git config --global --list
```


# Cache credentials

In order to push changes to GitHub, you need to **authenticate** yourself. That is, you need to prove you are the owner of your GitHub account. When you log in to GitHub.com from your browser, you provide your username and password to prove your identity. But when you want to push and pull from your computer, you cannot use this method. Instead, you will prove your identity using one of two methods.


## Cache credentials for SSH

{{% callout note %}}

If you are using the [R Studio Workbench](/setup/r-server/) for the class, you will need to use SSH. The server does not have the ability to cache your personal access token for HTTPS.

{{% /callout %}}

The **Secure Shell Protocol** (SSH) is another method for authenticating your identity when communicating with GitHub. While a password can eventually be cracked with a brute force attack, SSH keys are nearly impossible to decipher by brute force alone. Generating a key pair provides you with two long strings of characters: a public and a private key. You can place the public key on any server (like GitHub), and then unlock it by connecting to it with a client that already has the private key (your computer or RStudio Serve). When the two match up, the system unlocks without the need for a password.

The URL for SSH remotes looks like `git@github.com:<OWNER>/<REPO>.git`. Make sure you use this URL to clone a repository. If you accidentally use the HTTPS version, the operation will not work (if that happens, go back and generate a SSH cache credential).


### Create and store an SSH key pair

Run the following code in the R console:

```r
credentials::ssh_setup_github()
```

<!--
new line of command cis-ds
```r credentials::ssh_keygen() ```
-->


* You will be prompted to generate a new SSH key. Tell the computer yes
* You will see a long string of characters in the console and be asked to open a browser now. Say yes, then copy and paste the public key (the whole line of text) into the resulting browser window on GitHub. If you do not have a GitHub account, please register a free GitHub account before proceeding, see [here](https://computing-soc-sci.netlify.app/setup/#for-both-options) for info
* Give the key an informative title, something like `css-rstudio-server` or `css-rworkbench-fall22` to record the class and computer. Leave Key type as "Authentication Key" 
* Click the green button "Add SSH key". If you are prompted to type your GitHub password, do so.



## Cache credentials for HTTPS

{{% callout note %}}

If you are running R and Git on your personal computer, I recommend this method. However, if you are using R Workbench, please authenticate with the SSH method below

{{% /callout %}}

With this method you will clone repositories using a regular HTTPS url like `https://github.com/<OWNER>/<REPO>.git`. You will need a **personal access token** (PAT) and use that as your credential for HTTPS operations.

### Get a PAT

Run this code from your R console:

```r
usethis::create_github_token(
  scopes = c("repo", "user", "gist", "workflow"),
  description = "RStudio Workbench"
)
```

This is a helper function that takes you to the web form to create a PAT.

- Give the PAT a description (e.g. "PAT for Computing for Information Science")
- Change the **Expiration** to 90 days. This ensures the PAT remains valid through the end of the course. You can also set the token to never expire, but GitHub will warn you this is not as secure as an expiring token.
- Leave the remaining options on the pre-filled form selected and click "Generate token". As the page says, you must **store this token somewhere**, because you'll never be able to see it again, once you leave that page or close the window. For now, you can copy it to your clipboard (we will save it in the next step).

If you lose or forget your PAT, just generate a new one.

### Store your PAT

In order to store your PAT so you don't have to reenter it every time you interact with Git, we need to run the following code:

```r
gitcreds::gitcreds_set()
```

When prompted, paste your PAT into the console and press return. Your credential should now be saved on your computer.

### Confirm your PAT is saved

Run the following code:

```r
gh::gh_whoami()

usethis::git_sitrep()
```

You should see output that provides information about your GitHub account.

Now that you have stored your PAT, you should not be asked to provide a username and password when you attempt to push to or pull from GitHub. It will just work! Hopefully.


# Acknowledgments


* This page is derived in part from ["UBC STAT 545A and 547M"](http://stat545.com), licensed under the [CC BY-NC 3.0 Creative Commons License](https://creativecommons.org/licenses/by-nc/3.0/).

* This page has been developed starting from Benjamin Soltoff’s “Computing for the Social Sciences” course materials, licensed under the CC BY-NC 4.0 Creative Commons License.
* [*Happy Git and GitHub for the useR*](https://happygitwithr.com/)
