# All cleaning and wrangling goes here

activity_specialty <- read_csv("raw_data/activity_specialty.csv") %>%
  clean_names()


beds_specialty <- read_csv("raw_data/beds_specialty.csv") %>%
  clean_names()

<<<<<<< HEAD
clean_beds <- beds_specialty %>%
  filter(specialty == "CC", location_qf == "d") %>% 
  mutate(winter_flag = if_else(
    str_detect(quarter, "Q1") | str_detect(quarter, "Q4"), "yes", "no"
    ))
=======
>>>>>>> b00e9103c7a6552cf493422e134700946a58237c
