server <- function(input, output) {
  
# Overview tab -----------------------------------------------------------------
  
  # Winter map
  output$map_winter <- renderPlot({

    # Soon to become interactive
    filtered_beds <- map_beds %>%
      filter(year == 2020,
             winter_flag == "Winter")

    merged <- sp::merge(shapes, filtered_beds) %>%
      select(hb_name, percentage_occupancy, geometry)

    pal <- colorBin("BuPu", domain = merged$percentage_occupancy)

    merged %>%
      leaflet() %>%
      addTiles() %>%
      addProviderTiles(providers$OpenStreetMap) %>%
      addPolygons(
        fillColor = ~ pal(percentage_occupancy),
        weight = 2,
        opacity = 1,
        color = "white",
        dashArray = "3",
        fillOpacity = 0.7,
        highlight = highlightOptions(
          weight = 5,
          color = "#666",
          dashArray = "",
          fillOpacity = 0.7,
          bringToFront = TRUE),
        label = paste0(merged$hb_name, ":", " ", round(merged$percentage_occupancy), "%"),
        labelOptions = labelOptions(
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px",
          direction = "auto"),
        popup = paste0(merged$hb_name, ":", " ", round(merged$percentage_occupancy, digits = 2), "%")) %>%
      leaflet::addLegend("topleft", pal = pal, values = ~percentage_occupancy,
                         title = "Bed Occupancy",
                         opacity = 1)

  })

  # Summer map
  output$map_summer <- renderPlot({

    filtered_beds <- map_beds %>%
      filter(year == 2020,
             winter_flag == "Summer")

    merged <- sp::merge(shapes, filtered_beds) %>%
      select(hb_name, percentage_occupancy, geometry)

    pal <- colorBin("BuPu", domain = merged$percentage_occupancy)

    merged %>%
      leaflet() %>%
      addTiles() %>%
      addProviderTiles(providers$OpenStreetMap) %>%
      addPolygons(
        fillColor = ~ pal(percentage_occupancy),
        weight = 2,
        opacity = 1,
        color = "white",
        dashArray = "3",
        fillOpacity = 0.7,
        highlight = highlightOptions(
          weight = 5,
          color = "#666",
          dashArray = "",
          fillOpacity = 0.7,
          bringToFront = TRUE),
        label = paste0(merged$hb_name, ":", " ", round(merged$percentage_occupancy), "%"),
        labelOptions = labelOptions(
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px",
          direction = "auto"),
        popup = paste0(merged$hb_name, ":", " ", round(merged$percentage_occupancy, digits = 2), "%")) %>%
      leaflet::addLegend("topleft", pal = pal, values = ~percentage_occupancy,
                         title = "Bed Occupancy",
                         opacity = 1)
  })
  
  
  # COVID tab --------------------------------------------------------------------
  
  # Date slider (reactive())
  quart <- reactive({
    seq(input$coivd_date_range[1], input$coivd_date_range[2], by = 1)
  })
  
  # Action button
  action_but <- eventReactive(input$update, ignoreNULL = FALSE, {
    clean_admissions %>%
      filter(date %in% quart(),
             specialty_name %in% input$specialty_input,
             hb %in% input$hb_input,
             admission_type %in% c("Elective Inpatients",
                                   "Emergency Inpatients",
                                   "Transfers"))
  })
  
  # admissions_episodes_plot - final plot
  output$admissions_episodes_plot <- renderPlot({
    validate(
      need(nrow(action_but()) > 0, "No Data in this specialty for this Health Board")
    )
    action_but() %>%
      ggplot(aes(x = date, y = episodes, col = admission_type)) +
      geom_point() +
      geom_line()
  })
  
  # placeholder plot
  output$dermatology_plot <- renderPlot({
    clean_beds %>%
      filter(specialty_name == "Dermatology") %>%
      ggplot(aes(quarter)) +
      geom_histogram(stat = "count")
  })
  
  
  # placeholder text field
  output$icu_text_placeholder <- renderText({
    print("this is placeholder text for the description of the plot in the COVID tab")
  })
  
  # A&E tab --------------------------------------------------------------------
  
  # action button
  date_react <- reactive({
    seq(input$ae_date_range[1],
        input$ae_date_range[2],
        by = 1)
  })
  
  # interactivity for buttons
  filtered_clean_ae <- eventReactive(input$update_ae_button, {
    clean_ae %>%
      select(date, month, year, hbt, department_type, var = input$selecty) %>%
      filter(department_type == input$department_type) %>%
      filter(date %in% date_react())
  })
  
  # a&e_emergency_plot - final plot
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
  
  # a&e_stats_plot - final plot
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
  
  # placeholder text
  output$ae_text_placeholder <- renderText({
    print("this is placeholder text for the description of the plot in the A&E tab")
  })
  
  # Demographics tab -----------------------------------------------------------
  
  # placeholder plot
  output$neurology_plot <- renderPlot({
    clean_beds %>%
      filter(specialty_name == "Neurology") %>%
      ggplot(aes(quarter)) +
      geom_histogram(stat = "count")
  })

  # placeholder text
  output$stat_text <- renderText({
    print("text can go here if we like")
  })
  
}