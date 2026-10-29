# GOVTPROV series and dataset metadata
#
# User guide:
# https://econdata.co.za/user-guide/accounts/treasury/#GOVTPROV
#
# GOVTPROV is EconData's largest dataset.
# Downloading the full dataflow takes about 13 minutes. 
# Combining each series with its time periods gives
# 1 138 414 observations (150 956 series in this extract).
#
# Do not download the whole dataflow for a project. Subset with series_key
# so the API returns only the series you need. The key has four dimensions,
# in order: province, sector and department, programme and subprogramme,
# economic group. Those codes are 2, 2, 4 and 4 characters. Use + to select
# several codes in one dimension, and . to separate dimensions. Leave a
# segment empty to keep every code in that dimension.
#
# Example: Western Cape and Gauteng health departments, all programmes and
# all economic groups (HH is Health; province codes are on
# CL_PROVINCE_2CHAR). That returns only those series, rather than the
# full 151 000.
#
# health <- read_dataset(
#   id = "GOVTPROV",
#   series_key = "WC+GP.HH..",
#   tidy = TRUE,
#   wide = FALSE,
#   combine = FALSE
# )
#
# The workbook written below is gitignored (treasury/govtprov_metadata.xlsx).

library(econdatar)
library(data.table)
library(openxlsx)

this_file <- local({
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)
  if (length(file_arg)) {
    return(normalizePath(sub("^--file=", "", file_arg)))
  }
  if (sys.nframe() > 0 && !is.null(sys.frame(1)$ofile)) {
    return(normalizePath(sys.frame(1)$ofile))
  }
  normalizePath("treasury/govtprov_metadata.R", mustWork = FALSE)
})
outfile <- file.path(dirname(this_file), "govtprov_metadata.xlsx")

message(paste(
  "Downloading GOVTPROV, EconData's largest dataset",
  "(about 151 000 series). A full download takes about 13 minutes."
))
download_start <- proc.time()[["elapsed"]]
govtprov <- read_dataset(
  id = "GOVTPROV",
  tidy = TRUE,
  wide = FALSE,
  combine = FALSE
)
download_minutes <- (proc.time()[["elapsed"]] - download_start) / 60

data <- setDT(govtprov$data)
# Dataset fields are length 1; series fields are one value per series.
# setDT() will not recycle those for a dataflow this large.
meta <- govtprov$metadata
if (!is.data.table(meta)) {
  n_meta <- max(lengths(meta))
  bad_len <- lengths(meta)
  bad_len <- bad_len[bad_len != 1L & bad_len != n_meta]
  if (length(bad_len)) {
    stop(
      "Metadata columns have unexpected lengths: ",
      paste(names(bad_len), bad_len, sep = "=", collapse = ", ")
    )
  }
  meta <- lapply(meta, function(col) {
    if (length(col) == 1L) rep_len(col, n_meta) else col
  })
}
meta <- setDT(meta)
rm(govtprov)

if (!"obs_status" %in% names(data)) {
  data[, obs_status := NA_character_]
}
setorder(data, series_key, time_period)

n_observations <- nrow(data)
latest <- data[, .(
  latest_period = time_period[.N],
  latest_value = obs_value[.N],
  latest_obs_status = obs_status[.N]
), by = series_key]
rm(data)
gc()

latest[, series_key := as.character(series_key)]
meta[, series_key := as.character(series_key)]
n_series <- uniqueN(meta$series_key)

dataset_cols <- intersect(
  c(
    "data_set_name",
    "data_set_ref",
    "data_set_description",
    "provision_agreement_ref",
    "data_provider_ref",
    "source_data_set"
  ),
  names(meta)
)
dataset_meta <- unique(meta[, .SD, .SDcols = dataset_cols])
# These three are measured on this extract. They are not SDMX attributes.
dataset_meta[, `:=`(
  n_series = n_series,
  n_observations = n_observations,
  download_minutes = round(download_minutes, 1)
)]

series <- meta[, .SD, .SDcols = setdiff(names(meta), dataset_cols)]
rm(meta)
series[latest, on = "series_key", `:=`(
  latest_period = i.latest_period,
  latest_value = i.latest_value,
  latest_obs_status = i.latest_obs_status
)]
rm(latest)

front <- c(
  "series_key", "label", "south_african_province", "table", "division",
  "group", "section", "latest_period", "latest_value", "latest_obs_status"
)
setcolorder(series, c(intersect(front, names(series)),
                       setdiff(names(series), front)))
setorder(series, series_key)

message(sprintf(
  "Writing %s series (%s observations) to Excel...",
  format(n_series, big.mark = " ", scientific = FALSE),
  format(n_observations, big.mark = " ", scientific = FALSE)
))
wb <- createWorkbook()
modifyBaseFont(wb, fontSize = 10, fontName = "Arial")
header <- createStyle(
  fontName = "Arial",
  fontSize = 10,
  textDecoration = "bold"
)
addWorksheet(wb, "Series metadata")
addWorksheet(wb, "Dataset metadata")
writeData(wb, "Series metadata", series, headerStyle = header)
writeData(wb, "Dataset metadata", dataset_meta, headerStyle = header)
freezePane(wb, "Series metadata", firstRow = TRUE)
freezePane(wb, "Dataset metadata", firstRow = TRUE)
# addFilter() only covers a single row. Set the used range explicitly so
# Excel filters the whole table and readers do not stop at cell A1.
series_ref <- sprintf("A1:%s%d", LETTERS[ncol(series)], nrow(series) + 1L)
dataset_ref <- sprintf(
  "A1:%s%d", LETTERS[ncol(dataset_meta)], nrow(dataset_meta) + 1L
)
wb$worksheets[[1]]$dimension <- sprintf("<dimension ref=\"%s\"/>", series_ref)
wb$worksheets[[2]]$dimension <- sprintf("<dimension ref=\"%s\"/>", dataset_ref)
wb$worksheets[[1]]$autoFilter <- sprintf("<autoFilter ref=\"%s\"/>", series_ref)
wb$worksheets[[2]]$autoFilter <- sprintf("<autoFilter ref=\"%s\"/>", dataset_ref)

setColWidths(wb, "Series metadata", cols = seq_len(ncol(series)), widths = 22)
wide_cols <- intersect(c("label", "division", "group", "table"), names(series))
setColWidths(
  wb, "Series metadata",
  cols = match(wide_cols, names(series)),
  widths = c(label = 36, division = 42, group = 42, table = 32)[wide_cols]
)
setColWidths(
  wb, "Dataset metadata",
  cols = seq_len(ncol(dataset_meta)),
  widths = 28
)

saveWorkbook(wb, outfile, overwrite = TRUE)
# openxlsx writes dates as mm/dd/yyyy and leaves the value column as a
# general number. Switch the date format to ISO and give the latest value
# a thousands separator, using the column style so we do not restyle
# every cell.
patch_formats <- function(path, value_col) {
  tmp <- tempfile("govtprov-xlsx")
  dir.create(tmp)
  unzip(path, files = c("xl/styles.xml", "xl/worksheets/sheet1.xml"), exdir = tmp)

  styles <- file.path(tmp, "xl", "styles.xml")
  xml <- readChar(styles, file.info(styles)$size)
  xml <- gsub("mm/dd/yyyy", "yyyy-mm-dd", xml, fixed = TRUE)
  if (!grepl('numFmtId="3"', xml, fixed = TRUE)) {
    xml <- sub('<cellXfs count="3">', '<cellXfs count="4">', xml, fixed = TRUE)
    xml <- sub(
      "</cellXfs>",
      paste0(
        '<xf numFmtId="3" fontId="0" fillId="0" borderId="0" xfId="0" ',
        'applyFont="1" applyNumberFormat="1"></xf></cellXfs>'
      ),
      xml,
      fixed = TRUE
    )
  }
  writeBin(charToRaw(xml), styles)

  sheet <- file.path(tmp, "xl", "worksheets", "sheet1.xml")
  sxml <- readChar(sheet, file.info(sheet)$size)
  col_tag <- sprintf(
    '<col min="%d" max="%d" width="22.71" hidden="0" customWidth="1"/>',
    value_col, value_col
  )
  col_new <- sprintf(
    '<col min="%d" max="%d" width="22.71" hidden="0" customWidth="1" style="3"/>',
    value_col, value_col
  )
  sxml <- sub(col_tag, col_new, sxml, fixed = TRUE)
  writeBin(charToRaw(sxml), sheet)

  owd <- setwd(tmp)
  on.exit(setwd(owd), add = TRUE)
  zip(path, c("xl/styles.xml", "xl/worksheets/sheet1.xml"))
}
patch_formats(outfile, match("latest_value", names(series)))

message(sprintf("SERIES %s", format(n_series, big.mark = " ", scientific = FALSE)))
message(sprintf(
  "OBSERVATIONS %s",
  format(n_observations, big.mark = " ", scientific = FALSE)
))
message(sprintf("MINUTES %.1f", download_minutes))
message(sprintf("WROTE %s", outfile))
