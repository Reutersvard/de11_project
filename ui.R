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
             
             # creates the element for the main row, first half (this is a placeholder plot)
             fluidRow(column(width = 6,
                             plotOutput("cardio_plot")
                             ),
                      
              # creates the element for the main row, second half - (this is a placeholder plot)
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
                      
              # create the element for the right column -(this is a placeholder plot)
                      column(width = 8,
                             plotOutput("dermatology_plot")
                             )
                      ),
             
             # create the left box with date selection
             fluidRow(column(width = 4, 
                             dateRangeInput("date_range_1", "Date Range",
                                            start = "2016-01-01",
                                            end = "2022-01-01")
                             ),
                      
              # create the bottom right box with text description
                      column(width = 8,
                             textOutput("icu_text_placeholder")
                             )
             ),
    ),

# A&E tab ----------------------------------------------------------------------
    # creates the navigation for A&E tab
    tabPanel("A&E",
             
             # create the element for the left column
             fluidRow(column(width = 4,
                             numericInput("age_range_1", "Age Choice",
                                          value = 1, min = 1, max = 100),
             ),
             
             # create the element for the right column - this is a placeholder plot
             column(width = 8,
                    plotOutput("neurology_plot")
                  )
             ),
             
             # create the left box with date selection
             fluidRow(column(width = 4, 
                             dateRangeInput("date_range_1", "Date Range",
                                            start = "2016-01-01",
                                            end = "2022-01-01")
                            ),
                      
              # create the bottom right box with text description
                      column(width = 8,
                            textOutput("ae_text_placeholder")
                            )
                      )
             ),

# Statistics tab ---------------------------------------------------------------
    tabPanel("Statistics",
         
         # create the element for the left column
         fluidRow(
           column(width = 4,
                  radioButtons("plot_input",
                               "Select plot type",
                               choices = c("Box plot", "Histogram"))
                  ),
         
            # this is a placeholder plot
            column(width = 8,
                plotOutput("some_plot"))
         ),
         
         # create the left box with date selection
         fluidRow(
           column(width = 4, 
                  radioButtons("variable_input",
                               "Analysis on which variable?",
                               choices = c("ICU", "A&E"))
                  ),
         
          # this is a placeholder plot
           column(width = 8,
                  plotOutput("null_plot")) 
           
          ),

         fluidRow(  # create the bottom right box with text description
           column(width = 8,
                  textOutput("stat_text")))
    )
))