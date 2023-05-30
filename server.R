library(shiny)
library(plotly)
library(dplyr)
library(scales)

# Load data
state_vacc <- read.csv("us_state_vaccinations.csv", stringsAsFactors = FALSE)
state_vacc$date <- as.Date(state_vacc$date)


server <- function(input, output) {
  # Intro Part
  
  
  
  # Viz1 Part
  output$vacc_map <- renderPlotly({
    state_vacc$location <- tolower(state_vacc$location)
    latest_state_vacc <- state_vacc %>%
      filter(input$year_select == format(date, "%Y"))%>%
      group_by(location)
    state_shape <- map_data("state")
    combined_vacc_state <- left_join(state_shape, latest_state_vacc, by = c("region" = "location"))
      viz1 <- ggplot(combined_vacc_state) +
      geom_polygon(mapping = aes(x = long,
                                 y = lat,
                                 group = group,
                                 fill = input$cat_select)) +
      scale_fill_continuous(low = 'red',
                            high = 'green',
                            labels = label_number_si()) +
      labs(title = paste(input$cat_select, "in", input$year_select))
    return(ggplotly(viz1))
  })
  
  
  
  # Viz2 Part
  
  
  
  
  # Viz3 Part
  output$state_total_vacc_plot <- renderPlotly({
    selected_data <- state_vacc %>% 
      filter(as.integer(substr(date, 1, 4)) >= input$user_select_date[1] &
               as.integer(substr(date, 1, 4)) <= input$user_select_date[2] &
               location %in% input$user_select_state)
    
    state_total_vacc_plot <- ggplot(selected_data) +
      geom_line(aes(x = date, y = total_vaccinations, color = location)) +
      labs(title = "Total Vaccinations of COVID-19 in selected states from 2021 to 2023",
           x = "Date",
           y = "Total Vaccinations",
           color = "States") +
      scale_x_date(date_labels = "%Y", date_breaks = "year") +
      scale_y_continuous(labels = label_number_si()) +
      scale_color_brewer(palette = "Set2")

    return(ggplotly(state_total_vacc_plot))
  })
  
  
  
  
  
  # Conclusion Part
}