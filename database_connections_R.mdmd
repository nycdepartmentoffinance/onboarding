# Database Connections through R

The DOF Property Modeling Team utilizes a range of databases and tools to store and analyze data.

The diagram below gives a high-level overview of how these different data resources and tools are used together.

<img src="resources/data_workflow.jpg"/>

## How can you access these data resources in R?

There are currently two different database tools that are used: Microsoft SQL Server and Oracle databases. Even though we'll be using the same tools to connect to them, creating the connections with these two different systems requires slightly different syntax and credentials.

### Connecting to Microsoft SQL Server Databases (Production, Test, Sandbox)

We can establish a direct connection to Microsoft SQL Server using existing R packages, which link to the database using our credentials, allowing us to query the Production, Test, and Sandbox databases.

To do this, you first need to import two R packages locally: `DBI` and `odbc`. Note: you only need to do this once.

```{r}
#install necessary packages

#install.packages("DBI")
#install.packages("odbc")
```

Once these two packages are installed, you can establish a database connection using the credentials for either the production, test, or sandbox databases. For this demonstration, I'll query the test database, so first I'll save those credentials to my local `.Renviron` file saved in my HOME directory (detailed instructions on that [here](proxy_R.md)).

```
#replace the following with the real credentials
test_server="XXX.XXX.XX.XXX"
test_database='V8_XXXXXXXXXXXXXXXXXXX'
test_username="XXXXX"
test_password="XXXXX"

production_server="XXX.XXX.XX.XXX"
production_database='V8_XXXXXXXXXXXXXXXXXXX'
production_username="XXXXX"
production_password="XXXXX"

sandbox_server="XXX.XXX.XX.XXX"
sandbox_database='V8_XXXXXXXXXXXXXXXXXXX'
sandbox_username="XXXXX"
sandbox_password="XXXXX"
```

Restart your R Session here to re-read in your new environmental variables. To check if we can re-read them in successfully, you can try the following:
```{r}
# if the below is an empty string, run the following line of code to force reading in the environmental variables
readRenviron("C:/Users/BoydClaire/.Renviron")
Sys.getenv("test_database")
```
Next, I'll use the DBI and odbc packages to create a connection to the Microsoft SQL Server database as follows:

```{r}
# load necessary packages
library(DBI)
library(odbc)

#select database I want to read in data from
database = "test"

# create database connection, by reading in the correct env variables
con <- DBI::dbConnect(odbc::odbc(),
                      Driver   = "SQL Server",
                      Server   = Sys.getenv(paste0(database, "_server")),
                      Database = Sys.getenv(paste0(database, "_database")),
                      UID      = Sys.getenv(paste0(database, "_username")),
                      PWD      = Sys.getenv(paste0(database, "_password")),
                      TrustServerCertificate="yes",
                      Port     = 1433)
```

After establishing your connection in RStudio, you can browse the tables and schemas in the "Connections" tab on the right side of your screen, next to the "Environment" tab. This provides the same functionality as SQL Server.

With the database connection in place, we can begin constructing our queries. Let's start with a basic one.

```{r}
query="SELECT TOP 100 * FROM REAL_PROP.REALMAST"
```

Now that we have saved the query as a string, we can use it to query the database and store the result as a dataframe in our local R environment. To do this, we need to use the `dbGetQuery()` function, providing the database connection and the query string we wish to execute.

```{r}
realmast_top100_test <- DBI::dbGetQuery(
    #connection object made above
    conn=con,
    #pass the query we made above into the statement parameter
    statement=query
)
```

Let's take a look at the results:

```{r}
head(realmast_top100)
```

Great! Now let's try a slightly more complicated query using some environmental variables.

The package glue is helpful to drop in variables within a string (like a fiscal year or BCAT) using curly brackets, making it a more legible query than using paste().

```{r}
library(glue)

prior_FY=2025

incdata_query =
    glue::glue("
    Select ILA_Pid as Pid,
        ILA_AGI as AGI,
        ILA_AGI_PGSF as Inc_PGSF,
        ILA_Adj_Exp as AdjExp,
        ILA_Adj_Exp_PGSF as Exp_PGSF,
        ILA_Adj_EXP_PGI as ExpRatio,
        ILA_Adj_NOI as NOI,
        ILA_ADJ_NOI_PGSF as NOI_Pgsf,
        ILA_Tot_cap_rate as TotCap,
        ILA_Inc_Val as FY26_MV,
        ILA_Tot_Val as Tot_Val,
        ILF_BLDG_CAT as BCAT,
        ILF_Bldg_Sub_Cat as Subcat
    From 
        Real_Prop.INCOME_LF_APPROACH, 
        Real_Prop.Income_LF
    Where ILA_Type='R' And ILA_Year={prior_FY} 
        and ilf_year={prior_FY} and ilf_pid=ila_pid
    ")
```

We can check if it included our variables correctly by printing it:

```{r}
print(incdata_query)
```

Great! Now let's query our test database for this income data.

```{r}
income <- DBI::dbGetQuery(
    #same connection object made above
    conn=con,
    #pass the new query
    statement=incdata_query
)
```

Let's take a look at the results:

```{r}
head(income)
```

Now we can analyze the data easily within R and re-run the same import script without needing to handle any CSVs.

Once you are done reading in data, you can close your database connection by doing the following:

```{r}
DBI::dbDisconnect(con)
```

You can also do this by going up to the connections panel on the top right corner of RStudio and clicking the icon of the pipe with the red x through it.

### Connecting to Oracle Databases (FDW, PTS)

This set up is very similar to the above, but we have to pass in different parameters to make a connection to the Oracle databases where the FDW and PTS data is stored. Just like in SAS, we need the database path, schema, username and password to access the database. Before moving forward, add the following to your `.Renviron` file like the following:

```
fdw_username=XXXXXXXXXX
fdw_password=XXXXXXXXXX
fdw_path=XXXXXXXX
fdw_schema=XXXXXXXXXX

pts_username=XXXXXXXXXXXX
pts_password=XXXXXXXXXXX
pts_path=XXXXXXXXXXXXX
pts_schema=XXXXXXXX
```
Restart your R Session here to re-read in your new environmental variables. To check if we can re-read them in successfully, you can try the following:
```{r}
# if the below is an empty string, run the following line of code to force reading in the environmental variables
readRenviron("C:/Users/BoydClaire/.Renviron")
Sys.getenv("pts_schema")
```
Using these credentials, we can use the same packages to create a connection to the Oracle database.

```{r}

#select database I want to read in data from
database = "fdw"
database_schema = toupper(Sys.getenv(paste0(database, "_schema")))

# create database connection, by reading in the correct env variables
con <- DBI::dbConnect(odbc::odbc(),
                      Driver   = "Oracle in OraClient19Home1",
                      DBQ   = Sys.getenv(paste0(database, "_path")),
                      DATABASE = Sys.getenv(paste0(database, "_schema")), 
                      UID      = Sys.getenv(paste0(database, "_username")),
                      PWD      = Sys.getenv(paste0(database, "_password")),
                      TrustServerCertificate="no",
                      Port     = 1433)
```

Now that the connection is made, you can go over to your Connections Tab on the top right hand corner of your screen and explore the tables within the Database. Note, the most important tables for FDW are in FDW3NF and for PTS are in IAS.

Nest, we can write a version of the same query above, using Oracle SQL syntax.

```{r}
fdw_query=glue::glue("SELECT * FROM {database_schema}.VW_CAMA_REALMAST WHERE ROWNUM <= 100")
```

Now that we have saved the query as a string, we can use it to query the database and store the result as a dataframe in our local R environment. To do this, we need to use the `dbGetQuery()` function again, providing the database connection and the query string we wish to execute.

```{r}
realmast_top100_fdw <- DBI::dbGetQuery(
    conn=con,
    statement=fdw_query
)
```

Let's check the results:

```{r}
head(realmast_top100_fdw)
```

Great! This looks very similar to our call to the test database. Now we can pretty much interchangeably get data into R from either database resource and analyze it as needed all in once place.

Now that we are done, let's close the database connection.

``` {r}
DBI::dbDisconnect(con)
```

