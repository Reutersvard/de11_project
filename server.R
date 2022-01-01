server <- function(input, output) {
  
  output$whisky_plot <- renderPlot({
    whisky_df %>% 
      ggplot() +
      geom_histogram(aes(x = Capacity))
  })
  
  
}