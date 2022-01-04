ui <- dashboardPage( skin = "purple", 
  dashboardHeader(title = "PHS Project"),
  dashboardSidebar(),
  dashboardBody(
  tabsetPanel(

# Overview tab ----------------------------------------------------------------
    # creates the navigation for Overview tab
    tabPanel("Overview",
             
             # creates a space between the top bar and the main page
             br(),
             
             # creates the element for the top row
             fluidRow(box(column(width = 3,
                            br(),
                            radioButtons("icu_choice_1", "ICU choice",
                                   choices = c("Yes", "No")))),
                      box(column(width = 3,
                             br(),
                             numericInput("age_range_1", "Age Choice",
                                          value = 1, min = 1, max = 100),
<<<<<<< HEAD
                             )),
                      box(column(width = 3,
                             br(),
                             sliderInput("date_range", label = "Date Range",
                                         min = as.Date("2016-01-01","%Y-%m-%d"),
                                         max = as.Date("2021-12-31","%Y-%m-%d"),
                                         value = c(as.Date("2016-01-01"),
                                                   as.Date("2021-12-31")),
                                         timeFormat="%Y-%m-%d",
                                         step = 90
                                        )
                             )),
                      box(column(width = 3,
                             br(),
                             actionButton("applyButton",
                                          "Apply Changes")
=======
                             ),
                      column(width = 4,
                             dateRangeInput("date_range_1", "Date Range",
                                            start = "2016-01-01",
                                            end = "2022-01-01"
                                            )
>>>>>>> b00e9103c7a6552cf493422e134700946a58237c
                             )
                    )),
             
             # creates the element for the main row, first half (this is a placeholder plot)
             fluidRow(column(width = 6,
<<<<<<< HEAD
                             br(),
=======
>>>>>>> b00e9103c7a6552cf493422e134700946a58237c
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
<<<<<<< HEAD
             
             # creates a space between the top bar and the main page
             br(),
             
             # create the element for the left column
             sidebarLayout(
               
               # creates the sidebar panel
               sidebarPanel(
                 numericInput("age_range_1", "Age Choice",
                              value = 1, min = 1, max = 100),
                 
                 # create the left box with date selection and button
                 sliderInput("date_range", label = "Date Range",
                             min = as.Date("2016-01-01","%Y-%m-%d"),
                             max = as.Date("2021-12-31","%Y-%m-%d"),
                             value = c(as.Date("2016-01-01"),
                                       as.Date("2021-12-31")),
                             timeFormat="%Y-%m-%d",
                             step = 90
                            ),
                 actionButton("applyButton",
                              "Apply Changes")        
                 ),
               
               # creates the main panel
               mainPanel(
                 
                 # create the element for the right column -(this is a placeholder plot)
                 fluidRow(column(width = 8,
                                 br(),
                                 plotOutput("dermatology_plot"),
                                 br(),
                                 br(),
                                 br(),
                                 
                                 # create the bottom right box with text description
                                 textOutput("icu_text_placeholder")
                                 )
                          )
                        )
                    )
             ),


# A&E tab ----------------------------------------------------------------------
    # creates the navigation for A&E tab
tabPanel("A&E",
         
         # creates a space between the top bar and the main page
         br(),
         
         # create the element for the left column
         sidebarLayout(
           
           # creates the sidebar panel
           sidebarPanel(
             numericInput("age_range_1", "Age Choice",
                          value = 1, min = 1, max = 100),
             
             # create the left box with date selection
             sliderInput("date_range", label = "Date Range",
                         min = as.Date("2016-01-01","%Y-%m-%d"),
                         max = as.Date("2021-12-31","%Y-%m-%d"),
                         value = c(as.Date("2016-01-01"),
                                   as.Date("2021-12-31")),
                         timeFormat="%Y-%m-%d",
                         step = 90
             ),
             actionButton("applyButton",
                          "Apply Changes")   
           ),
           
           # creates the main panel
           mainPanel(
             
             # create the element for the right column -(this is a placeholder plot)
             fluidRow(column(width = 8,
                             br(),
                             plotOutput("neurology_plot"),
                             br(),
                             br(),
                             br(),
                             
                             # create the bottom right box with text description
                             textOutput("ae_text_placeholder")
                            )
                      )
                     )
            )
        ),


# Statistics tab ---------------------------------------------------------------
    # creates the navigation for statistics tab
tabPanel("Statistics",
=======
             
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
>>>>>>> b00e9103c7a6552cf493422e134700946a58237c
         
         # create the element for the left column
         fluidRow(
           column(width = 4,
                  radioButtons("plot_input",
                               "Select plot type",
                               choices = c("Box plot", "Histogram"))
<<<<<<< HEAD
           ),
           
           # this is a placeholder plot
           column(width = 8,
                  plotOutput("some_plot"))
=======
                  ),
         
            # this is a placeholder plot
            column(width = 8,
                plotOutput("some_plot"))
>>>>>>> b00e9103c7a6552cf493422e134700946a58237c
         ),
         
         # create the left box with date selection
         fluidRow(
           column(width = 4, 
                  radioButtons("variable_input",
                               "Analysis on which variable?",
                               choices = c("ICU", "A&E"))
<<<<<<< HEAD
           ),
           
           # this is a placeholder plot
           column(width = 8,
                  plotOutput("null_plot")) 
           
         ),
         
         fluidRow(  # create the bottom right box with text description
           column(width = 8,
                  textOutput("stat_text")))
)
    ),          
  )
)
=======
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
>>>>>>> b00e9103c7a6552cf493422e134700946a58237c
