# BA900 extraction: Redmine Issue 2304

library(econdatar)
library(tidyverse)
library(openxlsx)

ba900 <- read_dataset(id = "BA900",
                      series_key = "TOT+NED+ABS+FRB+STB..",
                      tidy = TRUE,
                      wide = TRUE) %>%
    as_tibble()

banks <- names(ba900)[-1] %>%
    sub("^([^.]+)\\..*", "\\1", .) %>%
    unique()

column_labels <- function(cols) {
    map_chr(cols, \(col) attr(ba900[[col]], "label") %||% "")
}

wb <- createWorkbook()

walk(banks, \(bank) {
    bank_cols <- grep(paste0("^", bank, "\\."), names(ba900), value = TRUE)
    sheet_data <- ba900 %>% select(time_period, all_of(bank_cols))

    addWorksheet(wb, bank)
    writeData(wb, bank, t(names(sheet_data)), startRow = 1, colNames = FALSE)
    writeData(wb, bank, t(column_labels(names(sheet_data))), startRow = 2, colNames = FALSE)
    writeData(wb, bank, sheet_data, startRow = 3, colNames = FALSE)
})

saveWorkbook(wb, "../ba900.xlsx", overwrite = TRUE)
