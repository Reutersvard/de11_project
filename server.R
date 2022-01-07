server <- function(input, output) {

# Overview tab -----------------------------------------------------------------

  # Left map
  output$map_left <- renderLeaflet({

    # Filter for the buttons
    filtered_beds <- clean_beds %>%
      filter(year == input$year_left,
             winter_flag == input$season_left)

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

  # Right map
  output$map_right <- renderLeaflet({

    filtered_beds <- clean_beds %>%
      filter(year == input$year_right,
             winter_flag == input$season_right)

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


  # Hospital admissions tab --------------------------------------------------------------------

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

  action_but2 <- eventReactive(input$update, ignoreNULL = FALSE, {
    clean_admissions %>%
      filter(date %in% quart(),
             specialty_name %in% input$specialty_input,
             hb %in% "Scotland",
             admission_type %in% c("Elective Inpatients",
                                   "Emergency Inpatients",
                                   "Transfers"))
  })

  # admissions_episodes_plot - final plot
  output$admissions_episodes_plot <- renderPlot({
    validate(
      need(nrow(action_but()) > 0, "No data in this specialty for this Health Board")
    )
    action_but() %>%
      ggplot(aes(x = date, y = episodes, col = admission_type)) +
      geom_point() +
      geom_line(size = 1.25) +
      labs(x = "Years",
           y = "Numbers of Episodes\n") +
      ggtitle("Specialty by Health Board") +
      theme_nhs()

  })

  # Scotland plot
  output$dermatology_plot <- renderPlot({
    action_but2() %>%
      ggplot(aes(x = date, y = episodes, col = admission_type)) +
      geom_point() +
      geom_line(size = 1.25) +
      labs(x = "Years",
           y = "Numbers of Episodes\n") +
      ggtitle("Episodes Across Scotland") +
      theme_nhs()

  })


  # hospital text
  output$hosp_text <- renderText({
    br()
    print("An episode is the time that a patient spends in the continuous
          care of one consultant, in one hospital under the same Health Board.")
  })

  # A&E tab --------------------------------------------------------------------

  # action button
  date_react <- reactive({
    seq(input$ae_date_range[1],
        input$ae_date_range[2],
        by = 1)
  })

  # interactivity for buttons
  filtered_clean_ae <- eventReactive(input$update_ae_button,
                                     ignoreNULL = FALSE, {
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
        geom_point(shape = 21) +
        geom_line(size = 1.25) +
        scale_x_continuous(breaks = 1:12) +
        labs(x = "Month",
             y = "Attendance Over 12 Hours",
             colour = "Year") +
        ggtitle("A&E Attendances Per Month, By Year") +
        theme_nhs()
    })

    output$ae_stats_plot <- renderPlot({
      filtered_clean_ae() %>%
        group_by(month, year) %>%
        summarise(attendance = sum(var, na.rm = T)) %>%
        mutate(winter_flag = case_when(month %in% c(1, 2, 3, 10, 11, 12) ~ "Winter",
                                       TRUE ~ "Summer")) %>%
        group_by(winter_flag, year) %>%
        summarise(av_attendance = mean(attendance)) %>%
        arrange(year) %>%
        ggplot(aes(x = year,
                   y = av_attendance,
                   fill = winter_flag),
               position = dodge) +
        geom_col() +
        labs(x = "Year",
             y = "A&E Attendances") +
        ggtitle("A&E Attendances Each Year, By Season") +
        theme_classic() +
        theme_nhs()

        })

    # placeholder text
    output$ae_stats_text <- renderUI({
      br()
      HTML("The percentage change year over year for winter months
            in the emergency departments is 39% whereas for summer it is 23%. 
            The difference in the compounded annual growth rate is 16%,
            building towards continued winter crises going forward")
    })

  # Demographics tab -----------------------------------------------------------

# Date slider
date_range <- reactive({
  seq(input$date_range[1], input$date_range[2], by = 1)
})

# Action button
action_button <- eventReactive(input$update_demo, ignoreNULL = FALSE, {
  clean_inpatient %>%
    filter(quarter %in% date_range(),
           hb_name %in% input$hb_name_input,
           admission_type %in% input$admission_input,
           grouped_age %in% input$checkGroup
             ) %>%
    group_by(grouped_age, quarter) %>%
    summarise(average_length_of_stay = mean(average_length_of_stay, na.rm = T))
})

# length of stay plot
output$length_of_stay_plot <- renderPlot({
  action_button() %>%
    ggplot(aes(quarter, average_length_of_stay, col = grouped_age)) +
    geom_line() +
    geom_point() +
    labs( x = "Year",
          y = "Days",
          col = "Age Group") +
    ggtitle("Average Length of Stay Per Quarter") +
    theme_nhs()
})
}
