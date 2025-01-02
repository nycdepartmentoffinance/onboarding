# Database Connections through R

The DOF Property Modeling Team utilizes a range of databases and tools to store and analyze data.

The diagram below gives a high-level overview of how these different data resources and tools are used together.

<img src="resources/data_workflow.jpg"/>

## How can you access these data resources in R?

There are currently two different ways to connect to the two different database connections through R: connecting through Microsoft SQL Server (for the Production, Test, and Sandbox Databases) and using a custom database connection through assessNYC (FDW and PTS).

### Connecting with Microsoft SQL Server

We can connect through Microsoft SQL Server directly through existing R packages that form a database connection with our credentials, and can query the Production, Test, and Sandbox databases through that approach.

To do this, you first need to import two R packages locally: `DBI` and `odbc`. Note: you only need to do this once.

``` r
#install necessary packages
install.packages("DBI")
install.packages("odbc")
```

After these two packages are installed successfully, you can form a database connection with credentials of either the production, test or sandbox databases.

For this demonstration, I'll query the test database, so first I'll save those credentials locally.

``` r
#replace the following with the real credentials
test_server="XXX.XXX.XX.XXX"
test_database='V8_XXXXXXXXXXXXXXXXXXX'
test_username="XXXXX"
test_password="XXXXX"
```

Next, I'll use the DBI and odbc packages to create a connection to the Microsoft SQL Server database as follows:

``` r
# load necessary packages
library(DBI)
library(odbc)

# create database connection
con <- DBI::dbConnect(odbc::odbc(),
                      Driver   = "SQL Server",
                      Server   = test_server,
                      Database = test_database,
                      UID      = test_username,
                      PWD      = test_password,
                      TrustServerCertificate="yes",
                      Port     = 1433)
```

Once your connection is made in RStudio, you can explore the tables and schemas in the "Connections" tab on the right hand side of your screen, next to "Environment". This mimics the same functionality in SQL Server.

Now that we have established the database connection, we can start to build our queries.

Let's start with a very simple one.

``` r
query="SELECT TOP 100 * FROM REAL_PROP.REALMAST"
```

Now that we have a query saved as a string, we can use it to actually query our database as save the result as a dataframe within our local environment in R. We have to use the dbGetQuery() function, passing in the database connection and the string of the query we want to run.

``` r
realmast_top100 <- DBI::dbGetQuery(
    #connection object made above
    conn=con,
    #pass the query we made above into the statement parameter
    statement=query
)
```

Let's take a look at the results:

``` r
head(realmast_top100)
```

Great! Now let's try a slightly more complicated query using some environmental variables.

The package glue is helpful to drop in variables within a string (like a fiscal year or BCAT) using curly brackets, making it a more legible query than using paste().

``` r
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

``` r
print(incdata_query)
```

Great! Now let's query our test database for this income data.

``` r
income <- DBI::dbGetQuery(
    #same connection object made above
    conn=con,
    #pass the new query
    statement=incdata_query
)
```

Let's take a look at the results:

``` r
head(income)
```

Now we can analyze the data easily within R and re-run the same import script without needing to handle any CSVs.

Once you are done reading in data, you can close your database connection by doing the following:

``` r
DBI::dbDisconnect(con)
```

You can also do this by going up to the connections panel on the top right corner of RStudio and clicking the icon of the pipe with the red x through it.

### Connecting with Financial Data Warehouse

Next, we can read in data from the Financial Data Warehouse (FDW) using a custom function `get_database_table` built for this team within the assessNYC package.

First, follow [these instructions](https://github.com/nycdepartmentoffinance/assessNYC) to install the package.

Once installed, you can explore some of the documentation of this function:

``` r
?assessNYC::get_database_table()
```

The function works similarly to the one above in that it takes some information to build the correct query as well as information to create the right kind of database connection.

To query the right database, we need to:

-   indicate the database (right now either "FDW" or "PTS"),

-   name the result of our dataframe as "tablename" (NOTE: this is not the actual name of the tables we are pulling from), and

-   pass it a query string (just like above).

In this case, the database connection is made in SAS so you need to pass in two different parameters: -

-   `sas_filepath`: file path to your SAS executable (`sas.exe`)

-   `env_filepath`: file path to an environmental file that has the following saves as variables: `fdw_username`, `fdw_password`, `fdw_path`, `fdw_schema` and/or `pts_username`, `pts_password`, `pts_path`, `pts_schema`

With that in mind, let's replicate the top 100 realmast query from above, but instead of using the test database use FDW instead.

All together, the call to FDW using the get_database_table function would be the following:

``` r
realmast_top100_fdw = assessNYC::get_database_table(
     database='FDW',
     tablename='realmast_top100_fdw',
     query="
        Select *
        From S.vw_Cama_realmast(obs=100);
        ",
     # these two inputs are specific to my system. Make sure to change as needed
     sas_filepath='C:/Program Files/SASHome/SASFoundation/9.4/sas.exe',
     env_filepath='C:/Users/BoydClaire/workspace_local/.renviron'
      )
```

Let's check the results:

``` r
head(realmast_top100_fdw)
```

Great! This looks very similar to our call to the test database. Now we can pretty much interchangeably get data into R from either database resource and analyze it as needed all in once place.

Note: if the FDW call fails, look within the `tmp/` folder in your current working directory at the log for the given call. You should be able to debug it from there.
