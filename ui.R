## ui.R ##

# sidebar menu -----------------------------------------------------
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Bed Occupancy", tabName = "bed", icon = icon("procedures")),
    menuItem("Hospital Admissions", tabName = "hosp", icon = icon("hospital-user")),
    menuItem("A&E Attendances", tabName = "ae", icon = icon("ambulance")),
    menuItem("Demographics", tabName = "demo", icon = icon("city"))
  )
)

# main dashboard body --------------------------------------------------------
body <- dashboardBody(
  tabItems(

    # Overview tab -------------------------------------------------------------
    tabItem(tabName = "bed",

            # space between the top bar and the main page
            br(),
            
            # Widgets for the maps
            fluidRow(
              
              column(width = 1),
              
              column(width = 2,
                 br(),
                 radioButtons("season_left", "Season for left",
                               choices = unique(clean_beds$winter_flag))),
              
             column(width = 2,
                 br(),
                 selectInput("year_left", "Year for left",
                              choices = unique(clean_beds$year))),
             
             column(width = 2),
                     
             column(width = 2,
                    br(),
                    radioButtons("season_right", "Season for right",
                                 choices = unique(clean_beds$winter_flag))),
             
             column(width = 2,
                    br(),
                    selectInput("year_right", "Year for right",
                                choices = unique(clean_beds$year))),
             
             
             column(width = 1)),
          
             
            # Left map
            fluidRow(column(width = 6,
                            br(),
                            leafletOutput("map_left")),
            
            # Right map
            column(width = 6,
                   br(),
                   leafletOutput("map_right"))
            ),
    ),

    # Hospital admissions tab ----------------------------------------------------------------
    tabItem(tabName = "hosp",

            # space between the top bar and the main page
            br(),

            # element for the top row
            fluidRow(column(width = 3,
                            br(),
                            selectInput("hb_input",
                                        "Health Board",
                                        choices =
                                          unique(new_admissions$hb),
                                        selected = "Tayside")
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
                   setSliderColor(c("#42A5F5", "#42A5F5", "#42A5F5"),
                                  c(1,2,3)),
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

            # element for the main row, first half - placeholder plot
            fluidRow(column(width = 6,
                            br(),
                            plotOutput("dermatology_plot"),

                            # bottom right box with text description
                            textOutput("hosp_text"),
            ),

            # element for the main row, second half - admissions_episodes plot
            column(width = 6,
                   br(),
                   plotOutput("admissions_episodes_plot")
            )
            ),
    ),

    # A&E tab ------------------------------------------------------------------
    tabItem(tabName = "ae",

            # space between the top bar and the main page
            br(),

            # element for the top row
            fluidRow(column(width = 3,
                            br(),
                            selectInput("selecty", "Attendance Greater than 8 or 12 Hours",
                                        choices = c("Attendance Greater than 8 Hours" = colnames(new_clean_ae)[1],
                                                    "Attendance Greater than 12 Hours" = colnames(new_clean_ae)[2]), 
                                        selected = new_clean_ae$attendance_greater12hrs)),
                     column(width = 3,
                            br(),
                            radioButtons("department_type", "Department Type",
                                         choices = unique(clean_ae$department_type),
                                         selected = "Emergency Department")
                     ),
                     column(width = 3,
                            br(),
                            sliderInput("ae_date_range", label = "Date Range",
                                        min = as.Date("2007-07-01","%Y-%m-%d"),
                                        max = as.Date("2021-10-01","%Y-%m-%d"),
                                        value = c(as.Date("2007-07-01"),
                                                  as.Date("2021-10-01")),
                                        timeFormat = "%Y-%m",
                                        step = 91.25,
                                        ticks = FALSE)
                     ),
                     column(width = 3,
                            br(),
                            actionButton("update_ae_button",
                                         "Apply Changes")
                     )
            ),

            # element for the main row, first half - A&E emergency plot
            fluidRow(column(width = 6,
                            br(),
                            plotOutput("ae_emergency_plot")),
                     
                     # creates the element for the main row, second half - (this is a placeholder plot)
                     column(width = 6,
                            br(),
                            plotOutput("ae_stats_plot"),
                            
                            uiOutput("ae_stats_text")
                     )
            )
    ),

    # Demographics tab ---------------------------------------------------------

    # navigation for demographics tab
    tabItem(tabName = "demo",

            # space between the top bar and the main page
            br(),
            
            # element for the top row
            fluidRow(column(width = 3,
                            br(),
                            selectInput("hb_name_input",
                                        "Health Board",
                                        choices =
                                          unique(clean_inpatient$hb_name),
                                        selected = "Scotland")
            ),
            column(width = 3,
                   br(),
                   checkboxGroupInput("checkGroup", 
                                      "Age Group", 
                                      choices = unique(clean_inpatient$grouped_age),
                                      selected = c("0-19", "20-49", "50-69", "70 and over"))
            ),
            column(width = 3,
                   br(),
                   sliderInput("date_range", label = "Date Range",
                               min = as.Date("2016-04-01","%Y-%m-%d"),
                               max = as.Date("2021-04-01","%Y-%m-%d"),
                               value = c(as.Date("2016-01-01"),
                                         as.Date("2021-04-01")),
                               timeFormat="%Y-%m",
                               step = 90,
                               ticks = FALSE
                   )
            ),
            column(width = 3,
                   br(),
                   actionButton("update_demo",
                                "Apply Changes")
            )
            ),
            br(),
            plotOutput("length_of_stay_plot")
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
