# Proxy Set-up in R

Once you have an R project up and running, you'll need to do a few things to make sure that your project is configured correctly to connect to the internet and can connect to our DOF databases correctly and securely.

To make this easy, R projects load in two different files `.renviron` and `.rprofile` every time a new R session starts. We can use these files to configure our settings so that our session is always configured correctly.

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
