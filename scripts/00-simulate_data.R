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
# Set the number of random dates you want to generate
num_rows <- 100

data <-
  tibble(
    year = 2023,
    month = as.integer(runif(
      n = num_rows,
      min = 1,
      max = 12
    )),
    hour = as.integer(runif(
      n = num_rows,
      min = 0,
      max = 23
    )),
    delay_mins = as.integer(runif(
      n = num_rows,
      min = 1,
      max = 120
    )),
    streetcar_line = sample(
      c(504, 505, 506, 511, 304, 305, 311, 9000),
      size = num_rows, replace = TRUE
      ),
    reason = sample(
      c("Traffic", "Emergency", "Weather", "Route Change"), 
      size = num_rows, replace = TRUE
      )
  )


#### Write_csv
write_csv(data, file = "data/simulated_data/simulated_streetcar_delay.csv")



