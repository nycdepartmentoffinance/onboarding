# Proxy Set-up in R

To use the proxy, you'll need to do a few things to make sure that your R sessions are configured correctly to connect to the internet and can connect to our DOF databases correctly and securely.

To make this easy, RStudio loads in two different files `.renviron` and `.rprofile` every time a new R session starts. 
We can use these files to configure our settings so that our session is always configured correctly and we don't need to customize requests to use the proxy everytime.

## Creating an `.Renviron` file

First, you need to navigate to your HOME directory. To check what RStudio recognizes as your HOME directory, you type the following in your console:
```
Sys.getenv("HOMEDRIVE")
Sys.getenv("HOMEPATH")
```

Now that we have located our home directory, we can create our blank `.Renviron` file in that location by writing the following in the R console:
```
file.create("C:/Users/BoydClaire/.Renviron", overwrite=FALSE)
```

Open this file in RStudio to add values to it. Then, in the newly created `.Renviron` file, copy and paste the following into it (ask Claire or another DOF member for the relevant hostname, port):
```
http_proxy = YOUR_HOSTNAME:PORT
https_proxy = YOUR_HOSTNAME:PORT
```

This saves the above as environmental variables that are used when configuring the R session. 

Note: this is a great file to use to save other usernames and passwords that you want to use in your project and want to avoid hard coding them into the scripts. For example, I have the following saved in my .renviron file
to use as needed for any given project:
```
# proxy information

http_proxy = ##########################
https_proxy = #########################

#github info
GITHUB_PAT=###############

# Oracle database connections
# need quotes

fdw_username='###############'
fdw_password='###############'
fdw_path='###############'
fdw_schema='###############'

pts_username='###############'
pts_password='###############'
pts_path='###############'
pts_schema='###############'

# SQL Server database connections
# do not need quotes

test_server=###############
test_database=####################
test_user=###############
test_password=###############

production_server=###############
production_database=##################
production_username=###############
production_password=###############

sandbox_server=###############
sandbox_database=################
sandbox_username=###############
sandbox_password=###############

#NYC OPEN DATA API CREDENTIALS
keyID=###############
keysecret=###############
```

Whenever I need any of the above in a Rproj, I can use the following syntax in base R to retrieve them:
```
Sys.getenv("fdw_username")
```

**REALLY IMPORTANT NOTE**

This file should not be added to your any github repository. It should stay as a local file that only you should have access to. 


## Creating an `.rprofile` file

Next, we need to save some settings to the `.Rprofile` file in order to work properly on the DOF Windows machines. 

Create the `.Rprofile` file in the home directory by repeating the above instructions with ".Rprofile" instead of ".Renviron".

```
file.create("C:/Users/BoydClaire/.Rprofile", overwrite=FALSE)
```

Open the file and add the following lines :
```
options(timeout=1000)
options(download.file.method = "wininet")
```

## Done! 

Now, every time you start an R Session, your settings from both of these files should be automatically pulled into your environment.

If you are still having trouble reading in environmental variables from your `.Renviron` file, you can manually read it into your system by doing the following:
```
readRenviron("C:/Users/BoydClaire/.Renviron")
```

## Common Error Messages

Sometimes different machines need additional steps to make sure the set up is successful. For example, sometimes you can get this error:

![image](https://github.com/user-attachments/assets/15058647-b998-4316-b0fa-2d147e7c798f)

If so, you need to take the extra step to disable secure downloads for HTTP. To do that in RStudio, go Tools > Global Options... > Packages, and then uncheck the boxes that say `Use secure download method for HTTP`, like the below:

![image](https://github.com/user-attachments/assets/004fe914-5daa-4db9-9167-6dbdb65e68b7)



