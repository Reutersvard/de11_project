ui <- fluidPage(
  tabsetPanel(
    
    # creates the navigation for ICU tab
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
                                            end = "2022-01-01",
                                          )
                             )
                    ),
             
             
             # creates the element for the main row, first half
             fluidRow(column(width = 6,
                             radioButtons("placeholder", "PLACEHOLDER",
                                          choices = "eep")
                             ),
                      
              # creates the element for the main row, second half
                      column(width = 6,
                             plotOutput("icu_plot")
                            )
                      ),
    ),

    # creates the navigation for ICU tab
    tabPanel("ICU"
             ),
             
    # creates the navigation for A&E tab
    tabPanel("A&E"
             ),
    
    # creates the navigation for statistics tab
    tabPanel("Statistics"
             ),
  ),          
)
