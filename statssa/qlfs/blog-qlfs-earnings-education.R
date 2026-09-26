# Bar chart of mean earnings by education, from the QLFS
# Codera Analytics https://econdata.co.za

# 1. Load R packages (run install.packages() if you don't have one of these installed already)
library(tidyverse)
library(econdatar)  # library(remotes) then install_github("coderaanalytics/econdatar@4.0.4")

# 2. Extract QLFS mean real earnings (WRML) and employment (EMPL) by education
# LABSTAT.CATEGORY.AREA.SEX  -  use + within a dimension, . between dimensions
qlfs <- read_dataset("QLFS",
    tidy = TRUE,
    wide = FALSE,
    combine = TRUE,
    series_key = "WRML+EMPL.ENONE+ELTPS+EPRIM+ESNOT+ESECD+ETERT.SA.A"
) %>% as_tibble()

# 3. Split the series key into dimension codes
qlfs <- qlfs %>%
  separate(series_key, into = c("labstat", "category", "area", "sex"),
           sep = "\\.", remove = FALSE)

edu_labels <- c(
  ENONE = "No schooling",
  ELTPS = "Less than primary completed",
  EPRIM = "Primary completed",
  ESNOT = "Secondary not completed",
  ESECD = "Secondary completed",
  ETERT = "Tertiary"
)

# 4. Latest calendar year with four non-missing earnings quarters for every education group
n_edu <- length(edu_labels)
latest_year <- qlfs %>%
  filter(labstat == "WRML", !is.na(obs_value)) %>%
  mutate(year = year(time_period)) %>%
  distinct(year, category, time_period) %>%
  count(year, category, name = "n_quarters") %>%
  group_by(year) %>%
  filter(n() == n_edu, all(n_quarters == 4)) %>%
  ungroup() %>%
  summarise(year = max(year), .groups = "drop") %>%
  pull(year)

# 5. Employment-weighted mean of the quarterly means, for that year
earnings_edu <- qlfs %>%
  mutate(year = year(time_period)) %>%
  filter(year == latest_year) %>%
  select(time_period, labstat, category, obs_value) %>%
  pivot_wider(names_from = labstat, values_from = obs_value) %>%
  group_by(category) %>%
  summarise(
    mean_earnings = weighted.mean(WRML, w = EMPL, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(education = factor(edu_labels[category], levels = unname(edu_labels)))

# 6. Headline CPI (public), and inflate from the QLFS earnings base period
#    to the latest CPI month available
cpi <- read_dataset("CPI_ANL_SERIES",
    tidy = TRUE,
    wide = FALSE,
    combine = TRUE,
    series_key = "CPS00000"
) %>% as_tibble()

earnings_base <- qlfs %>%
  filter(labstat == "WRML") %>%
  distinct(base_period) %>%
  pull(base_period) %>%
  as.character() %>%
  unique()

cpi_base_date <- dmy(paste("01", earnings_base[[1]]))
cpi_latest_row <- cpi %>% filter(time_period == max(time_period))
cpi_base_row <- cpi %>% filter(time_period == cpi_base_date)
inflate <- cpi_latest_row$obs_value / cpi_base_row$obs_value

cpi_month_label <- format(cpi_latest_row$time_period, "%B %Y")

earnings_edu <- earnings_edu %>%
  mutate(mean_earnings_latest = mean_earnings * inflate)

# 7. Build the ggplot chart
ggplot_earnings_edu <- ggplot(earnings_edu,
    aes(x = education, y = mean_earnings_latest / 1000)) +
    theme_minimal(base_size = 15) +
    geom_col(fill = "#273b8d", width = 0.7) +
    scale_y_continuous(
        expand = expansion(mult = c(0, 0.05)),
        labels = scales::label_comma(big.mark = " ")
    ) +
    coord_flip(ylim = c(0, NA), clip = "off") +
    theme(
        plot.title.position = "plot",
        plot.caption.position = "plot",
        plot.caption = element_text(hjust = 0, margin = margin(b = 3, t = 9)),
        panel.grid.major.y = element_blank(),
        axis.title.y = element_blank(),
        plot.margin = margin(t = 3, r = 8, b = 3, l = 3, unit = "mm")
    ) +
    labs(
        y = "Thousands of rands per month",
        title = "Mean monthly earnings by education",
        caption = paste0(
            "Source: StatsSA QLFS (PALMS), StatsSA CPI; EconData\n",
            latest_year, " employment-weighted mean, inflated to ",
            cpi_month_label, " prices"
        )
    )
    # codera_logo(xpos = 0.82, ypos = 0.18, wdth = 6)

# Add Codera logo for the published blog figure
custom_base_size <- 13
source(file.path(Sys.getenv("ECONDATA_AUTOVIZ"), "utils.R"))
ggplot_earnings_edu <- ggplot_earnings_edu +
  codera_logo(data = earnings_edu, xpos = 0.82, ypos = 0.18, wdth = 6)

# 8. Export the ggplot object to a file
ggsave(
  filename = "statssa/qlfs/qlfs_mean_earnings_education.jpg",
  plot = ggplot_earnings_edu,
  width = 17.5,
  height = 11.5,
  units = "cm"
)
