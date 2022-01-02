# All cleaning and wrangling goes here

activity_specialty <- read_csv("raw_data/activity_specialty.csv") %>%
  clean_names()




# A placeholder idea for stats --------------------------------------------

ICU_quarter <- activity_specialty %>%
  filter(specialty == "CC") %>% 
  count(quarter) %>% 
  mutate(quarter = case_when(
    str_detect(quarter, "Q1") ~ "Q1",
    str_detect(quarter, "Q2") ~ "Q2",
    str_detect(quarter, "Q3") ~ "Q3",
    str_detect(quarter, "Q4") ~ "Q4"))
