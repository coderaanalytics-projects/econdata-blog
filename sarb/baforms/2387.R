# BA900 lending extract: Redmine Issue 2387
#
# Liabilities allocated for lending: item 1, Total deposits (A7.L001)
# Assets utilised for lending: item 110, Total assets (F5.L110)
# Market share = 100 * bank / industry total (TOT)

library(econdatar)
library(fastverse)
library(openxlsx)

set_collapse(mask = c("manip", "helper", "special"), nthreads = 4, sort = FALSE)

this_file <- local({
    args <- commandArgs(trailingOnly = FALSE)
    file_arg <- grep("^--file=", args, value = TRUE)
    if (length(file_arg)) {
        return(normalizePath(sub("^--file=", "", file_arg)))
    }
    if (sys.nframe() > 0 && !is.null(sys.frame(1)$ofile)) {
        return(normalizePath(sys.frame(1)$ofile))
    }
    normalizePath("sarb/baforms/2387.R", mustWork = FALSE)
})
outdir <- dirname(this_file)

start_date <- as.Date("2008-07-01")
end_date <- as.Date("2025-12-01")

banks <- c(ABS = "Absa", FRB = "Firstrand", NED = "Nedbank",
           STB = "Standard Bank", TOT = "Total for the Industry")
bank_order <- names(banks)

wanted <- c(sprintf("%s.A7.L001", bank_order),
            sprintf("%s.F5.L110", bank_order))

ba900 <- read_dataset(id = "BA900",
                      series_key = "ABS+FRB+NED+STB+TOT.A7+F5.L001+L110",
                      start_date = as.character(start_date),
                      wide = FALSE,
                      combine = FALSE,
                      tidy = TRUE)

dt <- qDT(ba900$data)
dt <- fsubset(dt, series_key %in% wanted &
                  time_period >= start_date &
                  time_period <= end_date)

stopifnot(nrow(dt) > 0L)

dt[, `:=`(bank = sub("\\..*", "", as.character(series_key)),
          line = sub(".*\\.", "", as.character(series_key)))]

liab <- pivot(fsubset(dt, line == "L001"),
              ids = "time_period", names = "bank", values = "obs_value",
              how = "wider")
aset <- pivot(fsubset(dt, line == "L110"),
              ids = "time_period", names = "bank", values = "obs_value",
              how = "wider")

liab <- get_vars(liab, c("time_period", bank_order))
aset <- get_vars(aset, c("time_period", bank_order))
setnames(liab, bank_order, paste0("liab_", bank_order))
setnames(aset, bank_order, paste0("aset_", bank_order))

wide <- join(liab, aset, on = "time_period", how = "inner",
             validate = "1:1", verbose = 0)
wide <- roworder(wide, -time_period)

for (b in bank_order) {
    wide[, (paste0("liab_share_", b)) := 100 * get(paste0("liab_", b)) / liab_TOT]
}
for (b in bank_order) {
    wide[, (paste0("aset_share_", b)) := 100 * get(paste0("aset_", b)) / aset_TOT]
}
setcolorder(wide, c(
    "time_period",
    paste0("liab_", bank_order),
    paste0("aset_", bank_order),
    paste0("liab_share_", bank_order),
    paste0("aset_share_", bank_order)
))

n_months <- length(seq(start_date, end_date, by = "month"))
stopifnot("missing months" = uniqueN(wide$time_period) == n_months)
stopifnot("bank exceeds industry liabilities" =
              all(wide$liab_ABS <= wide$liab_TOT, na.rm = TRUE) &&
              all(wide$liab_FRB <= wide$liab_TOT, na.rm = TRUE) &&
              all(wide$liab_NED <= wide$liab_TOT, na.rm = TRUE) &&
              all(wide$liab_STB <= wide$liab_TOT, na.rm = TRUE))
stopifnot("bank exceeds industry assets" =
              all(wide$aset_ABS <= wide$aset_TOT, na.rm = TRUE) &&
              all(wide$aset_FRB <= wide$aset_TOT, na.rm = TRUE) &&
              all(wide$aset_NED <= wide$aset_TOT, na.rm = TRUE) &&
              all(wide$aset_STB <= wide$aset_TOT, na.rm = TRUE))

big4_liab <- wide$liab_share_ABS + wide$liab_share_FRB +
    wide$liab_share_NED + wide$liab_share_STB
big4_aset <- wide$aset_share_ABS + wide$aset_share_FRB +
    wide$aset_share_NED + wide$aset_share_STB
stopifnot("implausible Big-4 liability shares" =
              min(big4_liab, na.rm = TRUE) >= 80 &&
              max(big4_liab, na.rm = TRUE) <= 95)
stopifnot("implausible Big-4 asset shares" =
              min(big4_aset, na.rm = TRUE) >= 80 &&
              max(big4_aset, na.rm = TRUE) <= 95)

csv_names <- c(
    time_period = "date",
    liab_ABS = "liab_absa", liab_FRB = "liab_firstrand",
    liab_NED = "liab_nedbank", liab_STB = "liab_standard_bank",
    liab_TOT = "liab_industry",
    aset_ABS = "aset_absa", aset_FRB = "aset_firstrand",
    aset_NED = "aset_nedbank", aset_STB = "aset_standard_bank",
    aset_TOT = "aset_industry",
    liab_share_ABS = "liab_share_absa", liab_share_FRB = "liab_share_firstrand",
    liab_share_NED = "liab_share_nedbank", liab_share_STB = "liab_share_standard_bank",
    liab_share_TOT = "liab_share_industry",
    aset_share_ABS = "aset_share_absa", aset_share_FRB = "aset_share_firstrand",
    aset_share_NED = "aset_share_nedbank", aset_share_STB = "aset_share_standard_bank",
    aset_share_TOT = "aset_share_industry"
)

csv_out <- copy(wide)
setnames(csv_out, names(csv_names), unname(csv_names))
csv_path <- file.path(outdir, "2387_ba900_lending.csv")
fwrite(csv_out, csv_path)

xlsx_path <- file.path(outdir, "2387_ba900_lending.xlsx")
wb <- createWorkbook()
addWorksheet(wb, "Data")

group_headers <- c(
    "",
    rep("Value of Liabilities allocated for lending (R thousands)", 5),
    rep("Value of Assets utilised for lending (R thousands)", 5),
    rep("Market Share (%) of Liabilities allocated for Lending", 5),
    rep("Market Share (%) of Assets utilised for lending", 5)
)
bank_headers <- c("Date", rep(unname(banks), 4))

writeData(wb, "Data", t(group_headers), startRow = 1, colNames = FALSE)
writeData(wb, "Data", t(bank_headers), startRow = 2, colNames = FALSE)
writeData(wb, "Data", wide, startRow = 3, colNames = FALSE)

merge_groups <- list(2:6, 7:11, 12:16, 17:21)
for (cols in merge_groups) {
    mergeCells(wb, "Data", cols = cols, rows = 1)
}

header_style <- createStyle(textDecoration = "bold", wrapText = TRUE,
                            halign = "center", valign = "center")
date_style <- createStyle(numFmt = "YYYY-MM")
value_style <- createStyle(numFmt = "#,##0")
share_style <- createStyle(numFmt = "0.00")

addStyle(wb, "Data", header_style, rows = 1:2, cols = 1:21, gridExpand = TRUE)
addStyle(wb, "Data", date_style, rows = 3:(nrow(wide) + 2), cols = 1)
addStyle(wb, "Data", value_style, rows = 3:(nrow(wide) + 2), cols = 2:11,
         gridExpand = TRUE)
addStyle(wb, "Data", share_style, rows = 3:(nrow(wide) + 2), cols = 12:21,
         gridExpand = TRUE)
setRowHeights(wb, "Data", rows = 1, heights = 36)
setColWidths(wb, "Data", cols = 1, widths = 12)
setColWidths(wb, "Data", cols = 2:21, widths = 16)
freezePane(wb, "Data", firstActiveRow = 3, firstActiveCol = 2)

addWorksheet(wb, "Notes")
notes <- data.frame(
    Field = c(
        "Source",
        "Dataflow",
        "Period",
        "Units",
        "Liabilities allocated for lending",
        "Series keys (liabilities)",
        "Assets utilised for lending",
        "Series keys (assets)",
        "Market share",
        "Industry total",
        "Banks",
        "Redmine"
    ),
    Detail = c(
        "EconData (SARB BA900)",
        "BA900",
        "Monthly, December 2025 back to July 2008",
        "R thousands, as published on form BA900 (unit multiplier 3)",
        "BA900 item 1, Total deposits column: Deposits (total of items 2 and 32)",
        paste(sprintf("%s.A7.L001", bank_order), collapse = ", "),
        paste("BA900 item 110, Total assets column: Deposits, loans and advances",
              "(items 111, 117, 118, 126, 135, 139, 150, 166, 171, 180 less 194).",
              "Includes interbank deposits/loans."),
        paste(sprintf("%s.F5.L110", bank_order), collapse = ", "),
        "100 * bank / industry total (TOT)",
        "TOT is the BA900 industry aggregate, not the sum of the four banks",
        "Absa (ABS), Firstrand (FRB), Nedbank (NED), Standard Bank (STB), Total (TOT)",
        "2387"
    )
)
writeData(wb, "Notes", notes)
setColWidths(wb, "Notes", cols = 1, widths = 40)
setColWidths(wb, "Notes", cols = 2, widths = 110)
addStyle(wb, "Notes", createStyle(textDecoration = "bold"),
         rows = 1, cols = 1:2, gridExpand = TRUE)

saveWorkbook(wb, xlsx_path, overwrite = TRUE)

message("Wrote ", csv_path)
message("Wrote ", xlsx_path)
message("Months: ", nrow(wide),
        " | Big-4 liability share range: ",
        sprintf("%.1f-%.1f%%", min(big4_liab), max(big4_liab)),
        " | Big-4 asset share range: ",
        sprintf("%.1f-%.1f%%", min(big4_aset), max(big4_aset)))
