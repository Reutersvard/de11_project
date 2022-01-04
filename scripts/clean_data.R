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

clean_ae <- ae %>%
  clean_names() %>%
  mutate(date = ym(month))

write_csv(clean_ae, "clean_data/clean_ae.csv")