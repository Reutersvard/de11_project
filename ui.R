## ui.R ##

# sidebar menu -----------------------------------------------------
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Overview", tabName = "overview", icon = icon("globe")),
    menuItem("COVID Insights", tabName = "covid", icon = icon("virus")),
    menuItem("A&E Admissions", tabName = "ae", icon = icon("chart-line")),
    menuItem("Demographics", tabName = "demo", icon = icon("poll")),
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

    # Overview tab -------------------------------------------------------------
    tabItem(tabName = "overview",

            # space between the top bar and the main page
            br(),
            
            # Widgets for the maps
            fluidRow(
              
              column(width = 1),
              
              column(width = 2,
                 br(),
                 radioButtons("season_left", "Season for left",
                               choices = unique(map_beds$winter_flag))),
              
             column(width = 2,
                 br(),
                 selectInput("year_left", "Year for left",
                              choices = unique(map_beds$year))),
                     
             column(width = 2,
                    br(),
                    radioButtons("season_right", "Season for right",
                                 choices = unique(map_beds$winter_flag))),
             
             column(width = 2,
                    br(),
                    selectInput("year_right", "Year for right",
                                choices = unique(map_beds$year))),
             
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

    # COVID tab ----------------------------------------------------------------
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

            # element for the main row, first half - placeholder plot
            fluidRow(column(width = 5,
                            br(),
                            plotOutput("dermatology_plot"),

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

    # A&E tab ------------------------------------------------------------------
    tabItem(tabName = "ae",

            # space between the top bar and the main page
            br(),

            # element for the top row
            fluidRow(column(width = 3,
                            br(),
                            selectInput("selecty", "Select Column for Y Axis",
                                        choices = colnames(new_clean_ae))),
                     column(width = 3,
                            br(),
                            radioButtons("department_type", "Department Type",
                                         choices = unique(clean_ae$department_type))
                     ),
                     column(width = 3,
                            br(),
                            setSliderColor(c("#9370db", "#9370db", "#9370db", "#9370db"),
                                           c(1,2,3,4)),

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
                                         "Plot")
                     )
            ),

            # element for the main row, first half - A&E emergency plot
            fluidRow(column(width = 6,
                            br(),
                            plotOutput("ae_emergency_plot"),

                            # create the bottom right box with text description
                            textOutput("ae_text_placeholder")),
                     # creates the element for the main row, second half - (this is a placeholder plot)
                     column(width = 6,
                            br(),
                            plotOutput("ae_stats_plot")
                     )
            )
    ),

    # Demographics tab ---------------------------------------------------------

    # navigation for demographics tab
    tabItem(tabName = "demo",

            # element for the left column
            br(),
            fluidRow(column(width = 4,
                     radioButtons("plot_input",
                                  "Select plot type",
                                  choices = c("Box plot", "Histogram"))
                    ),

              # this is a placeholder plot
              column(width = 8,
                     plotOutput("neurology_plot"),
                     textOutput("stat_text")
                     )
            )
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
