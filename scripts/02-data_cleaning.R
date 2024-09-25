#### Preamble ####
# Purpose: Cleans the raw data into appropriate formats and removing missing values
# Author: Aakash Vaithyanathan
# Date: September 24, 2024
# Contact: aakash.vaithyanathan@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
set.seed(20136)

#### Clean data ####
raw_data <- read_csv("data/raw_data/unedited_ttc_streetcar_delay_2023.csv")

cleaned_data <-
  raw_data |>
  janitor::clean_names() |> 
  separate(col = date,
           into = c("year", "month"),
           sep = "-") |>
  tidyr::drop_na() |>
  filter(min_delay != 0) |>
  filter(min_gap != 0) |>
  mutate(time = substr(time, 1, 5)) |>
  select(year, month, day, location, incident, min_delay, line)

# Check if any column contains NA data or not
any(is.na(cleaned_data))

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/cleaned_ttc_streetcar_delay_2023.csv")
