

library(janitor)
library(tidyverse)
library(lubridate)
library(here)

raw_activity <- read_csv(here(
  "raw_data/inpatient_and_daycase_by_nhs_board_of_treatment_and_specialty.csv"))


activity <- raw_activity %>% 
  clean_names() %>% 
  # Create new column for quarters
  mutate(q = str_sub(quarter, -2)) %>% 
  # Change to date format
  mutate(quarter = yq(quarter)) %>% 
  # rename the columns above 
  mutate(date = quarter,
         quarter = q) %>% 
  # Change Heath Board names to read better
  mutate(
    hb = if_else(hb %in% "SB0801", "Golden Jubilee",
                 if_else(hb %in% "S08000015", "Ayrshire & Arran",
                   if_else(hb %in% "S08000016", "Borders",
                   if_else(hb %in% "S08000017", "Dumfries & Galloway",
                   if_else(hb %in% "S08000019", "Forth Valley",
                   if_else(hb %in% "S08000020", "Grampian",
                   if_else(hb %in% "S08000022", "Highland",
                   if_else(hb %in% "S08000024", "Lothian",
                   if_else(hb %in% "S08000025", "Orkney",
                   if_else(hb %in% "S08000026", "Shetland",
                   if_else(hb %in% "S08000028", "Western Isles",
                   if_else(hb %in% "S08000029", "Fife",
                   if_else(hb %in% "S08000030", "Tayside",
                   if_else(hb %in% "S08000031", "Greater Glasgow & Clyde",
                   if_else(hb %in% "S08000032", "Lanarkshire",
                    if_else(hb %in% "S92000003", "Scotland", NA_character_)
                   )))))))))))))))) %>% 
  # Change location names to take out duplicate
  mutate(
    location = if_else(location %in% "SB0801", "Golden Jubilee",
                 if_else(location %in% "S08000015", "Ayrshire & Arran",
                 if_else(location %in% "S08000016", "Borders",
                 if_else(location %in% "S08000017", "Dumfries & Galloway",
                 if_else(location %in% "S08000019", "Forth Valley",
                 if_else(location %in% "S08000020", "Grampian",
                 if_else(location %in% "S08000022", "Highland",
                 if_else(location %in% "S08000024", "Lothian",
                 if_else(location %in% "S08000025", "Orkney",
                 if_else(location %in% "S08000026", "Shetland",
                 if_else(location %in% "S08000028", "Western Isles",
                 if_else(location %in% "S08000029", "Fife",
                 if_else(location %in% "S08000030", "Tayside",
                 if_else(location %in% "S08000031", "Greater Glasgow & Clyde",
                 if_else(location %in% "S08000032", "Lanarkshire",
                 if_else(location %in% "S92000003", "Scotland", NA_character_ 
                 ))))))))))))))))) %>%
  # filter out the na
  filter(location != is.na(location)) %>% 
  # take out unused columns
  # take out location to remove duplicate
  select(date, quarter, hb, admission_type, 
         specialty, specialty_name, episodes, 
         length_of_episode, average_length_of_episode, 
         spells, length_of_spell, average_length_of_spell)



write_csv(activity, "clean_data/inpatient_and_daycase_clean_data.csv")