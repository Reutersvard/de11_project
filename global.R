# Libraries ---------------------------------------------------------------

library(shiny)
library(tidyverse)
library(leaflet)
library(tsibble)
library(janitor)
library(shinythemes) # Themes maybe?
library(ggthemes) 

library(CodeClanData) # Example data


# Data reading & cleaning -------------------------------------------------

whisky_df <-CodeClanData::whisky %>% 
  rename(long = Latitude,
         lat = Longitude)

hospita_activity <- read_csv("raw_data/hospital_activity.csv") %>% clean_names()