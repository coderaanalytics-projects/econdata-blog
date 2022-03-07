# Charting and automation

Most economists spend a lot of time creating interesting and insightful data visualisations. Unfortunately, many economists and other data professionals spend perhaps even more time updating their charts or recreating the charts of others.

A key feature of EconData is to allow you to create charts and visualisations that are easily updated, reused and repurposed.

In this blog post we will illustrate how to create and import data into R using EconData and using this data, how to create a simple chart. The idea is to provide a starting point that can be used for automated plotting. 

The first step towards automation is setting up your own template with the data series that you would like to see on an on going basis and changing the plotting instructions to reflect your preferred format. Thereafter, all that is required is to run the script any time you would like to see the latest plots of the data. 

First, lets load the required packages. Note the inclusion of the EconData package `library(econdata)`. Since this package is available on Github and not on CRAN you will not be able to install it in the typical way. 

The easiest way to do this for the uninitiated is to [download the source code from Github](https://github.com/coderaanalytics/econdatar/archive/refs/heads/master.zip), unzip the file, rename it to _econdatar_ and install it using the following command in R

```r
install.packages("your\path\to\econdatar",repos=NULL,type="source")
```

For those familiar with installing packages from Github, that method will likely be more convenient.

Using the `read_econdata()` function we can import the data directly into R. In order to use the function you will need an active account with EconData, which can be created by following this [link](https://www.econdata.co.za/register).

The function requires that we, at a minimum, provide the data set _id_ - in this case the [BA100 data set](https://www.econdata.co.za/FusionRegistry/data/datastructure.html). We also specify the _key_ so that only the time series that we are interested in are returned. The data we are downloading for this tutorial is total credit extension from all banking institutions in South Africa, it has the data key of _TOT.A3.L024_. 

Let's take a look at how the data key is constructed for those that are interested, **this next section can be skipped without loss of continuity.** 

The data key refers to the [searchable dimensions of the data set](https://www.econdata.co.za/FusionRegistry/data/datastructure.html). _TOT_ is the first dimension which represents the bank in question, here specifically it is the aggregation for all the banks in SA - the grand total. _A3_ is the second dimension this represents a column, or aggregation, of a table in the BA100 form, here again it is the total. And lastly, _L024_ is the third dimension and it represents the 24th line of the BA100 form, namely gross loans and advances. Leaving out any dimension acts as a wildcard for that dimension, for example, the data key _TOT..L024_ will return all aggregations of the BA100 form matching the two given dimensions. A good way of getting the hang of how this work is to play with the [EconData webapp](https://www.econdata.co.za/app), pay specific attention to the export functionality and the generated R code. We will go deeper into this topic in the next post.

Accompanying the data download, is the meta data that can easily be explored. The meta data contains useful information about the properties of the data series such as the date on which the data was released, the unit multiplier, frequency and unit of measure. 

Next, using some functions from the dplyr package, we can convert the time series data to a tibble format which allows for easy data manipulation and plotting. Also using dplyr, we are converting the raw data to a year-on-year growth rate. 

Lastly, using the ggplot2 package we can create a simple line plot to visualise the data. 

