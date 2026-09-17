# Live PPI weights from EconData
# Output: statssa/ppi/ppi_weights.csv

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
            activity,
            source_identifier,
            label,
            base_per,
            weight = as.numeric(weight)) %>%
  filter(!is.na(weight))

weight_sum <- sum(weights$weight)
message("Weight sum: ", weight_sum)
stopifnot(abs(weight_sum - 500) < 0.01)

write.csv(weights,
          file = "statssa/ppi/ppi_weights.csv",
          na = "",
          row.names = FALSE)
