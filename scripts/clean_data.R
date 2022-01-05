# All cleaning and wrangling goes here


# Beds and shapes cleaning for the map ----------------------------------------

beds_specialty <- read_csv("raw_data/beds_specialty.csv") %>%
  clean_names()

map_beds <- beds_specialty %>%
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
    hb == "S08000015" ~ "Ayrshire & Arran",
    hb == "S08000016" ~ "Borders",
    hb == "S08000017" ~ "Dumfries & Galloway",
    hb == "S08000019" ~ "Forth Valley",
    hb == "S08000020" ~ "Grampian",
    hb == "S08000022" ~ "Highland",
    hb == "S08000024" ~ "Lothian",
    hb == "S08000025" ~ "Orkney",
    hb == "S08000026" ~ "Shetland",
    hb == "S08000028" ~ "Western Isles",
    hb == "S08000029" ~ "Fife",
    hb == "S08000030" ~ "Tayside",
    hb == "S08000031" ~ "Greater Glasgow & Clyde",
    hb == "S08000032" ~"Lanarkshire",
    TRUE ~ as.character(NA))) %>% 
  filter(!is.na(hb_name)) %>% 
  rename(hb_code = hb)

write_csv(map_beds, "clean_data/map_beds.csv")

# If it doesn't exist, create a clean shapes file
# simplified_shapes <- st_transform(rmapshaper::ms_simplify(st_read(
#   "raw_data/nhs_hb_2019/nhs_hb_2019.shp")),"CRS:84") %>%
#   clean_names()
# st_write(simplified_shapes, "clean_data/hb_clean.shp") 

rm(beds_specialty, map_beds)



# A&E cleaning script ---------------------------------------------------------

clean_ae <- ae <- read_csv("raw_data/ane_activity.csv") %>% clean_names() %>% 
  mutate(date = ym(month),
         year = year(date),
         month = month(date))

write_csv(clean_ae, "clean_data/clean_ae.csv")
rm(clean_ae)

# Overview cleaning scripts ----------------------------------------------------

# beds script
beds_specialty_data <- read_csv("raw_data/beds_specialty.csv")
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
rm(clean_beds_specialty_data)

# admissions script
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
rm(clean_admissions)
