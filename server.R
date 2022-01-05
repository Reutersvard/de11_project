server <- function(input, output) {
  
# placeholder input for the overview tab ---------------------------------------
  output$beds_percentage_plot <- renderPlot({
    clean_beds_specialty_data %>% 
      filter(specialty_name %in% c("All Acute", "All Specialties"),
             hb != "Scotland") %>%
      ggplot(aes(x = date, y = percentage_occupancy, col = specialty_name)) +
      geom_point() +
      geom_line() +
      facet_wrap(~ hb) +
      theme(legend.position="none")
  })
    
    output$admissions_episodes_plot <- renderPlot({
      clean_admissions %>%  
        filter(hb %in% "Scotland",
               specialty_name %in% "Infectious Diseases",
               admission_type %in% c("Elective Inpatients", 
                                     "Emergency Inpatients", 
                                     "Transfers")) %>% 
        ggplot(aes(x = date, y = episodes, col = admission_type)) +
        geom_point() +
        geom_line()
  })
    
    # eventReactive(input$applyButton
    
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
    output$ae_emergency_plot <- renderPlot ({
      clean_ae %>%
        filter(year > 2015) %>%
        group_by(month, year) %>%
        summarise(attendance = sum(attendance_greater8hrs, na.rm = T)) %>% 
        ggplot(aes(month, attendance, fill = factor(year), col = factor(year))) +
        geom_point() +
        geom_line() +
        labs(x = "Month",
             y = "Attendance Over 12 Hours",
             colour = "Year") +
        theme_classic()
    })

    output$urology_plot <- renderPlot({
      activity_specialty %>%
        filter(specialty_name == "Urology") %>%
        ggplot(aes(quarter)) +
        geom_histogram(stat = "count") 
    })  
    
    
    output$ae_text_placeholder <- renderText({
      print("this is a placeholder text for the description of the plot in the A&E tab")
    })

# placeholder input for Stats tab ----------------------------------------------
    
    output$some_plot <- renderPlot({
      clean_beds %>% 
        filter(hb == "S92000003") %>% 
        ggplot(aes(quarter, percentage_occupancy)) +
        geom_col() 
    })
    
    #  # The histogram
    # output$some_plot <- renderPlot({
    #   ICU_quarter %>%
    #     ggplot(aes(n, quarter)) +
    #     geom_boxplot()
    # })
    
    
    #  The null distribution
    output$null_plot <- renderPlot({
      clean_beds %>% 
        filter(hb == "S92000003") %>%
        specify(percentage_occupancy ~ winter_flag) %>% 
        hypothesise(null = "independence") %>% 
        generate(reps = 10000, type = "permute") %>% 
        calculate(stat = "diff in means", order = c("yes", "no")) %>% 
        visualise() +
        shade_pvalue(obs_stat = 70.575, direction =  "right")
    })
    
    output$stat_text <- renderText({
      print("A discussion of the p-value etc here")
    })  
      
}