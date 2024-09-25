#### Preamble ####
# Purpose: Simulates sample data for delay in TTC streetcars
# Author: Aakash Vaithyanathan
# Date: September 24, 2024
# Contact: aakash.vaithyanathan@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
set.seed(20136)

#### Simulate data ####
# Define the start and end date
start_date <- as.Date("2023-01-01")
end_date <- as.Date("2023-12-31")

# Set the number of random dates you want to generate
number_of_dates <- 100
from_stations <- c("Finch", "Sheppard Yongue", "Lawrence Station", "Bloor Station")
to_stations <- c("St George Station", "Union Station", "Queen Station", "Dundas West", "Museum")

data <-
  tibble(
    dates = as.Date(
      runif(
        n = number_of_dates,
        min = as.numeric(start_date),
        max = as.numeric(end_date)
      ),
    ),
    delay_mins = rpois(n = number_of_dates, lambda = 20),
    day = weekdays(dates),
    reason = sample(
      c("Traffic", "Emergency", "Weather", "Route Change"), 
      size = number_of_dates, replace = TRUE
      ),
    from_station = sample(from_stations, 
                          size = number_of_dates, 
                          replace = TRUE
    ),
    to_station = sample(to_stations, 
                        size = number_of_dates, 
                        replace = TRUE
    ),
  )


#### Write_csv
write_csv(data, file = "data/raw_data/simulated_streetcar_delay.csv")



