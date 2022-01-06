# Libraries ---------------------------------------------------------------

library(shiny)
library(shinyWidgets)
library(janitor)
library(tidyverse)
library(leaflet)
library(infer)
library(shinydashboard)
library(sf)
library(rgdal)
library(lubridate)


# Source scripts & read clean data ----------------------------------------

# All cleaning was done in this script:
# source("scripts/clean_data.R")

source("scripts/theme_nhs.R")

clean_beds <- read_csv("clean_data/clean_beds.csv", lazy = F)
clean_ae <- read_csv("clean_data/clean_ae.csv", lazy = F)
clean_admissions <- read_csv("clean_data/clean_admissions.csv", lazy = F)
shapes <- st_read("clean_data/hb_clean.shp")
clean_inpatient <- read_csv("clean_data/clean_inpatient.csv", lazy = F)

# SelectInput Choices for global ------------------------------------------

new_clean_ae <- clean_ae %>%
  select(attendance_greater8hrs, attendance_greater12hrs)

new_admissions <- clean_admissions %>% 
  filter(hb != "Scotland")

# To filter out below
`%!in%` <- negate(`%in%`)

specialties <- clean_admissions %>% 
  select(specialty_name) %>% 
  filter(specialty_name %!in% c("Clinical Genetics", 
                         "Allergy", "Clinical Neurophysiology", 
                         "Genito-Urinary Medicine")) %>% 
  arrange(specialty_name)
