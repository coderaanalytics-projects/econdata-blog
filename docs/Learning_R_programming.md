# How to learn R (the programming language)

[R](https://en.wikipedia.org/wiki/R_(programming_language)) is a [middle-level](https://en.wikipedia.org/wiki/High-level_programming_language) programming language that is well-designed for handling and analysing data, data visualization, and statistics. Python is more designed for advanced apps, and for machine learning, in comparison to R.

The two main factors when deciding how to learn R are costs and personal motivation, and there is often a trade-off between the two, but we have some recommendations for the most optimal choices. Unless you are a savant, we also think that interactivity is important when learning. Below, we describe our recommendations in order, with our highest recommended choice first.

## Swirl

The main reason why we recommend the `swirl` package in R so highly is because this option is totally free. Once you install R on your computer (and hence immediately become familiar with the real-life programming environment), and install the `swirl` package in an R session, you can start a `swirl` session. When `swirl` is running, you work through open-source, pre-scripted courses that are interactive. The computer waits until you have typed in answers correctly in the console before moving on to the next description or question, and you press "Enter" in order to progress through the content. You can find free `swirl` courses on the internet and download them; instructors write `swirl` courses in order to offer free guidance to those learning R, and the courses can be distributed widely. We recommend some popular courses to get started with.

### Installing R

1.  Firstly, go to https://cloud.r-project.org/ and install the R language onto your computer.
2.  Secondly, go to https://posit.co/downloads/ and install RStudio. This integrated development environment (IDE) is commonly used by R programmers and is specifically designed for the R language.<br/>
An IDE is a computer program that programmers use to write programming code, and IDEs usually do not restrict a programmer to writing in one specific language (although they sometimes are only designed for one language). That being said,
3.  Go to https://code.visualstudio.com/download and install VS Code. VS Code is a free IDE that is popular and has a lot of features, including extensions. Check out the [documentation for using R in VS Code](https://code.visualstudio.com/docs/languages/r). It is quite easy to develop code using an advanced IDE such as VS Code. VS Code can be used for Python and a variety of other languages as well. After this step though, we'll focus on RStudio as that is a better way to be introduced to R for those unfamiliar with the language.
4.  Open RStudio, make sure that you have a fast internet connection, and type the following lines into the console, waiting for the computer to run the commands each time:

        install.packages("tidyverse")
        install.packages("swirl")
        install.packages("devtools")
        library("devtools")
        install_github("coderaanalytics/econdatar")   # If you haven't already installed Codera's EconData R package
        library("tidyverse")
        library("swirl")
        install_course("R_Programming")
        install_course_github("NickCH-K", "Econometrics") 

    Note that the free "R_Programming" swirl course comes from https://github.com/swirldev/swirl_courses#swirl-courses . If you are stuck, you can [meet Aidan](https://calendly.com/aidan-horn/r-tutoring).

5.  Since you have already run the `library("swirl")` command, you have `swirl` loaded into your current R session. Go ahead and type `swirl()` to start a `swirl` session. 
6.  <font size="5">Choose the **R_Programming** course to start with! </font> Follow the on-screen prompts to get learning.
7.  Carry on frequently returning to your `swirl` learning over the following days and weeks. The "Econometrics" course downloaded above is also a good course to work on after you complete the "R_Programming" course.

## DataCamp

Our second-place recommendation is [www.DataCamp.com](https://app.datacamp.com/learn/skill-tracks/r-programming). This is because DataCamp is actually relatively cheap compared to academies with tutors and scheduled classes (which can cost several thousand rand for only about two months). In comparison, DataCamp only costs about R500 per month, making it much more cost-efficient than many online courses.

The tutorials on DataCamp are a great introduction to R (and Python or SQL). They are interactive, go at your pace, and the user experience of the app looks good. The tutorials are packaged into organised series making up courses and then series of courses make up certificates.

The difficulty of online courses is that one's motivation is mostly internal. Try to find developer friends who can hold you accountable (you can share your public DataCamp profile with them) and who can encourage you to carry on working hard. Developer friends can help out with questions you get stuck on, but the DataCamp courses provide a clear structure for learning material for beginners.

## MITx MicroMasters course: [Data Analysis for Social Scientists](https://mitxonline.mit.edu/courses/course-v1:MITxT+14.310x/)

The [outline](https://mitxonline.mit.edu/courses/course-v1:MITxT+14.310x/) reads:
> This statistics and data analysis course will introduce you to the essential notions of probability and statistics. We will cover techniques in modern data analysis: estimation, regression and econometrics, prediction, experimental design, randomized control trials (and A/B testing), machine learning, and data visualization. We will illustrate these concepts with applications drawn from real world examples and frontier research. Finally, we will provide instruction for how to use the statistical package R and opportunities for students to perform self-directed empirical analyses.

## Udemy

We recommend using https://www.udemy.com/ to take an online course on R.

## R Project Manual

The R Project for Statistical Computing provides [this comprehensive manual](https://cran.r-project.org/doc/manuals/r-release/R-intro.html) and [these FAQs](https://cran.r-project.org/doc/FAQ/R-FAQ.html).

## Advanced R courses

Please read the [Tidyverse Style Guide](https://style.tidyverse.org/).

To learn advanced R style... (we are busy investigating this question).


# Other programming languages

## Web Development

If you want to learn web development, be sure to use  https://developer.mozilla.org/en-US/docs/Learn as a reference.

### Codecademy

https://www.codecademy.com/ 

(e.g. https://www.codecademy.com/learn/introduction-to-javascript )

## Explore AI Academy (Python)

In order to learn Python, a fairly expensive option could be to take a course with [Explore AI Academy](https://admissions.explore.ai/).


# Writing

[*Markup*](https://en.wikipedia.org/wiki/Markup_language) languages are defined in Wikipedia as:
> a text-encoding system consisting of a set of symbols inserted in a text document to control its structure, formatting, or the relationship between its parts. Markup is often used to control the display of the document or to enrich its content to facilitate automated processing.

MS Word is not necessary in order for computer-literate people to do work, as one can either use:
1.  .txt documents, for basic notes
2.  Markdown documents, for most note-taking and documentation
3.  Google Docs, for widely-accepted collaboration
4.  LibreOffice, an open-source and free suite of software akin to Microsoft Office
5.  LaTeX, for lengthy or precise documents.
6.  R Markdown

A [Microsoft 365 subscription](https://www.microsoft.com/en-za/microsoft-365/buy/microsoft-365) is thus not necessary, and it is expensive. Perhaps in future people will come to realise that the above options are usable.

## Philosophy on Microsoft Office

**Aidan says:** One last question I am facing regarding this philosophy is that data needs to be exported to spreadsheets often, and Excel seems to be easier to write to compared to .ods files. Perhaps R could export to Google Sheets if I look into it. Note that Excel is **definitely** not needed for data visualization, as `ggplot2` in R provides a much more robust, iterable and automatable way of generating graphs.


## Markdown

Please use VS Code to edit Markdown files, refer to https://www.markdownguide.org/ for documentation, and preview Markdown files using [Typora](https://typora.io/).

Markdown files can be [exported to a variety of formats using Typora](https://support.typora.io/Export/), including PDF, HTML, Word, LaTeX, Epub, OpenOffice, image, Wiki. Markdown files also render on a lot of websites, including those that host Git repositories, or cloud storage services.


## LaTeX

LaTeX is a markup language, intended to produce scientific documents, reports, academic articles, or any neat, professional-looking document. It is a word processor that gives one precise control over the processing of reports, and is able to handle the management of reports that run into hundreds of pages. A LaTeX document can be collaborated on using Git, or Overleaf. LaTeX (or even LyX) allows one to automate reports, pulling in images and tables from the directory, which can be updated by software. [Aidan's online introductory paragraphs on LaTeX.](https://eco5011f.aidanhorn.co.za/coding#h.t5dwrgjqz6bg) 

LaTeX files export the document to PDF format. We recommend [SumatraPDF](https://www.sumatrapdfreader.org/) as the PDF viewer, as that lets one recompile the PDF file while it is still being previewed. One can also create slideshow presentations using LaTeX (usually by using the `beamer` package). So, when presenting a PDF presentation, go into full-screen mode in Adobe Acrobat by pressing Ctrl + L.


## R Markdown

R Markdown (.Rmd files) can also facilitate automation of reports: RStudio can export the file to HTML, Word, or PDF (using pandoc, through LaTeX). The PDF version of R Markdown is thus a dumbed-down version of LaTeX, which uses Markdown language.

R code chunks can be run in an R Markdown file, running analysis and producing graphs or tables to be exported directly into the document. The disadvantage of this is that it can be difficult to debug errors, as the error information isn't clear when using R Markdown, but the main advantage is that descriptive statistics can be re-run on an automated basis, once bugs are cleared.

YAML is used in the document heading.


# Git

Git is software that creates a central repository for programming code, when developers work together on a project. It is not intended to be used to store large amounts of data, but rather to help with observing changes to lines within programming scripts. A remote (centralized) git repository can be on a local server, but usually developers use GitHub, GitLab, or another online server to host the remote repository. Here are the beginning steps to getting started with Git:
1.  Install Git
1.  Make sure that you have VS Code installed (or an alternative IDE)
1.  Install GitHub CLI
1.  Have a GitHub account

[Aidan's introductory Medium article](https://aidanhorn.medium.com/learning-git-766a4e2477d8)

Always make sure you open a Git Bash terminal, and run `git fetch; git status`, before staging and committing your work. If your branch is not up-to-date with the remote, see if you can fast-forward your local repo, by running `git pull`. This will help there to be a linear history, which is neater. 


# Careers

Programmers can find a job on [OfferZen](https://www.offerzen.com/z/clpoRY).

