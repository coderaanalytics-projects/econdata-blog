# Join the public finance dataflows together

packages <- c("econdatar",
            #  "dplyr",
            #  "readxl",
              "tidyverse"   )
invisible(lapply(packages, library, c=TRUE))

treasury_full <- tibble()

for (NTflow in c(   "GOVTBUDGET",
                    "GOVTREVENUE",
                    "GOVTTRANSFERS",
                    "GOVT_CON_ECON",
                    "GOVT_CON_BUDGET",
                    "GOVTDEBT",
                    "GOVTGUARANTEES",
                    "GOVTANNEX_CONS",
                    "GOVTANNEX_PROV"    )) {
    if (exists("treasury_table")) rm(treasury_table)
    treasury_table <- read_dataset( id    = NTflow,
                                    release = "latest",
                                    tidy    = TRUE,
                                    wide    = FALSE,
                                    combine = TRUE  ) |>
                    select(-data_provider_ref)

    treasury_full <- treasury_full |> bind_rows(treasury_table)
}

print(unique(treasury_full$budget_table) |> sort())
