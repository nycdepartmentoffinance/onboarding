# Proxy Set-up in R

Once you have an R project up and running, you'll need to do a few things to make sure that your project is configured correctly to connect to the internet and can connect to our DOF databases correctly and securely.

To make this easy, R projects load in two different files `.renviron` and `.rprofile` every time a new R session starts. We can use these files to configure our settings so that our session is always configured correctly and we don't need to customize requests to use the proxy everytime.

## .renviron
To do this, first create an `.Renviron` file by doing either of the following options: (A) using the user interface of RStudio by clicking "File", "New File", "R Script", and then saving the Untited file as ".Renviron" or (B) writing the following in the R console:
```
file.create(".Renviron")
```

Then, in the newly created `.Renviron` file, copy and paste the following into it:
```
http_proxy = "bcpxy.nycnet:8080"
http_proxy_user = user_id:password
https_proxy = "bcpxy.nycnet:8080"
https_proxy_user = user_id:password
```

This saves the above as environmental variables that are used when configuring the R session. 

Note: this is a great file to use to save other usernames and passwords that you want to use in your project and want to avoid hard coding them into the scripts. For example, I have the following saved in my .renviron file
to use as needed for any given project:
```
http_proxy = "bcpxy.nycnet:8080"
http_proxy_user = user_id:password
https_proxy = "bcpxy.nycnet:8080"
https_proxy_user = user_id:password

#github info
#GITHUB_PAT=###############

# SAS database connections

fdw_username=###############
fdw_password=###############
fdw_path=###############
fdw_schema=###############

pts_username=###############
pts_password=###############
pts_path=###############
pts_schema=###############

# SQL Server database connections

test_server=###############
test_user=###############
test_password=###############

production_server=###############
production_username=###############
production_password=###############

#NYC OPEN DATA API CREDENTIALS
keyID=###############
keysecret=###############
```

Whenever I need any of the above in a Rproj, I can use the following syntax in base R to retrieve them:
```
Sys.getenv("fdw_username")
```

**REALLY IMPORTANT NOTE**

This file should not be added to your github repository. It should stay as a local file that only you should have access to. Your `.gitignore` file should have `.renviron` listed already (by setting up the Rproj and repository in github), but if it doesn't already, then you can add it.

Because I used the github default R .gitignore file, here is what it looks like. You'll see that .Renviron is included on line 40 so when you `git add .` it will still stay untracked by git.
```
# History files
.Rhistory
.Rapp.history

# Session Data files
.RData
.RDataTmp

# User-specific files
.Ruserdata

# Example code in package build process
*-Ex.R

# Output files from R CMD build
/*.tar.gz

# Output files from R CMD check
/*.Rcheck/

# RStudio files
.Rproj.user/

# produced vignettes
vignettes/*.html
vignettes/*.pdf

# OAuth2 token, see https://github.com/hadley/httr/releases/tag/v0.3
.httr-oauth

# knitr and R markdown default cache directories
*_cache/
/cache/

# Temporary files created by R markdown
*.utf8.md
*.knit.md

# R Environment Variables
.Renviron

# pkgdown site
docs/

# translation temp files
po/*~

# RStudio Connect folder
rsconnect/
```


## .rprofile

Next, we need to save some settings to the `.Rprofile` file in order to work properly on the DOF Windows machines. Create the `.Rprofile` file by repeating the above instructions  with ".Rprofile" instead of ".Renviron".

Open the file and add the following lines :
```
# existing lines because I already activated renv for this project
source("renv/activate.R")

# additional lines for proxy set-up
options(timeout=1000)
options(download.file.method = "wininet")
```

Now, once you restart your R session, you should be all set up with the proxy. 
