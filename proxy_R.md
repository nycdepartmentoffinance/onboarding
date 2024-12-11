# Proxy Set-up in R

Once you have an R project up and running, you'll need to do a few things to make sure that your project is configured correctly to connect to the internet and can connect to our DOF databases correctly and securely.

To make this easy, R projects load in two different files `.renviron` and `.rprofile` every time a new R session starts. We can use these files to configure our settings so that our session is always configured correctly.

## .renviron
To do this, first create an `.Renviron` file by doing the following in the terminal (not console):
```
touch .Renviron
```
Then, open the file and copy and paste the following into it:
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

## .rprofile

Next, we need to save some settings to the `.Rprofile` file in order to work properly on the DOF Windows machines. Create the `.Rprofile` file by doing the following (if it is not already created).

```
touch .Rprofile
```

Open the file and add the following lines :
```
# existing lines because I already activated renv for this project
source("renv/activate.R")

# additional lines for proxy set-up
options(timeout=1000)
options(download.file.method = "wininet")
```

Now, once you restart your R session, you should be all set up with the proxy. 
