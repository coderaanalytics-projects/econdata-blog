library(econdatar)
library(dplyr)
library(ggplot2)
library(readr)
library(seasonal)
library(tidyr)


# GDP data ---


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
          "Data/Realtime GDP.csv")

natl_acc <- read_econdata(id = "NATL_ACC",
                          key = "KBP6006.R.S",
                          providerid = "SARB",
                          releasedescription = "newest")

as_ts <- function(x, label, seas_adj = FALSE) {
  y <- filter(x, Label == label)

  start_date <- strtoi(substr(y$Quarter[1], 1, 4)) +
    (strtoi(substr(y$Quarter[1], 7, 7)) - 1) / 4

  z <- ts(pull(y, Value), freq = 4, start = start_date)

  if (seas_adj) {
    z %>%
      seas() %>%
      series("seats.trend")
  } else {
    z
  }
}

gdp_data <-   rbind(tibble(Period = rownames(natl_acc$KBP6006.R.S),
               Value = natl_acc$KBP6006.R.S$OBS_VALUE,
               Label = "gdp")) %>%
  mutate(Period = as.Date(Period)) %>%
  mutate(Quarter = paste(format(Period, format = "%Y"),
                         quarters(Period)))

gdp <- as_ts(gdp_data, "gdp")

save(gdp, file = "Data/GDP data.RData")

# CPI data ---


statssa_data <- read_econdata(agencyid = "ECONDATA",
                              id = "CPI_ANL_SERIES",
                              version = "2.2",
                              key = "CPS00000+CPS00014",
                              provideragencyid = "ECONDATA",
                              providerid = "STATSSA",
                              releasedescription = "newest")

cpi_headline <- tibble(Period = rownames(statssa_data$CPS00000),
                       Value = statssa_data$CPS00000$OBS_VALUE,
                       Label = "cpi")

cpi_core <- tibble(Period = rownames(statssa_data$CPS00014),
               Value = statssa_data$CPS00014$OBS_VALUE,
               Label = "core")

statssa_data <- read_econdata(agencyid = "ECONDATA",
                              id = "BUSINESS_CYCLES",
                              version = "1.0",
                              key = "LABP130.Q.S",
                              releasedescription = "newest")

wages_nominal <- tibble(Period = rownames(statssa_data$LABP130.Q.S),
                        Value = statssa_data$LABP130.Q.S$OBS_VALUE,
                        Label = "wages")

hist_data <- read_csv("Data/Historical data.csv", 
                     show_col_types = FALSE) %>%
  select(-Code) %>%
  rbind(cpi_headline,
        cpi_core,
        wages_nominal) %>%
  mutate(Period = as.Date(Period)) %>%
  group_by(Label, Period) %>%
  summarise(Value = first(Value)) %>%
  ungroup() %>%
  mutate(Quarter = paste(format(Period, format = "%Y"),
                         quarters(Period))) %>%
  group_by(Label, Quarter) %>%
  summarise(Value = mean(Value)) %>%
  ungroup()

cpi <- log(as_ts(hist_data, "cpi", TRUE)) * 100

core_tmp <- as_ts(hist_data, "core")
core_hist <- window(as_ts(hist_data, "core_hist"), end  = start(core_tmp))
g <- stats::lag(core_hist, -1) / core_hist
for (period in rev(time(g))) {
  window(core_tmp, start = period, end = period, extend = TRUE) <-
    window(stats::lag(core_tmp, 1), start = period, end = period) * 
    window(g, start = period, end = period)
}
core <- (log(core_tmp) * 100) %>%
  seas() %>%
  series("seats.trend")

cpi_data <- cbind(cpi,
                  core)

save(cpi_data, file = "Data/CPI data.RData")

# Phillips curve data

inf2year <- as_ts(hist_data, "infexpectations")
wages <- (log(as_ts(hist_data, "wages")) * 100) - cpi
reer <- log(as_ts(hist_data, "reer")) * 100

pc_data <- cbind(cpi,
                 inf2year,
                 wages,
                 reer)

plot(pc_data)

save(pc_data, file = "Data/Phillips curve data.RData")
