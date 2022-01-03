# All cleaning and wrangling goes here

activity_specialty <- read_csv("raw_data/activity_specialty.csv") %>%
  clean_names()


beds_specialty <- read_csv("raw_data/beds_specialty.csv") %>%
  clean_names()

