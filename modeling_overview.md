# Modeling Overview
This is intended as a high level place to start to understand the type and structure of the models that the NYC DOF Property Mapping and Valuation team uses to value property.

When we model properties in New York we generally split them up based off of the use and location of the property. We build a separate model to value offices in Manhattan than single family homes in Queens. We even build different models to capture the retail in Staten Island and in Queens. The types of models we build are sometimes dictated by law, sometimes by software restrictions, and sometimes based on our own decisions. 

Our models can generally be split into three valuation approaches: sales, income, and gross income multiplier (GIM). Explore the table below to see how we value the different properties in NYC:

|  Property Type      | Description  | Valuation Approach | Team Responsible  |
| ------------- | ------------- |------------- |------------- |
| Class 1 | One, two, or three family homes | Sales Comparison | Modeling Unit |
| Class 1AC | One, two, or three family condos | Sales Comparison | Modeling Unit |
| Class 1S |  Part commercial part residential | Sales Comparison | Modeling Unit |
| Class 1 | Vacant land | Sales Based Regression | Modeling Unit |
| Class 2 | Apartment buildings with 11+ units| Income Comparison | Modeling Unit |
| Class 2ABC | Apartment buildings with <11 units | Gross Income Multiplier (GIM) | Modeling Unit |
| Class 3 | Utility company and franchise property | Cost | Real Estate of Utility Corporations (RUC) Unit |
| Class 4 | Commercial Properties (offices, industrial, retail,etc.)  | Income Comparison | Modeling Unit |

The rest of this guide will be broken down based on the four model types that our unit is responsible for:
- [Comparable Sales Model](#Comparable-Sales-Model)
- [Comparable Income Models](#Comparable-Income-Models)
- [Gross Income Multiplier (GIM) Models](#Gross-Income-Multiplier-(GIM)-Models)
- [Sales Based Regression](#Sales-Based-Regression)

For clarity these descriptions will exclude units. All incomes and expenses are in $/ft<sup>2</sup> and all market values are in \$. There are technically units associated with weights as well, but functionally they are not critical in our usage.

## Where modeling fits in raising property taxes for NYC
Our generated market value is the just first step in the process of raising property taxes for the city. For greater context, this is where our work fits in that larger workflow:
1. Determine market value - this is us!
2. Determine assessed value 
3. Determining transitional assessed value 
4. Apply exemptions
5. Issue property tax bills to NYC property owners

## Comparable Sales Models
Comparable sales models are the most accurate and reliable types of models for property valuation, however they require enough properties being sold to be useful. For this reason and due to tax laws, the only types of properties we use comp sales models on are tax class 1 properties. The idea behind these models is that the value of one home will be similar to that of similar homes nearby which recently sold.

### Data
Time adjusted sales from the last 2.5 years (or 3.5 years in Manhattan). This data is cleaned to get rid of unqualified sales, which are non-market sales between related parties or instutions. This includes sales that are 'below market' based on being under a certain value varying by borough. This also includes sales to family members, estate sales, foreclosures,  flip sales, and other unusual sales. 

### Comps
The first part of the modeling process is to select five comparable properties (generally called comps) that match the physical characteristics of the subject parcel. The way the comps are selected is that a series of weights are selected for key variables. For example:

|  Feature      | Weight        |
| ------------- | ------------- |
| Age  | 2  |
| Size  | 3 |
| Frontage  | 1 |

If we want to see how good of a match comps are we can calculate a similarity score via:
```math
S = W_1 \vert S_1 - C_1\vert + W_2 \vert S_2 - C_2\vert + W_3 \vert S_3 - C_3\vert + ... + W_N \vert S_N - C_N\vert
```
Where `W` is the weight associated with a feature, `S` is the value of that feature for the subject and `C` is the value for the feature of the comp. A lower similarity score means the comp is more similar to the subject. If we continue with our example from above we can look at the age, size, and frontage for a few different potential comps.

|  Parcel      | Age  | Size | Frontage  |
| ------------- | ------------- |------------- |------------- |
| Subject | 10 | 100 | 10 |
| Comp 1 | 10 | 110 | 15 |
| Comp 2 | 20 | 80 | 10 |
| Comp 3 | 8 | 105 | 12 |

If we want to do the calculation for Comp 1, we can rewrite our equation with our specific feature
```math
S = W_{Age} \vert S_{Age} - C_{Age}\vert + W_{Size} \vert S_{Size} - C_{Size}\vert + W_{Frontage} \vert S_{Frontage} - C_{Frontage}\vert.
```
If we plug in the values (ignoring units since the unit of the weight will be the reciprocal of the unit of the value) we get
```math
S = 2 \vert 10 - 10\vert + 3 \vert 100 - 110\vert + 1 \vert 10 - 15\vert,
```
and simplifying give us
```math
S = 0 + 30 + 5 = 35.
```
The same thing can be done for all potential comps and we find that for this example 
|  Parcel      | Similarity Score |
| ------------- |------------- |
| Comp 1 | 35 |
| Comp 2 | 80 |
| Comp 3 | 21 |

From these three choices Comp 3 is the most similar to the subject and Comp 2 is the most different. Generally this will be done on a larger scale with many more potential comps and the five with the lowest scores will be selected by Vision, our CAMA software, to be the comps for this subject.

To see how similar the comps are for the whole population you can use a difference table. These tables give the absolute and percentage difference for select key features such as distance, age, and size at a range of percentiles. 

### Adjustments
The second part of the modeling process to to adjust the comp's sale value to match the subject's. A simple way to think about this that the comps won't match the subject parcel exactly. Let's say you are comparing two three family houses and the subject is four stories while the comp is five. The adjustment will subtract away some of the market values associated with the extra floor in the comp. In reality these adjustment are more complex and look at physical features as well as historical values to predict this years values.

The adjustment model produces a set of adjustments to the market value for every parcel. These look something like this:

|  PID      | Adjustment | 
| ------------- |---------------- |
| 1 | 10,000 |
| 2 | 50,000 |
| 3 | 20,000 |
| 4 | 53,000 |
| 5 | 2,000 |
| 6 | 3,000 |

To apply the adjustments you add the adjustment for the subject and subtract the adjustment for the comp to the sale value of the comp. In the form of an equation:

```math
SV_{adjusted} = SV_{c} + A_{s} - A_{c},
```
where `SV` is the sale value, `A` is the adjustment, `s` is for the subject, and `c` is for the comp. 

If PID 1 from the above example is the subject and the other five are potential comps we know the sale value of PIDs 2-6:
|  PID      |  Sale Value | 
| -------------|-------- |
| 2 | 554,000 |
| 3 | 540,000 |
| 4 | 552,000 |
| 5 |  498,000 |
| 6 | 490,000 |

The adjusted sale value for PID 2 can be calculated by
```math
SV_{adjusted} = 554,000 + 10,000 - 50,000 = 514,000.
```
We can do the same thing for all the other comps and find the adjusted value associated with each comp.

|  PID      |  Sale Value | Adjusted Sale Value |
| -------------|-------- |-------- |
| 2 | 554,000 | 514,000 |
| 3 | 540,000 | 530,000 |
| 4 | 552,000 | 509,000 |
| 5 | 498,000 | 506,000 |
| 6 | 490,000 | 497,000 |

From this it should be clear that even though the original sales weren't very close together the adjustment makes them cluster around a smaller range of values which is closer to the historic market value of the subject. 

The comp with the median adjusted sale value is selected as the primary comp which means that it is the market value assigned to the subject. In this example the primary comp is PID 4, so the market value for PID 1 would be $509,000.  

To see how well the model performs overall the r, median sales ratio, COD, PRD, PRB adn MKI values are examined for the adjusted market value compared to the actual sale value for the known parcels. For more information on these metrics see the [Evaluation Metrics](#Evaluation-Metrics) section below. Finally, the parcels that have acceptable values are stamped by `MDL` and they are considered valued for the season. Parcels that remain unstamped are assigned to assessors to value. The comps selected via our models are already populated in Vision and they can access a list sorted by similarity score for all other potential comps.

## Comparable Income Models
The market value of Tax Class 2 and 4 properties are valued based on the income and expense associated with each parcel. The simple equation that links income with market value is 
```math
MV = \frac{I - E}{C} = \frac{NOI}{C}.
```
Where `MV` is the market value, `I` is income, `E` is expense, `C` is cap rate, and `NOI` is net operating income. In terms of building a model to find the market value the modeling team is responsible for finding the associated income and expense. The cap rate is calculated by Carmela. So lets dig into finding the income and expense.

### Data
The input data for an income model comes from the Real Property Income and Expense (RPIE) Statements. These are forms that all profit earning properties that make more than $40,000 per year must submit annually. The RPIE provides the self reported income and expense associated with the property. After receiving these forms assessors go through them and either approve or reject the values for income and expense. The approved parcels get stamped by the assessor and become potential comps for the other parcels as well as part of the training set for the modelers. A model is required to predict the income and expense for all the parcels that assessors didn't approved, along with all condos, and any parcel that didn't file an RPIE.

### Comps
The selection process for comps in income models is identical to the process for sales based models, see [Comps](#Comps) section above.

### Adjustments
The second part of the modeling process to to adjust the comp's income and expense values to match the subjects. A simple way to think about this that the comps won't match the subject parcel exactly. Let's say you are comparing two office buildings and the subject is four stories while the comp is five. The adjustment will subtract away some of the income and expense values associated with the extra floor in the comp. In reality these adjustment are more complex and look at physical features as well as historical values to predict this years values.

The adjustment model produces an adjusted income and an adjusted expense for every parcel. These look something like this:

|  PID      | Income Adjustment | Expense Adjustment | 
| ------------- |------------- | -------- |
| 1 | 10 | 3 |
| 2 | 50 | 10 |
| 3 | 22 | 3 |
| 4 | 13 | 1 |
| 5 | 24 | 8 |
| 6 | 3 | 4 |

To apply the adjustments you add the adjustment for the subject and subtract the adjustment for the comp to the income (or expense) of the comp. In the form of an equation:

```math
I_{adjusted} = I_{c} + AI_{s} - AI_{c},
```
where `I` is the income, `AI` is the income adjustment, `s` is for the subject, and `c` is for the comp. Similarly we can find the expense in the same way.

```math
E_{adjusted} = E_{c} + AE_{s} - AE_{c},
```
where `E` stands for the expense and `AE` stands for the expense adjustment. 

If PID 1 from the above example is the subject and the other five are potential comps we know the income and expense of PIDs 2-6:
|  PID      |  Income  |  Expense | 
| ------------- |------------- | -------- |
| 2 | 82 | 19 |
| 3 | 50 | 9 |
| 4 | 37 | 11 |
| 5 |  60 | 15 |
| 6 | 30 | 10 |

The adjusted Income for PID 2 can be calculated by
```math
I_{adjusted} = 82 + 10 - 50 = 42,
```
and we can do the same for the expense
```math
E_{adjusted} = 19 + 3 - 10 = 12.
```
We can do the same thing for all the other comps and find the adjusted value associated with each comp.

|  PID      |  Income |  Expense | Adjusted Income | Adjusted Expense  |
| ------------- |------------- | -------- |------------- | -------- |
| 2 | 82 | 19 | 42 | 12|
| 3 | 50 | 9 | 38 | 9 |
| 4 | 37 | 11 | 34 | 13 |
| 5 |  60 | 15 | 46 | 10 |
| 6 | 30 | 10 | 37 | 9 |

From this it should be clear that even though the original incomes weren't very close together the adjustment makes them cluster around a smaller range of values which is closer to the historic value of the subject. 

The comp with the median adjusted income value is selected as the primary comp which means the adjusted income and expense associated with it are assigned as the income and expense values for the subject. In this example the primary comp is PID 2, so the income for PID 1 would be $42 per square foot and the expense would be $12 per square foot.  

To see how well the model performs overall the r, median sales ratio, COD, PRD, PRB adn MKI values are examined for the adjusted income, adjusted expense, and adjusted NOI compared to the actual values of these quantities. For more information on these metrics see the [Evaluation Metrics](#Evaluation-Metrics) section below. Finally, the parcels that have acceptable values are stamped by `MDL` and they are considered valued for the season. Parcels that remain unstamped are assigned to assessors to value. The comps selected via our models are already populated in Vision and they can access a list sorted by similarity score for all other potential comps.

## Gross Income Multiplier (GIM) Models
For tax class 2ABC (4-10 unit buildings) gross income multiplier (GIM) models are used to find the market value. The basic equation for GIM models is
```math
MV = I * GIM.
```
Where `MV` is is market value, `I` is income, and `GIM` is the gross income multiplier. 

### Data
These models rely on known sales data from 2ABC buildings and tax class 2 buildings with fewer than 20 units and income data on from tax class 2 and 2ABC parcels that filed RPIEs to find the GIM values associated with the geographic areas for a variety of quartiles. The models are used to predict the market value and income for parcels that don't have known values. From these models GIMs are found for all tax class 2ABC parcels. 

### Income and Sales Models
For these models each boro is split into 1, 2, or 3 areas and fully residential buildings are separated from mixed use buildings. For each of these clusters there are three income levels - low (up to the 25th percentiles), median (25th - 75th percentiles), and high (above the 75th percentile). For each Gim there are four percentiles considered (from minimum to the 25th percentile is considered the 10th, for everything between the 25th and 75th percentiles is called the 50th, from the 75th to the 90th is called the 75th, and above the 90th percentile is considered the 90th). This produces a table which follows this format:

| **Income &darr; \ GIM &rarr;** |10th % (8.08) | 50th % (13.92) | 75th % (16.98) | 90th % (26.06) |
| :--- | :--- | :--- | :--- |:--- |
| **Low (41.12)** |332.30	 | 572.19 | 698.00	| 1071.55  |
| **Median (50.85)**  | 410.94 |	707.59| 	863.18	| 1325.12  |
| **High (60.60)**  | 489.78	| 843.34	| 1028.78	| 1579.34 |

Where the values in the table are the results of multiplying the GIM percentile value with the income percentile value. 

### Stabilization
Once these values are found stabilization is put in place to ensure that there aren't large swings in values from year to year. To do this GIM values are compared to last years, producing the ratio (this_year / last_year). The same thing is done for each income level. Different caps are put into place for the GIM ratios. For each different GIM cap tested the median GIM is set and the other GIMs are stabilized around them. This is confusing so lets look at an example.


| GIM |10th % | 50th % | 75th % | 90th % |
| :--- | :--- | :--- | :--- |:--- |
| this_year | 8.08	| 13.92 |	16.98 |	26.06 |
| last_year | 10.14 |	16.15 | 19.49 | 31.67  |
| ratio | 0.80	| 0.86	| 0.87 |	0.82 |

In this case, the GIM last year was consistently higher than this year, but it could be the other way too. The next step in stabilization is to set a minimum and maximum for the ratio of this year to last year's GIM. To start we will use 0.9 - 1.1 as a potential ratio range. If the minimum value is 0.9 we see that all of our values are lower than 0.9, however we will set the median value to 0.9 and adjust the others around it by:

ratio_90_110<sub>10</sub> = ratio<sub>10</sub> * ratio_90_110<sub>50</sub> / ratio<sub>50</sub> 

where ratio values are taken from the table and ratio_90_110<sub>50</sub> the capped version of rati<sub>50</sub>, which in this example is 0.9. This produces

ratio_90_110<sub>10</sub> = 0.8 * 0.9 / 0.86 = .837

This can be done for all of the GIM percentiles, but we can just enter them into the table along with a similar version assuming a range of 0.95 - 1.05.

| GIM |10th % | 50th % | 75th % | 90th % |
| :--- | :--- | :--- | :--- |:--- |
| this_year | 8.08	| 13.92 |	16.98 |	26.06 |
| last_year | 10.14 |	16.15 | 19.49 | 31.67  |
| ratio | 0.80	| 0.86	| 0.87 |	0.82 |
| ratio_90_110 | 0.83	| 0.90 |	0.91 |	0.86 |
| ratio_95_105 | 0.88	| 0.95 |	0.96 |	0.91|

Once the capping range is selected the ratio for each percentile is multiplied back with it's original value for last year. So if we chose to use the 0.95 - 1.05 capping range the 10th percentile GIM would be:

this_year_95_105<sub>10</sub> = ratio_95_105<sub>10</sub> * last_year<sub>10</sub>,

which we can plug the numbers into to get,

this_year_95_105<sub>10</sub> = 0.88 * 10.14 = 8.92,

and this can be repeated for all the percentiles to get the full table.

| GIM |10th % | 50th % | 75th % | 90th % |
| :--- | :--- | :--- | :--- |:--- |
| this_year | 8.08	| 13.92 |	16.98 |	26.06 |
| last_year | 10.14 |	16.15 | 19.49 | 31.67  |
| ratio | 0.80	| 0.86	| 0.87 |	0.82 |
| ratio_90_110 | 0.83	| 0.90 |	0.91 |	0.86 |
| ratio_95_105 | 0.88	| 0.95 |	0.96 |	0.91|
| this_year_95_105 | 8.91	| 15.34 |	18.72 |	28.72 |

The bottom line of this table is what is used as the GIM going forward. We can rewrite our original table with these stabilized values.

| **Income &darr; \ GIM &rarr;** |10th % (8.91) | 50th % (15.34) | 75th % (18.72) | 90th % (28.72) |
| :--- | :--- | :--- | :--- |:--- |
| **Low (41.12)** | 366.20	| 630.88	| 769.57	| 1181.09 |
| **Median (50.85)**  | 452.86	| 780.17 |	951.67 |	1460.57 |
| **High (60.60)**  | 539.69	| 929.76	| 1134.14	| 1740.62  |

For the parcels with unknown income or market value, the GIM and income are estimated via a regression model. If the finale market value calculated is within 20% of last year's value it is used. If it outside that range the +/-20% cap is put in place. To actually update the value the land value is held constant and the building value is adjusted. 

<!--
***How do you know which income and which GIM percentile to use for each building?***
***how are the neighborhoods that go into each RX and CX chosen?***

- includes 4-10 units rental
- condo or coop 2-10 units
- method is income to calculate market value
- final market value is GIM * income per square foot * sq feet
- second step is to do a comparison one type is value in range and the other needs to be capped
  - for in range we use the original method , in range is within 0.8 and 1.2 of FMV from last year
  - capped are out of that range and we cap
- decide FMV if it is higher than 1.2 FMV it is 1.2 * last year's FMV... same on lower side
- FMV = LV + BCV + extra building value
  - LV is fixed
  - extra BV is fixed (calculated by MuLing's team)
  - only thing we can change is BV, calculate it and override it in the system
 
- need to do estimation on sales, income, and GIM
- sales estimation prediction - quantile regression predicting the price by sqft, total residential units, stories...etc for TC2abc properties
  - how do you know if it is good?   
- assign building GIM based on BCAT and SUBCAT
- income per sqfr grouping assignment is up to 25, 25 - 75, or over 75 -> from RPIE (***what about COOPs?***)
- GIM grouping is calculated by FMV/sqft divided by income/sqft     
- assign them to different ranges, under 25% GIM, first grouping, from 25 to 75 in o.5, for 75-90 it is 75, above 90 is 90th percentile
- ***stabalization? what is the goal of that?***
- groscon from pndw cells 

-->

## Sales Based Regression
Regression models predict a relationship between a number of independent variables with a dependant variable, the thing you are trying to predict. In our case the dependent variable is sale price. They generally take the form of:

```math
S = W_{1} V_{1} + W_{2} V_{2} + W_{3} V_{3} + ... + W_{n} V_{n}.
```
Where `S` is the dependent variable, in this case sale price. The `W`s are weights and the `V`s are the independent variables or features. They could be things like size, neighborhood, or zoning.

### Data
Sales data from the prior 3 years with unqualified sale and outliers removed. 

### Regression
In a regression all variables need to be numeric. In the example above size is numeric but neighborhood and zoning are both categorical. One way to turn a categorical independent variables into a numeric one is to group by the category and use the median of the target value (dependent variable) for each category. If we take neighborhood as an example we might have a dataset like:

| PID |Neighborhood | Sale Value ($) |
| :--- | :--- | :--- | 
| 1 | Tribeca | 100,000  |
| 2 | Soho | 700,000  |
| 3 | Tribeca | 300,000  |
| 4 | Tribeca | 400,000  |
| 5 | Soho | 600,000  |
| 6 | Soho | 900,000  |
| 7 | Soho | 800,000  |
| 8 | Soho | 1,000,000  |.

In this case to find the numeric value for each neighborhood you would take the median value for each neighborhood. In Soho the median value is $800,000 and in Tribeca the median is $300,000. These can be added to the dataset as a new column such that the same value is in the Neighborhood Median column for all parcels in the same neighborhood.

| PID |Neighborhood | Sale Value ($) | Neighborhood Median($) |
| :--- | :--- | :--- | :--- | 
| 1 | Tribeca | 100,000  | 300,000  |
| 2 | Soho | 700,000  | 800,000  |
| 3 | Tribeca | 300,000  | 300,000  |
| 4 | Tribeca | 400,000  | 300,000  |
| 5 | Soho | 600,000  | 800,000  |
| 6 | Soho | 900,000  | 800,000  |
| 7 | Soho | 800,000  | 800,000  |
| 8 | Soho | 1,000,000  | 800,000  |.

The same thing can be done for all other categorical variables. 

In this model there may be some properties which are exempt from this regression, and adjustments can be made to their predicted values. Once the prediction is made the model is scored by the same [Evaluation Metrics](#Evaluation-Metrics) as the rest of the models.


## Evaluation Metrics
- r - Pearson correlation coefficient - It measures the strength and direction of a linear relationship between two variables. The closer to 1 the more similar the two variables are.
- median sales ratio - This finds the median value of the ratio of predicted value divided by actual value. It should be approximately 1.
- COD - coefficient of dispersion - This looks at the equity within a price, or the horizontal equity. The acceptable range is between 5 and 15.
- PRD - price related differential - This looks at vertical equity, or equity across prices. The acceptable range is between 0.98 and 1.03. Values above 1 are regressive meaning lower valued properties are valued at more than they are worth and higher valued properties are valued at lower values than they are worth.
- PRB - price related bias - This is another metric of vertical equity. Acceptable values fall between -0.05 and 0.05 where negative value are regressive and positive are progressive.
- MKI - modified Kakwani Index - This is another measure of vertical equity. The acceptable values fall between 0.90 - 1.10.
