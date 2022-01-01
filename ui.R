ui <- fluidPage(
  tabsetPanel(
    
    # creates the navigation for ICU tab
    tabPanel("Overview",
             
             # creates the element for the top row
             fluidRow(column(width = 12),
                      

             ),
             
             # creates the element for the main row, first half
             fluidRow(column(width = 6),
                      
              # creates the elemetn for the main row, second half
                      column(width = 6)
                      
                      ),
               plotOutput("whisky_plot"),
               plotOutput("whisky_plot")

             ),
    
    # creates the navigation for ICU tab
    tabPanel("ICU",
             
             ),
    # creates the navigation for A&E tab
    tabPanel("A&E",
             
             ),
    
    # creates the navigation for statistics tab
    tabPanel("Statistics",
             
             )
  )
)
