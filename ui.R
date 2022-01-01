ui <- fluidPage(
  tabsetPanel(
    
    # creates the navigation for ICU tab
    tabPanel("Overview",
             
             splitLayout(
               plotOutput(),
               plotOutput()
             )
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