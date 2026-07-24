# Minimal LOCAL_FLOWS sample: one quarter per sector-split dataflow.
# Output: asisa/flows_sample.xlsx (overview sheet + one sheet per dataflow).

library(econdatar)
library(tidyverse)
library(openxlsx)

outfile <- file.path("asisa", "flows_sample.xlsx")

dataset_constant_cols <- c(
  "data_set_ref",
  "data_set_name",
  "data_set_description",
  "data_provider_ref",
  "provision_agreement_ref"
)

flows_ids <- read_database(id = "all") %>%
  as_tibble() %>%
  filter(str_detect(id, "^LOCAL_FLOWS_")) %>%
  arrange(id) %>%
  pull(id)

if (length(flows_ids) == 0) {
  stop("No LOCAL_FLOWS_* datasets found in read_database(id = \"all\").")
}

message("Found ", length(flows_ids), " flows dataflow(s): ", paste(flows_ids, collapse = ", "))

probe <- read_dataset(
  id = flows_ids[[1]],
  series_key = "TDC..",
  tidy = TRUE,
  wide = FALSE,
  combine = TRUE
) %>%
  as_tibble()

sample_period <- max(probe$time_period, na.rm = TRUE)
message("Sample period: ", sample_period)

pull_flows_sample <- function(id, period) {
  tryCatch(
    read_dataset(
      id = id,
      tidy = TRUE,
      wide = FALSE,
      combine = TRUE,
      start_date = period,
      end_date = period
    ) %>%
      as_tibble(),
    error = function(e) {
      warning("Failed to load ", id, ": ", conditionMessage(e))
      NULL
    }
  )
}

split_dataset_constants <- function(df, id) {
  present <- intersect(dataset_constant_cols, names(df))
  overview <- df %>%
    distinct(across(all_of(present))) %>%
    mutate(dataflow_id = id) %>%
    relocate(dataflow_id, .before = everything())

  observations <- df %>%
    select(-any_of(dataset_constant_cols))

  list(overview = overview, observations = observations)
}

samples <- map(flows_ids, pull_flows_sample, period = sample_period)
names(samples) <- flows_ids

samples <- samples[!map_lgl(samples, is.null)]
if (length(samples) == 0) {
  stop("No flows datasets could be loaded for period ", sample_period, ".")
}

split_samples <- map2(samples, names(samples), split_dataset_constants)

overview <- map_dfr(split_samples, "overview") %>%
  distinct()

wb <- createWorkbook()
addWorksheet(wb, "datasets")
writeData(wb, "datasets", overview)

walk(names(samples), function(id) {
  sheet_data <- split_samples[[id]]$observations
  addWorksheet(wb, id)
  writeData(wb, id, sheet_data)
})

saveWorkbook(wb, outfile, overwrite = TRUE)
message("Wrote ", outfile, " (", length(samples) + 1L, " sheets, period ", sample_period, ").")
