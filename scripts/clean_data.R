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
  filter(location_qf == "d")

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
  filter(location_qf == "d")

write_csv(clean_admissions, "clean_data/clean_beds_speciality_data.csv")


# Admissions/covid cleanning script -----------

admissions_agesex <- read_csv("raw_data/hospital_admissions_hb_agesex_20211201.csv")

clean_admissions_agesex <- admissions_agesex %>%
  clean_names() %>%
  mutate(hb_name = case_when(
    str_detect(hb, "15") ~ "Ayrshire and Arran",
    str_detect(hb, "16") ~ "Borders",
    str_detect(hb, "17") ~ "Dumfries and Galloway",
    str_detect(hb, "19") ~ "Forth Valley",
    str_detect(hb, "020") ~ "Grampian",
    str_detect(hb, "22") ~ "Highland",
    str_detect(hb, "24") ~ "Lothian",
    str_detect(hb, "25") ~ "Orkney",
    str_detect(hb, "26") ~ "Shetland",
    str_detect(hb, "28") ~ "Western Isles",
    str_detect(hb, "29") ~ "Fife",
    str_detect(hb, "30") ~ "Tayside",
    str_detect(hb, "31") ~ "Greater Glasgow and Clyde",
    str_detect(hb, "32") ~ "Lanarkshire",
    str_detect(hb, "92") ~ "Scotland"),
    week_ending = ymd(week_ending)
  )
clean_admissions_agesex <- clean_admissions_agesex[, c(1, 2, 13, 3:12)]

write_csv(clean_admissions_agesex, "clean_data/clean_admissions_agesex.csv")

