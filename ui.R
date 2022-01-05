## ui.R ##

# sidebar menu -----------------------------------------------------
sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("columns")),
      menuItem("COVID Insights", tabName = "covid", icon = icon("virus")),
      menuItem("A&E Admissions", tabName = "ae", icon = icon("chart-bar")),
      menuItem("Statistics", tabName = "stats", icon = icon("chart-line")),
      setSliderColor(c("#7CB342", "#7CB342", "#7CB342", "#7CB342"), c(1, 2, 3, 4)),
      sliderInput("date_range", label = "Date Range",
                  min = as.Date("2016-01-01","%Y-%m-%d"),
                  max = as.Date("2021-12-31","%Y-%m-%d"),
                  value = c(as.Date("2016-01-01"),
                            as.Date("2021-12-31")),
                  timeFormat="%Y-%m",
                  width = "85%",
                  step = 90),
      actionButton("applyButton",
                   "Apply Changes")
    )
)

# main dashboard body --------------------------------------------------------
body <- dashboardBody(
  tabItems(

# Overview tab ----------------------------------------------------------------
    tabItem(tabName = "overview",

            # space between the top bar and the main page
            br(),

            # element for the top row
            fluidRow(column(width = 4,
                                  br(),
                                  radioButtons("icu_choice_1", "ICU choice",
                                               choices = c("Yes", "No"))),
                       column(width = 4,
                                  br(),
                                  sliderInput("date_range", label = "Date Range",
                                              min = as.Date("2016-01-01","%Y-%m-%d"),
                                              max = as.Date("2021-12-31","%Y-%m-%d"),
                                              value = c(as.Date("2016-01-01"),
                                                        as.Date("2021-12-31")),
                                              timeFormat="%Y-%m",
                                              step = 90
                                              )
                                  ),
                        column(width = 4,
                                  br(),
                                  actionButton("applyButton",
                                               "Apply Changes")
                                )
                     ),

              # element for the main row, first half (this is a placeholder plot)
              fluidRow(column(width = 6,
                              br(),
                              plotOutput("dermatology_plot")
                              ),

                        # creates the element for the main row, second half - (this is a placeholder plot)
                        column(width = 6,
                               br(),
                               plotOutput("neurology_plot")
                              )
                ),
          ),

# COVID tab ----------------------------------------------------------
    tabItem(tabName = "covid",

            # space between the top bar and the main page
            br(),

            # element for the top row
            fluidRow(column(width = 3,
                            br(),
                            selectInput("hb_input",
                                        "Health Board",
                                        choices = 
                                          unique(clean_admissions$hb), 
                                        selected = "Scotland")
                      ),
                     column(width = 3,
                            br(),
                            selectInput("specialty_input",
                                        "Speciality",
                                        choices = 
                                          unique(clean_admissions$specialty_name), 
                                        selected = "Infectious Diseases")
                     ),
                     column(width = 3,
                            br(),
                            sliderInput("coivd_date_range", label = "Date Range",
                                        min = as.Date("2016-01-01","%Y-%m-%d"),
                                        max = as.Date("2021-12-31","%Y-%m-%d"),
                                        value = c(as.Date("2016-01-01"),
                                                  as.Date("2021-12-31")),
                                        timeFormat="%Y-%m",
                                        step = 90,
                                        ticks = FALSE
                            )
                     ),
                     column(width = 3,
                            br(),
                            actionButton("update",
                                         "Apply Changes")
                     )
            ),
            
            # element for the main row, first half - beds_percentage_plot
            fluidRow(column(width = 5,
                            br(),
                            plotOutput("beds_percentage_plot"),
                            
                            # bottom right box with text description
                            textOutput("icu_text_placeholder"),
            ),
            
            # element for the main row, second half - admissions_episodes plot
                      column(width = 6,
                             br(),
                             plotOutput("admissions_episodes_plot")
                            )
                    ),
            ),

# A&E tab-----------------------------------------------------------
    tabItem(tabName = "ae",

            # space between the top bar and the main page
            br(),
            
            # element for the top row
            fluidRow(column(width = 3,
                            br(),
                            numericInput("age_range_1", "Age",
                                         value = 1, min = 1, max = 100)),
                     column(width = 3,
                            br(),
                            radioButtons("dept_type", "Department Type",
                                         choices = c("Accident and Emergency",
                                                     "Minor Injuries"))),
                     column(width = 3,
                            br(),
                            sliderInput("date_range", label = "Date Range",
                                        min = as.Date("2016-01-01","%Y-%m-%d"),
                                        max = as.Date("2021-12-31","%Y-%m-%d"),
                                        value = c(as.Date("2016-01-01"),
                                                  as.Date("2021-12-31")),
                                        timeFormat="%Y-%m",
                                        step = 90
                                        )
                            ),
                     column(width = 3,
                            br(),
                            actionButton("applyButton",
                                         "Apply Changes")
                            )
                      ),
            
            # element for the main row, first half - A&E emergency plot
            fluidRow(column(width = 6,
                            br(),
                            plotOutput("ae_emergency_plot"),
                            
                            # create the bottom right box with text description
                            textOutput("ae_text_placeholder"),
                            ),
            
            # creates the element for the main row, second half - (this is a placeholder plot)
                      column(width = 6,
                             br(),
                             plotOutput("urology_plot")
                            )
                    ),
    ),
    
# Statistics tab -----------------------------------------------------------
    
    # navigation for statistics tab
    tabItem(tabName = "stats",

         # element for the left column
          br(),
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
  )
)

# Main dashboard and CSS -------------------------------------------------------
dashboardPage(skin = "purple",
    dashboardHeader(title = "PHS Project"),
    sidebar,
    body,
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  )
)