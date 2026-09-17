# Live PPI weights from EconData

if (TRUE) {
  library(econdatar)
  library(dplyr)
}

ppi <- read_dataset("PPI",
                    tidy = TRUE,
                    wide = FALSE,
                    combine = FALSE,
                    prettify = FALSE)

weights <- as_tibble(ppi$metadata) %>%
  transmute(series_key,
            mnemonic,
            basket,
            activity,
            source_identifier,
            label,
            base_per,
            weight = as.numeric(weight)) %>%
  filter(!is.na(weight))

agriculture <- filter(weights, basket == "AGRICULTURE")
mining <- filter(weights, basket == "MINING")
final_manufactured <- filter(weights, basket == "FINAL")
intermediate <- filter(weights, basket == "INTERMEDIATE")
electricity_and_water <- filter(weights, basket == "ELECTRICITY")

write.csv(weights, "statssa/ppi/ppi_weights.csv", na = "", row.names = FALSE)
write.csv(agriculture, "statssa/ppi/ppi_agriculture.csv", na = "", row.names = FALSE)
write.csv(mining, "statssa/ppi/ppi_mining.csv", na = "", row.names = FALSE)
write.csv(final_manufactured, "statssa/ppi/ppi_final_manufactured.csv", na = "", row.names = FALSE)
write.csv(intermediate, "statssa/ppi/ppi_intermediate_manufactured.csv", na = "", row.names = FALSE)
write.csv(electricity_and_water, "statssa/ppi/ppi_electricity_and_water.csv", na = "", row.names = FALSE)
