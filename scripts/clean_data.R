# All cleaning and wrangling goes here


# Beds and shapes cleaning for the map ----------------------------------------

clean_beds <- read_csv("raw_data/beds_specialty.csv") %>%
  clean_names() %>% 
  filter(location_qf == "d") %>%
  mutate(year = year(yq(quarter)),
         quarter = str_sub(quarter, -2),
         winter_flag = if_else(
           quarter %in% c("Q1", "Q4"), "Winter", "Summer")) %>%
  select(year, winter_flag, hb, specialty_name, percentage_occupancy) %>%
  group_by(winter_flag, year, hb) %>%
  summarise(percentage_occupancy = mean(percentage_occupancy)) %>%
  mutate(hb_name = case_when(
    hb == "S92000003" ~ "Scotland",
    hb == "S08000015" ~ "Ayrshire and Arran",
    hb == "S08000016" ~ "Borders",
    hb == "S08000017" ~ "Dumfries and Galloway",
    hb == "S08000019" ~ "Forth Valley",
    hb == "S08000020" ~ "Grampian",
    hb == "S08000022" ~ "Highland",
    hb == "S08000024" ~ "Lothian",
    hb == "S08000025" ~ "Orkney",
    hb == "S08000026" ~ "Shetland",
    hb == "S08000028" ~ "Western Isles",
    hb == "S08000029" ~ "Fife",
    hb == "S08000030" ~ "Tayside",
    hb == "S08000031" ~ "Greater Glasgow and Clyde",
    hb == "S08000032" ~ "Lanarkshire",
    hb == "S08000018" ~ "Fife",
    hb == "S08000031" ~ "Greater Glasgow and Clyde",
    hb == "S08000027" ~ "Tayside",
    TRUE ~ as.character(NA))) %>%
  filter(!is.na(hb_name)) %>%
  rename(hb_code = hb)
  
write_csv(clean_beds, "clean_data/clean_beds.csv")

# If it doesn't exist, create a clean shapes file

# simplified_shapes <- st_transform(rmapshaper::ms_simplify(st_read(
#   "raw_data/nhs_hb_2019/nhs_hb_2019.shp")),"CRS:84") %>%
#   clean_names()
# st_write(simplified_shapes, "clean_data/hb_clean.shp")

rm(clean_beds)


# A&E cleaning script ---------------------------------------------------------

clean_ae <- read_csv("raw_data/ane_activity.csv") %>% clean_names() %>%
  mutate(date = ym(month),
         year = year(date),
         month = month(date))

write_csv(clean_ae, "clean_data/clean_ae.csv")
rm(clean_ae)



# Admissions cleaning -----------------------------------------------------

admissions <- read_csv("raw_data/activity_specialty.csv") %>%
  clean_names() %>%
  filter(location_qf == "d") %>%
  mutate(q = str_sub(quarter, -2)) %>%
  mutate(quarter = yq(quarter)) %>%
  mutate(date = quarter,
         quarter = q) %>%
  mutate(hb = case_when(
    hb == "S92000003" ~ "Scotland",
    hb == "S08000015" ~ "Ayrshire and Arran",
    hb == "S08000016" ~ "Borders",
    hb == "S08000017" ~ "Dumfries and Galloway",
    hb == "S08000019" ~ "Forth Valley",
    hb == "S08000020" ~ "Grampian",
    hb == "S08000022" ~ "Highland",
    hb == "S08000024" ~ "Lothian",
    hb == "S08000025" ~ "Orkney",
    hb == "S08000026" ~ "Shetland",
    hb == "S08000028" ~ "Western Isles",
    hb == "S08000029" ~ "Fife",
    hb == "S08000030" ~ "Tayside",
    hb == "S08000031" ~ "Greater Glasgow and Clyde",
    hb == "S08000032" ~ "Lanarkshire",
    hb == "S08000018" ~ "Fife",
    hb == "S08000031" ~ "Greater Glasgow and Clyde",
    hb == "S08000027" ~ "Tayside",
    TRUE ~ as.character(NA))) %>%
  filter(!is.na(hb))

write_csv(admissions, "clean_data/clean_admissions.csv")
rm(admissions)


# length of stay script -----

clean_inpatient <- read_csv("raw_data/activity_demographics.csv") %>%
  clean_names()%>%
  mutate(hb_name = case_when(
    hb == "S92000003" ~ "Scotland",
    hb == "S08000015" ~ "Ayrshire and Arran",
    hb == "S08000016" ~ "Borders",
    hb == "S08000017" ~ "Dumfries and Galloway",
    hb == "S08000019" ~ "Forth Valley",
    hb == "S08000020" ~ "Grampian",
    hb == "S08000022" ~ "Highland",
    hb == "S08000024" ~ "Lothian",
    hb == "S08000025" ~ "Orkney",
    hb == "S08000026" ~ "Shetland",
    hb == "S08000028" ~ "Western Isles",
    hb == "S08000029" ~ "Fife",
    hb == "S08000030" ~ "Tayside",
    hb == "S08000031" ~ "Greater Glasgow and Clyde",
    hb == "S08000032" ~ "Lanarkshire",
    hb == "S08000018" ~ "Fife",
    hb == "S08000031" ~ "Greater Glasgow and Clyde",
    hb == "S08000027" ~ "Tayside",
    TRUE ~ as.character(NA)),
    grouped_age = case_when(
      age == "0-9 years" ~ "0-19",
      age == "10-19 years" ~ "0-19",
      age == "20-29 years" ~ "20-49",
      age == "30-39 years" ~ "20-49",
      age == "40-49 years" ~ "20-49",
      age == "50-59 years" ~ "50-69",
      age == "60-69 years" ~ "50-69",
      age == "70-79 years" ~ "70 and over",
      age == "80-89 years" ~ "70 and over",
      age == "90 years and over" ~ "70 and over"),
    quarter = yq(quarter)) %>%
  filter(!is.na(hb_name))

write_csv(clean_inpatient, "clean_data/clean_inpatient.csv")
rm(clean_inpatient)
