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

#### Test data for cleaned dataset ####
data <- read_csv("data/analysis_data/cleaned_ttc_streetcar_delay_2023.csv")

# Test for whether any column has missing/NA values
any(is.na(data))

# Check if all the datatypes are of valid type
if (!is.character(data$season)) stop("seasons should be character")
if (!is.numeric(data$line)) stop("line should be numeric")
if (!is.numeric(data$min_delay)) stop("min_delay should be numeric")
if (!is.numeric(data$year)) stop("year should be numeric")
if (!is.numeric(data$month)) stop("month should be numeric")
if (!is.numeric(data$hour)) stop("hour should be numeric")
if (!is.character(data$incident)) stop("incident should be character")

# Check if months are within valid range
if (any(data$month < 1 | data$month > 12)) stop("Month values must be between 1 and 12")

# Check if year is 2023
if (any(data$year != 2023)) stop("Year should be 2023")

# Check hour values in military style
if (any(data$hour < 0 | data$hour > 23)) stop("Hour values must be between 0 and 23")

# Check min_delay is at least 1 minute
if (any(data$min_delay < 0)) stop("Delays must be non-negative")

# Check min_delay is not greater than 120 mins as per the assumption specified
if (any(data$min_delay > 120)) stop("Delays must be less than 120 minutes")

# Check seasons
valid_seasons <- c("Winter", "Spring", "Summer", "Fall")
if (any(!data$season %in% valid_seasons)) stop("Invalid season values detected")

# Check incident descriptions
if (any(nchar(data$incident) == 0)) stop("Incident descriptions must be non-empty")
