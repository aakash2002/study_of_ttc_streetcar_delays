#### Preamble ####
# Purpose: Tests whether simulated data contain valid entries or not
# Author: Aakash Vaithyanathan
# Date: September 24, 2024
# Contact: aakash.vaithyanathan@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
set.seed(20136)

#### Test data ####
data <- read_csv("data/raw_data/simulated_streetcar_delay.csv")

# Test for negative numbers in delay_mins column
data$delay_mins |> min() <= 0
# Test for NAs in delay_mins column
all(is.na(data$delay_mins))
# Test for NAs in date column
all(is.na(data$dates))
# Test for NAs in reason column
all(is.na(data$reason))
# Test for NAs in to_station column
all(is.na(data$to_station))
# Test for NAs in from_station column
all(is.na(data$from_station))
