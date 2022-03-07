# Charting and automation

In this blog post we will illustrate how to create a import data into R using EconData and how to create a simple chart. The idea is to provide a template that can used for automated plotting. The first step towards automation is setting up your own template with the data series that you would like to see on an on going basis and changing the plot template to your preferred format. Thereafter, all that is required is to run the script every time you would like to see the latest plots of the data. 

First, lets load the required packages. 

Using the read_econdata() function we can import the data directly into R. The data we are downloading for this tutorial is total credit extension from all banking institutions in South Africa.  

Accompanying the data download, is the meta data that can easily be explored. The meta data contains useful information about the properties of the data series such as the date on which the data was released, the unit multiplier, frequency and unit of measure. 

Next, using some functions from the dplyr package, we can convert the time series data to a tibble format which allows for easy data manipulation and plotting. Also using dplyr we are converting the base data to a year-on-year growth rate. 

Lastly, using the ggplot2 package we can create a simple line plot to illustrate the data. 

