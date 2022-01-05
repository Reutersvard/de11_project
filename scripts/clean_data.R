# All cleaning and wrangling goes here

activity_specialty <- read_csv("raw_data/activity_specialty.csv") %>%
  clean_names()

# Beds cleaning script -----------------------------
beds_specialty <- read_csv("raw_data/beds_specialty.csv") %>%
  clean_names()

clean_beds <- beds_specialty %>%
  filter(specialty == "CC", location_qf == "d") %>% 
  mutate(winter_flag = if_else(
    str_detect(quarter, "Q1") | str_detect(quarter, "Q4"), "yes", "no"
    ))

write_csv(clean_beds, "clean_data/clean_beds.csv")
rm(beds_specialty, clean_beds)

# A&E cleaning script ----------------------------
ae <- read_csv("raw_data/monthly_ae_waitingtimes_202110.csv")

clean_ae <- ae <- read_csv("raw_data/ane_activity.csv") %>% clean_names() %>% 
  mutate(date = ym(month),
         year = year(date),
         month = month(date))

write_csv(clean_ae, "clean_data/clean_ae.csv")


# Beds cleaning script for overview --------------------------------------------

beds_specialty_data <- read_csv("raw_data/beds_by_nhs_board_of_treatment_and_specialty.csv")
clean_beds_specialty_data <- beds_specialty_data %>% 
  clean_names() %>% 
  mutate(q = str_sub(quarter, -2),
         quarter = yq(quarter),
         date = quarter,
         quarter = q) %>%
  mutate(hb = if_else(hb %in% "S08000015", "Ayrshire & Arran",
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
              ))))))))))))))) %>% 
  filter(location_qf == "d")  %>% 
  filter(hb != is.na(hb))

write_csv(clean_beds_specialty_data, "clean_data/clean_beds_speciality_data.csv")

# Admissions cleaning script for overview --------------------------------------

admissions <- read_csv("raw_data/inpatient_and_daycase_by_nhs_board_of_treatment_and_specialty.csv")

clean_admissions <- admissions %>% 
  clean_names() %>% 
  mutate(q = str_sub(quarter, -2)) %>% 
  mutate(quarter = yq(quarter)) %>% 
  mutate(date = quarter,
         quarter = q) %>% 
  mutate(hb = if_else(hb %in% "S08000015", "Ayrshire & Arran",
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
          ))))))))))))))) %>% 
  filter(location_qf == "d") %>% 
  filter(hb != is.na(hb))

write_csv(clean_admissions, "clean_data/clean_admissions_speciality_data.csv")
