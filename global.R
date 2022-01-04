# Libraries ---------------------------------------------------------------

library(shiny)
library(tidyverse)
library(leaflet)
library(tsibble)
library(janitor)
library(shinythemes) # Themes maybe?
library(ggthemes)
library(infer)
library(lubridate)
library(shinydashboard)

# Source scripts & read clean data ----------------------------------------

source("scripts/clean_data.R")
clean_beds <- read_csv("clean_data/clean_beds.csv")

