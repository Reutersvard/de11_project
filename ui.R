ui <- fluidPage(
  
  fluidRow(
  selectInput("region", "Region:",
              choices = unique(whisky_df$Region))),
  
  leafletOutput("whisky_map")
  
)