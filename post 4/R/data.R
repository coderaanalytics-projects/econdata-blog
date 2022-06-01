library(econdatar)
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)



# GDP vintages data ---


format_gdp <- function(x) {
  as.yearqtr <- function(y)
    paste0(format(y, format = "%Y"), quarters(y))
  tibble(Value = x$KBP6006.R.S$OBS_VALUE) %>%
    mutate(Date = x$KBP6006.R.S %>%
           rownames() %>%
           as.Date() %>%
           as.yearqtr()) %>%
  mutate(Vintage = release$Description)
}

releases <- read_release(id = "NATL_ACC",
                         agencyid = "ECONDATA",
                         version = "all",
                         provideragencyid = "ECONDATA",
                         providerid = "STATSSA")

gdp_vintages <- NULL

for (dataset in releases) {
  for(release in dataset$Releases) {
    print(release$Description)

    natl_acc <- read_econdata(agencyid = "ECONDATA",
                              id = "NATL_ACC",
                              version = dataset$DataSet$Flowref[[3]],
                              key = "KBP6006.R.S",
                              provideragencyid = "ECONDATA",
                              providerid = "STATSSA",
                              releasedescription = release$Description)

    gdp_vintages <- rbind(gdp_vintages, format_gdp(natl_acc))
  }
}

write_csv(gdp_vintages %>%
          arrange(Vintage, Date) %>%
          pivot_wider(id_cols = everything(),
                      names_from = Vintage,
                      values_from = Value),
          "data/Realtime GDP.csv")
