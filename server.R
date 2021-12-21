server <- function(input, output) {
  
  output$whisky_map <- renderLeaflet({
    whisky_df %>% 
      filter(Region == input$region) %>% 
      leaflet %>% 
      addTiles() %>% 
      addCircleMarkers(lat = ~lat, lng = ~long, popup = ~Distillery)
  })
  
  
}