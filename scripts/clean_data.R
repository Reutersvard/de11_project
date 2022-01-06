# All cleaning and wrangling goes here


# Beds and shapes cleaning for the map ----------------------------------------

beds_specialty <- read_csv("raw_data/beds_specialty.csv") %>%
  clean_names()

clean_beds <- beds_specialty %>%
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

rm(beds_specialty, clean_beds)


# A&E cleaning script ---------------------------------------------------------

clean_ae <- ae <- read_csv("raw_data/ane_activity.csv") %>% clean_names() %>% 
  mutate(date = ym(month),
         year = year(date),
         month = month(date))

write_csv(clean_ae, "clean_data/clean_ae.csv")
rm(clean_ae)



# Admissions cleaning -----------------------------------------------------

admissions <- read_csv("raw_data/activity_specialty.csv") %>% 
  clean_names() %>% 
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
