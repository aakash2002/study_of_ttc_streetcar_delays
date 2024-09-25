#### Preamble ####
# Purpose: Downloads and saves the data from OpenToronto
# Author: Aakash Vaithyanathan
# Date: September 24, 2024
# Contact: aakash.vaithyanathan@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
set.seed(20136)

#### Download data ####
# get package
package <- show_package("b68cb71b-44a7-4394-97e2-5d2f41462a5d")

# get all resources for this package
resources <- list_package_resources("b68cb71b-44a7-4394-97e2-5d2f41462a5d")
datastore_resources <- filter(resources, tolower(format) == 'xlsx')

# Load data for delays in the year of 2023
delay_data_2023 <- filter(datastore_resources,
                               name == "ttc-streetcar-delay-data-2023") %>% get_resource()


#### Save data ####
write_csv(delay_data_2023, "data/raw_data/unedited_ttc_streetcar_delay_2023.csv") 

         
