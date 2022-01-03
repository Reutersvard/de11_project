## ui.R ##

# creates the sidebar menu -----------------------------------------------------
sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
      menuItem("ICU Admissions", tabName = "icu", icon = icon("th")),
      menuItem("A&E Admissions", tabName = "ae", icon = icon("th")),
      menuItem("Statistics", tabName = "stats", icon = icon("th"))
    )
)  

# creates the main body --------------------------------------------------------
body <- dashboardBody(
  tabItems(
    
    # overview tab content
    tabItem(tabName = "overview",
            
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
                                  )
                          ),
                       box(column(width = 3,
                                  br(),
                                  actionButton("applyButton",
                                               "Apply Changes")
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
    
    # ICU tab content ----------------------------------------------------------
    tabItem(tabName = "icu",
            
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

    # A&E tab content-----------------------------------------------------------
    tabItem(tabName = "ae",
            
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

    # stats tab content -------------------------------------------------------
    tabItem(tabName = "stats",
            h2("Stats tab content")
      )
    
  )
)

dashboardPage(skin = "purple", 
  dashboardHeader(title = "PHS Project"),
    sidebar,
    body
)