# Installation

This help file outlines which software you can use to access EconData.


## Excel Add-In

Our EconData Excel Add-In pulls the latest, up-to-date time series data (from any of the datasets supplied in EconData) into your Excel workbooks. The series will be structured as two columns with some headers: the left-hand column gives the date and the right-had column gives the values. You can, for example, overwrite previous data pulls to update graphs or quantitative models that are linked to that range.

To use the Excel Add-In, first create an account on [www.EconData.co.za](https://www.econdata.co.za/), then, in Excel, go to the Insert ribbon → Add-ins → Get Add-ins → search for "EconData" → add the app → and sign in to the app, using your EconData credentials. Please see https://youtu.be/8C1h4gsmQaQ for a video guide.

## R package

The R package can be installed with the following sequence of commands, in R:
```r
library(devtools)
install_github("coderaanalytics/econdatar")
library(econdatar)
```

### R environment variables

In order to fully automate your processes, please ensure that you save

`ECONDATA_CREDENTIALS="username;password"`

as a line in a `.Renviron` text file in your user Documents folder (Windows) or in `~` on Unix.

### Pulling data in R

An example of how you can pull structured data, using the `read_econdata()` function, is as follows. The data are provided in two tables in a list (the data table and the meta-data table), which can be linked with the data key. The data table contains the time period, values, and the data key (a concise encoding of the concept). The meta-data table gives more detail about each data key.

```r
library(econdatar)

qlfs_raw <- read_econdata(id = "QLFS",
                          releasedescription = "latest",
                          tidy = TRUE,
                          wide = FALSE,
                          compact = FALSE)
str(qlfs_raw)
```

You thus need to use an ID when calling the data. We outline the IDs in [2_Available_Data](./2_Available_Data.md).
