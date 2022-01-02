server <- function(input, output) {
  
  # Placeholder example plot
  output$icu_plot <- renderPlot({
    activity_specialty %>%
      filter(specialty_name == "Intensive Care Medicine") %>%
      ggplot(aes(quarter)) +
      geom_histogram(stat = "count")
  })
  
  
}