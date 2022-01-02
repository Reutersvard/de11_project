ui <- fluidPage(
  tabsetPanel(

# Overview tab ----------------------------------------------------------------
    # creates the navigation for Overview tab
    tabPanel("Overview",
             
             # creates the element for the top row
             fluidRow(column(width = 4,
                            radioButtons("icu_choice_1", "ICU choice",
                                   choices = c("Yes", "No"))),
                      column(width = 4,
                             numericInput("age_range_1", "Age Choice",
                                          value = 1, min = 1, max = 100),
                             ),
                      column(width = 4,
                             dateRangeInput("date_range_1", "Date Range",
                                            start = "2016-01-01",
                                            end = "2022-01-01"
                                            )
                             )
                    ),
             
             
             # creates the element for the main row, first half (this is currently a placeholder as R
             # does not show both plots when inputting two, but both will be plots)
             fluidRow(column(width = 6,
                             plotOutput("cardio_plot")
                             ),
                      
              # creates the element for the main row, second half - this will also be a plot
                      column(width = 6,
                             plotOutput("icu_plot")
                            )
                      ),
    ),

# ICU tab ----------------------------------------------------------------------
    # creates the navigation for ICU tab
    tabPanel("ICU",
             
             # create the element for the left column
             fluidRow(column(width = 4,
                             numericInput("age_range_1", "Age Choice",
                                          value = 1, min = 1, max = 100),
                             ),
                      
              # create the element for the right column
                      column(width = 8,
                             plotOutput("dermatology_plot")
                             )
                      ),
             
             # create the left box 
             fluidRow(column(width = 4, 
                             dateRangeInput("date_range_1", "Date Range",
                                            start = "2016-01-01",
                                            end = "2022-01-01")
                             ),
                      column(width = 8,
                             textInput("text_input", "Text Goes Here", value = "text")
                             )
             ),
    ),

# A&E tab ----------------------------------------------------------------------
    # creates the navigation for A&E tab
    tabPanel("A&E"
             
             ),

# Statistics tab ---------------------------------------------------------------
    # creates the navigation for statistics tab
    tabPanel("Statistics"
             ),
    ),          
  )
