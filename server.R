server <- function(input, output) {
  
# placeholder input for the overview tab ---------------------------------------
  output$icu_plot <- renderPlot({
    activity_specialty %>%
      filter(specialty_name == "Intensive Care Medicine") %>%
      ggplot(aes(quarter)) +
      geom_histogram(stat = "count")
  })
    
    output$cardio_plot <- renderPlot({
      activity_specialty %>%
        filter(specialty_name == "Cardiology") %>%
        ggplot(aes(quarter)) +
        geom_histogram(stat = "count") 
  })
    
# placeholder input for the ICU tab --------------------------------------------
    output$dermatology_plot <- renderPlot({
      activity_specialty %>%
        filter(specialty_name == "Dermatology") %>%
        ggplot(aes(quarter)) +
        geom_histogram(stat = "count") 
    })

    output$icu_text_placeholder <- renderText({
      print("this is a placeholder text for the description of the plot in the ICU tab")
    })
    
# placeholder input for the A&E tab --------------------------------------------
    output$neurology_plot <- renderPlot({
      activity_specialty %>%
        filter(specialty_name == "Neurology") %>%
        ggplot(aes(quarter)) +
        geom_histogram(stat = "count") 
    })

    output$ae_text_placeholder <- renderText({
      print("this is a placeholder text for the description of the plot in the A&E tab")
    })


# Statistics plots --------------------------------------------------------
  
    output$some_plot <- renderPlot({
      activity_specialty %>%
        filter(specialty_name == "Neurology") %>%
        ggplot(aes(quarter)) +
        geom_histogram(stat = "count") 
    })
    
    output$stat_text <- renderText({
      print("this is a placeholder text for the description of the plot in the A&E tab")
    })  
    
}