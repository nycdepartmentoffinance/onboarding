# Onboarding

Welcome to GitHub at DOF!

This repository is your starting point for working with DOF code and data. Most projects here rely on **Git/GitHub for version control** and are written primarily in **R or Python**, often with connections to internal databases and services behind the DOF network proxy.

Not sure where to start? Jump to [where to start](#where-to-start).

## Programming at DOF

The sections below are organized to first cover **how we use GitHub**, then **how to get productive in R or Python** once your environment is set up.

### Git & GitHub at DOF

These guides cover how we use GitHub day-to-day, from initial setup to common workflows and repository standards.

- [GitHub Set-up](github_setup.md)
- [GitHub Workflow](github_workflow.md)
- [Repository Best Practices](github_repository_bestpractices.md)

### Programming Environments

Most DOF projects on GitHub are largely developed in either **R** or **Python** (free, open source langauges). The guides below walk through initial set up, configuring your environment to work with the DOF proxy, setting up new projects, and connecting to databases.

#### R

- [Getting Started in R](getting_started_R.md)
- [Proxy Set-up in R](proxy_R.md)
- [Project Set-up in R](project_setup_R.md)
- [Database Connections in R](database_connections_R.md)

#### Python

- [Getting Started in Python](getting_started_python.md)
- [Proxy Set-up in Python](proxy_python.md)
- [Project Set-up in Python](project_setup_python.md)
- [Database Connections in Python](database_connections_python.ipynb)

## Where to start

If you are new to programming or programming in this way, that's okay! These guides are here to help make getting started as intuitive as possible (even though it can seem like a lot).

In terms of where to start, we'd recommend the following:
- Read through the [github setup guide](github_setup.md) to get a broad sense of how this works and then practice by doing some of the LinkedIn Learning courses linked at the top of the guide.
- Pick a programming language - you can always come back and change your mind, but decide which langauge (R or python) you'd like to start working in first. In terms of how to decide, here are a few considerations between the two:
  - **R**: R is especially well-suited for data analysis, statistics, and reporting. It shines when working with tabular data, exploratory analysis, and producing reproducible outputs like reports, tables, and charts (often via R Markdown or Quarto). Many DOF projects that focus on analysis, policy research, or recurring reports are written in R. At property modeling, we have also developed a custom (internal) R package called assessNYC to help us with more repititive/cumbersome tasks so if you are modeling it might be helpful to use that as a resource. 
  - **Python**: Python is a general-purpose language that works well for data processing, automation, and building applications or pipelines. The benefit of python is that it can do all that R can do (it's a powerful data analysis tool), but it can also be used to build custom web apps, automate workflows, and is a lot more of a flexible language (e.g. you can use object-oriented programming). That said, there may be a slightly higher learning curve with learning python over R (especially for programmers more familiar with data analysis languages like SAS).

- Read the relevant getting started guide ([R](getting_started_R.md), [python](getting_started_python.md)) for that programming langauge, which will include downloading the correct software (R, python) and programming environment (RStudio for R, VSCode for python). 
  - Before you move to the proxy set-up step (given that it might take a few days for IT to install the relevant software), I'd recommend checking out LinkedIn Learning courses in your relevant programming language (described in each of the getting started guides).
- Once you have R/RStudio or Python/VSCode installed, the next very important step is to follow the relevant proxy guide to make sure that your proxy server connection is set up correctly (the instructions outline in detail how to do that). Don't be discouraged if this takes you a little while - it's an annoying step but will pay off in reducing the headaches you have later.
- Now that you have a sense of both git and the basics of a programming language, let's start to see how they work together:
  - Use the terminal within your programming environment (RStudio or VSCode) to clone [any github repository](https://github.com/orgs/nycdepartmentoffinance/repositories) available in the DOF github organization. This is how you can collaborate with existing work.
  - Next, create your own repository and start a new project using the project set-up guides. If you want to play around with static data in CSVs you already have, great. If you want to pull data directly from an Oracle or SQL Server database, follow the database connection guides to establish connections to one or more databases you want to pull data from and experiment with the data that way.

  If you have any questions as you get set up, don't hesitate to reach out to boydclaire@finance.nyc.gov - I'd be happy to help.





