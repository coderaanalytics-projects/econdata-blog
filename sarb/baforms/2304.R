# BA form extractions: Redmine Issue 2304

library(econdatar)
library(tidyverse)
library(openxlsx)

export_baform <- function(id, v = "latest", outfile) {
    data <- read_dataset(id = id,
                         version = v,
                         series_key = "TOT+NED+ABS+FRB+STB..",
                         tidy = TRUE,
                         wide = TRUE) %>%
        as_tibble()

    banks <- names(data)[-1] %>%
        sub("^([^.]+)\\..*", "\\1", .) %>%
        unique()

    column_labels <- function(cols) {
        map_chr(cols, \(col) attr(data[[col]], "label") %||% "")
    }

    wb <- createWorkbook()

    walk(banks, \(bank) {
        bank_cols <- grep(paste0("^", bank, "\\."), names(data), value = TRUE)
        sheet_data <- data %>% select(time_period, all_of(bank_cols))

        addWorksheet(wb, bank)
        writeData(wb, bank, t(names(sheet_data)), startRow = 1, colNames = FALSE)
        writeData(wb, bank, t(column_labels(names(sheet_data))), startRow = 2, colNames = FALSE)
        writeData(wb, bank, sheet_data, startRow = 3, colNames = FALSE)
    })

    saveWorkbook(wb, outfile, overwrite = TRUE)
}

export_baform("BA900", "../ba900.xlsx")
export_baform("BA700", "../ba700.xlsx")

export_baform("BA700", v = "1.0.0", "../ba700_1.0.0.xlsx")
