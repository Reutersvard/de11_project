# All cleaning and wrangling goes here

activity_specialty <- read_csv("raw_data/activity_specialty.csv") %>%
  clean_names()