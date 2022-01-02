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
      ICU_quarter %>% 
        ggplot(aes(n, quarter)) +
        geom_boxplot() 
    })
    
    #  The histogram
    # output$some_plot <- renderPlot({
    #   ICU_quarter %>% 
    #     ggplot(aes(n, quarter)) +
    #     geom_boxplot() 
    # })
    # 
    
    
    #  The null distribution
    output$null_plot <- renderPlot({
    ICU_quarter %>% 
      filter(quarter %in% c("Q3", "Q4")) %>%
      specify(n ~ quarter) %>% 
      hypothesise(null = "independence") %>% 
      generate(reps = 10000, type = "permute") %>% 
      calculate(stat = "diff in means", order = c("Q4", "Q3")) %>% 
      visualise() +
      shade_pvalue(obs_stat = 81 - 63, direction =  "right")
    })
    
    output$stat_text <- renderText({
      print("A discussion of the p-value etc here")
    })  
    
}