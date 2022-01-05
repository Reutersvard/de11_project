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
    
    date_react <- reactive({
      seq(input$ae_date_range[1],
          input$ae_date_range[2],
          by = 1)
    })
    
    filtered_clean_ae <- eventReactive(input$update, {
      clean_ae %>%
      select(date, month, year, hbt, department_type, var = input$selecty) %>%
      filter(department_type == input$department_type) %>%
      filter(date %in% date_react())
    })
    
    output$ae_emergency_plot <- renderPlot ({
      filtered_clean_ae() %>%
        group_by(month, year) %>%
        summarise(attendance = sum(var, na.rm = TRUE)) %>% 
        ggplot(aes(month, attendance, col = factor(year))) +
        geom_point() +
        geom_line() +
        labs(x = "Month",
             y = "Attendance Over 12 Hours",
             colour = "Year") +
        theme_classic()
    })

    output$ae_stats_plot <- renderPlot({
      filtered_clean_ae() %>%
        group_by(month, year) %>%
        summarise(attendance = sum(var, na.rm = T)) %>% 
        mutate(winter_flag = case_when(month %in% c(1, 2, 3, 10, 11, 12) ~ "Yes",
                                       TRUE ~ "No")) %>%
        group_by(winter_flag, year) %>% 
        summarise(av_attendance = mean(attendance)) %>% 
        arrange(year) %>%
        ggplot() +
        aes(x = year, y = av_attendance) +
        geom_col() +
        labs(x = "Year",
             y = "Average Attendance") +
        theme_classic()
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