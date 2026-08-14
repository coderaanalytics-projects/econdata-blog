# Tutorial

# Load the EconDataR and Tidyverse packages
library(econdatar)
library(tidyverse)

# Extract the National Accounts dataset from EconData (which contains GDP)
rdnl <- read_dataset("NATL_ACC", wide=FALSE) # This is a list: $data (long) and $metadata
# Bind the metadata list into one table
as_tibble(rdnl$metadata) # Ask an AI chat what a "relational" database is.
# Look at the column names of this table
as_tibble(rdnl$metadata) %>% names()

# Alternatively, combine the metadata with the data, in one big table.
rdnc <- read_dataset("NATL_ACC", wide=FALSE, combine=TRUE)

# Our Market Rates dataset: https://econdata.co.za/user-guide/sarb/rates/#MARKET_RATES
mr <- read_dataset("MARKET_RATES", wide=FALSE, combine=TRUE)
# Column names
names(mr)
# Unique series names
unique(mr$series_name)
# Put the series keys alongside the series names
mr %>% select(series_key, series_name) %>% distinct()
# Now we know how to extract a subset of series
mrb <- read_dataset("MARKET_RATES", series_key = c("CMJD004.B.A", "MMSD008.D.A"))
# Only two series were extracted!

options(width=130) # This line can adjust the width of the console output.

# When including more columns in a wide table, view() works best in VS Code (tidyverse loads the tibble package that is necessary for this)
mr %>% select(series_key, series_name, comment) %>% distinct() %>% view()
