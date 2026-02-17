# Getting Started in R

This guide is intended to help you get oriented with **how R works**, **why we use it**, and **where to start learning**, regardless of your prior programming experience.

## Why R?

R is one of the primary programming languages used for data analysis, modeling, and reporting. It is especially strong when working with structured datasets, producing reproducible analysis, and communicating results clearly through tables, charts, and reports.

R is also open source, meaning it is free to use and supported by a large, active community. This community continuously develops new packages, documentation, and learning materials, making R easier to learn and more powerful over time.

## Transitioning from SAS to R

Many analysts at DOF come to R with a background in SAS. While the syntax and workflows may differ, the underlying analytical concepts—importing data, joining tables, transforming variables, fitting models—are largely the same. The biggest shift is moving from a **step-based, procedural mindset** to a more **object-oriented and functional** one.

If you are comfortable in SAS, you will likely find R easier to pick up than it initially appears—the learning curve is mostly about syntax and workflow patterns, not new analytical concepts.

### SAS → R Mental Map

It can be helpful to think in terms of how familiar SAS concepts translate into R workflows. The table below is not meant to be a one-to-one syntax guide, but rather a conceptual map to help orient your thinking.

| SAS Concept | How to Think About It in R |
|------------|----------------------------|
| `DATA` step | Create or transform a data object using functions (often with `dplyr`) |
| `PROC SORT` | Sort a dataset using functions like `arrange()` |
| `PROC MEANS` / `PROC SUMMARY` | Compute summaries using functions like `summarise()` |
| `PROC FREQ` | Frequency tables using `count()` or `table()` |
| `PROC SQL` | Data joins and aggregation using `dplyr` or SQL via database connections |
| `WORK` datasets | datasets are objects in memory (basically: named things you can refer back to) |
| Permanent SAS datasets | Explicitly saved files (e.g., `.xlsx`, `.csv`) |
| Macros | User-defined functions |
| `PROC REG` | Linear models using the package `lm()` |
| `PROC LOGISTIC` | Logistic regression using the package `glm()` |
| ODS output | Integrated reporting via R Markdown or Quarto |
| SAS libraries | Packages or database connections |

A few high-level differences to keep in mind:

- **Data steps vs. objects**  
  In SAS, data is often modified through sequential `DATA` and `PROC` steps. In R, datasets are objects in memory, and transformations typically create new objects rather than modifying data in place (unless explicitly done).

- **Procedures vs. functions**  
  SAS relies heavily on `PROC`s that perform standardized tasks. In R, similar functionality is provided through functions from packages (e.g., `dplyr`, `ggplot2`, `lm`), which can be composed and chained together.

- **One dataset at a time vs. pipelines**  
   R workflows often use pipelines (written with `%>%`) that allow you to write transformations in a clear, top-to-bottom sequence, making it easier to see how raw data becomes a final result. For example, instead of importing, renaming columns, creating new columns, joining with other data, and sorting in different steps, you can "pipe" them together.

### Side-by-side examples

For comprehensive lists of these types of comparisons, take a look at this [SAS to R guide](https://github.com/asnr/sas-to-r) or this guide on the transition between [SAS and R syntax](https://bayer-group.github.io/sas2r/r-and-sas-syntax.html). 

Below are a few common tasks shown side by side. The R examples use a popular style called the *tidyverse*, which emphasizes readable, step-by-step data transformations using the "pipe" (`%>%`).


#### Reading and Transforming a Dataset

**SAS**
```sas
data sales_clean;
  set sales;
  revenue = price * quantity;
  if revenue > 1000;
run;
```

**R**
```r
sales_clean <- sales %>%
  mutate(revenue = price * quantity) %>%
  filter(revenue > 1000)
```

#### Summary Statistics

**SAS**
```sas
proc means data=sales_clean;
  class region;
  var revenue;
run;
```

**R**
```r
sales_clean %>%
  group_by(region) %>%
  summarise(mean_revenue = mean(revenue, na.rm = TRUE))
```

## Getting set up

In order to start programming in R on your own, you need a few pieces of software installed on your machine. To get started, submit a [HelpDesk ticket](https://cwitservice.nyc.gov/sp) to download both **R** and **RStudio**:

- **R** is the programming language itself. It contains all the tools needed to perform calculations, manipulate data, and build models. Think of R as the engine that runs your analysis.  

- **RStudio** is an Integrated Development Environment (IDE) for R. It provides a user-friendly interface where you can write and run R code, view plots, manage datasets, and organize your projects in one place. Using RStudio is much easier than trying to run R from a command-line console alone.

Once installed, you will use RStudio to write scripts, explore data, and create reports. The first time you open RStudio, you’ll see panels for writing code, viewing outputs, plotting charts, and navigating files — all designed to help you work efficiently in R.

Navigate to a desktop request by clicking on `Request something new` and then `Desktop Request`. Your screen should look like the following:

![alt text](resources/desktop_request.png)

Under `Specify what is being requested`, include the following:
```
I need to install the latest version of R (https://cran.rstudio.com/) and RStudio Desktop (https://posit.co/download/rstudio-desktop/) on my local machine. Thank you!
```

Press `Submit`. This might take a few days, but IT should get back to you shortly.

## Learning the Basics of R / RStudio

While you wait for your software to be installed on your machine, you can start getting up to speed with how R works and how to use it.

### LinkedIn Learning

As of 1/2026, all DOF employees have access to LinkedIn Learning resources via an agency-wide license. To get set-up with LinkedIn Learning, do the following:
- Go to https://www.linkedin.com/learning and sign in with your DOF email
- Once you are signed in, you should be able to access [Introduction to R Programming](https://www.linkedin.com/learning/collections/7424571820374351873?u=2208145), a collection of trainings that I picked out that I think are the most helpful. I'd recommend the following trainings (more or less in this order, if you are new to git/github):
    - R for Data Science: Analysis and Visualization (beginner)
    - Data Wrangling in R (beginner)
    - Data Visualization in R with ggplot2 (beginner)
    - Creating Maps with R (intermediate)

### Additional Resources

If you are outside of DOF (or inside of DOF and want additional materials to help you get started), the following materials will help you learn the basics, get a sense of modeling options, and provide extensive documentation for the most used packages in R.

#### Introduction to R

- **Introduction to R (DataCamp)**  
  https://app.datacamp.com/learn/courses/free-introduction-to-r  
  Very beginner-friendly and walks through basic syntax, assignments, and data types.

- **Introduction to the tidyverse (DataCamp)**  
  https://www.datacamp.com/courses/introduction-to-the-tidyverse  
  Introduces the core set of R packages commonly used for data analysis (dplyr, ggplot2, etc.) and covers typical data wrangling tasks and basic visualization.

- **R for Data Science**  
  https://r4ds.had.co.nz/introduction.html  
  A comprehensive, self-paced book written by one of the main R developers. This is one of the most commonly recommended R resources and is useful both for beginners and as an ongoing reference.  
  Exercise solutions are available here:  
  https://ui-research.github.io/r4ds-exercises/index.html

- **Urban Institute – Intro to R**  
  https://urbaninstitute.github.io/r-at-urban/intro-to-r.html  
  A very high-level overview of how R works, what RStudio is, and how analysts typically use them together.

####  Modeling in R

R has a long history in statistical modeling, and many modeling workflows at DOF rely on standard R packages and conventions. The resources below focus on how models are specified, interpreted, and used in practice.

- **Tidy Modeling with R**  
  https://www.tmwr.org/ames  
  A practical introduction to modeling workflows in R, including how to work with model objects and results.

- **Mixed Models in R**  
  https://m-clark.github.io/mixed-models-with-R/random_intercepts.html  
  A clear explanation of hierarchical and mixed-effects models, with intuitive examples.

- **Splines in R**  
  https://bookdown.org/ssjackson300/Machine-Learning-Lecture-Notes/splines.html  
  A helpful explanation of splines and how they are implemented in R modeling workflows.

####  Essential Reference Materials

These are resources you will likely come back to repeatedly as you work in R:

- **R for Data Science**  
  https://r4ds.had.co.nz/introduction.html  
  An essential reference for data analysis workflows in R.

- **Introduction to Data Exploration and Analysis with R**  
  https://bookdown.org/mikemahoney218/IDEAR/  
  Another introductory book with a particularly strong chapter on modeling.

- **R Packages**  
  https://r-pkgs.org/  
  A practical guide to building and maintaining R packages. This resource was foundational for developing internal packages like `assessNYC`.


That's it for now. Enjoy getting started in R!