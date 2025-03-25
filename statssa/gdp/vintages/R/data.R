# GDP vintages data ---
# https://econdata.co.za/making-use-of-vintage-data/

if (TRUE) {
library(econdatar)
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(stringr)
}

releases <- read_release(id = "NATL_ACC",
                         version = "all")

gdp_vintages <- tibble()
for (data_i in seq_len(length(releases))) {
  data_version <- names(releases)[[data_i]]
  cat(paste("\n", data_version, "\n"))
  dataset <- releases[[data_i]]
  for(release_i in seq_len(nrow(dataset))) {
    i <- slice(dataset, release_i)
    cat(paste(i$description, "\n"))
    natl_acc <- read_dataset(id = "NATL_ACC",
                            version = str_sub(data_version, 2, -1),
                            series_key = ifelse(as.numeric(str_sub(data_version, 2, 2)) >= 2,
                                        "PROD.GDP.Q.R.S",
                                        "KBP6006.R.S"),
                            release = i$description,
                            tidy = TRUE,
                            wide = FALSE,
                            combine = TRUE) %>%
        as_tibble() %>%
        mutate(description = i$description,
              release = i$release) %>%
        relocate(release, description, time_period, obs_value, series_name, series_key)
    gdp_vintages <- bind_rows(gdp_vintages, natl_acc)
  }
}
gdp_vintages <- gdp_vintages %>%
  arrange(release, time_period, series_key)

write_csv(gdp_vintages %>%
          pivot_wider(id_cols = everything(),
                      names_from = description,
                      values_from = obs_value),
          "realtimeGDP.csv")
