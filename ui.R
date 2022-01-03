ui <- fluidPage(
  tabsetPanel(

# Overview tab ----------------------------------------------------------------
    # creates the navigation for Overview tab
    tabPanel("Overview",
             
             # creates the element for the top row
             fluidRow(column(width = 4,
                            br(),
                            radioButtons("icu_choice_1", "ICU choice",
                                   choices = c("Yes", "No"))),
                      column(width = 4,
                             br(),
                             numericInput("age_range_1", "Age Choice",
                                          value = 1, min = 1, max = 100),
                             ),
                      column(width = 4,
                             br(),
                             dateRangeInput("date_range_1", "Date Range",
                                            start = "2016-01-01",
                                            end = "2022-01-01"
                                            )
                             )
                    ),
             
             # creates the element for the main row, first half (this is a placeholder plot)
             fluidRow(column(width = 6,
                             br(),
                             plotOutput("cardio_plot")
                             ),
                      
              # creates the element for the main row, second half - (this is a placeholder plot)
                      column(width = 6,
                             br(),
                             plotOutput("icu_plot")
                            )
                      ),
    ),

# ICU tab ----------------------------------------------------------------------
    # creates the navigation for ICU tab
    tabPanel("ICU",
             
             # create the element for the left column
             fluidRow(column(width = 4,
                             br(),
                             numericInput("age_range_1", "Age Choice",
                                          value = 1, min = 1, max = 100),
                             ),
                      
              # create the element for the right column -(this is a placeholder plot)
                      column(width = 8,
                             br(),
                             plotOutput("dermatology_plot")
                             )
                      ),
             
             # create the left box with date selection
             fluidRow(column(width = 4,
                             br(),
                             sliderInput("date_range", label = "Date Range",
                                         min = as.Date("2016-01-01","%Y-%m-%d"),
                                         max = as.Date("2021-12-31","%Y-%m-%d"),
                                         value = c(as.Date("2016-01-01"),
                                                    as.Date("2021-12-31")),
                                         timeFormat="%Y-%m-%d",
                                         step = 90
                                         )
                             ),
                      
              # create the bottom right box with text description
                      column(width = 8,
                             br(),
                             textOutput("icu_text_placeholder")
                             )
             ),
    ),

# A&E tab ----------------------------------------------------------------------
    # creates the navigation for A&E tab
    tabPanel("A&E",
             
             # create the element for the left column
             fluidRow(column(width = 4,
                             br(),
                             numericInput("age_range_1", "Age Choice",
                                          value = 1, min = 1, max = 100),
             ),
             
             # create the element for the right column - this is a placeholder plot
             column(width = 8,
                    br(),
                    plotOutput("neurology_plot")
                  )
             ),
             
             # create the left box with date selection
             fluidRow(column(width = 4,
                             br(),
                             dateRangeInput("date_range_1", "Date Range",
                                            start = "2016-01-01",
                                            end = "2022-01-01")
                            ),
                      
              # create the bottom right box with text description
                      column(width = 8,
                             br(),
                            textOutput("ae_text_placeholder")
                            )
                      ),
             ),

# Statistics tab ---------------------------------------------------------------
    # creates the navigation for statistics tab - Ricardo
    tabPanel("Statistics"
             ),
    ),          
  )
