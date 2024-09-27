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

# Report total number of missing values -- referenced in paper.pdf dataset description
length(which(is.na(raw_data)))

cleaned_data <-
  raw_data |>
  janitor::clean_names() |> 
  separate(col = date,
           into = c("year", "month"),
           sep = "-") |>
  separate(col = time,
           into = c("hour"),
           sep = ":") |>
  mutate(season = case_when(
    month %in% c("03", "04", "05") ~ "Spring",  # March, April, May
    month %in% c("06", "07", "08") ~ "Summer",  # June, July, August
    month %in% c("09", "10", "11") ~ "Fall",     # September, October, November
    month %in% c("12", "01", "02") ~ "Winter"    # December, January, February
  )) |>
  drop_na() |>
  filter(min_delay != 0) |>
  select(year, month, hour, incident, min_delay, line, season)

# Ensure that the numbers are converted to numeric from character (if that's the case)
cleaned_data$hour <- as.numeric(cleaned_data$hour)
cleaned_data$month <- as.numeric(cleaned_data$month)
cleaned_data$year <- as.numeric(cleaned_data$year)
cleaned_data$min_delay <- as.numeric(cleaned_data$min_delay)
cleaned_data$line <- as.numeric(cleaned_data$line)

nrow(cleaned_data)
# Since the delay time for some dates are over many hours, we will restrict
# ourselves to at most 2 hour delays in our study -- discussed in assumption section of the paper
cleaned_data <- cleaned_data |> filter(min_delay < 121)
nrow(cleaned_data)

# Check if any column contains NA data or not
any(is.na(cleaned_data))

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/cleaned_ttc_streetcar_delay_2023.csv")
