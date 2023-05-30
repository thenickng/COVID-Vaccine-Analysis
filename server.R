library(shiny)
library(plotly)
library(dplyr)
library(scales)

# Load data
state_vacc <- read.csv("us_state_vaccinations.csv", stringsAsFactors = FALSE)


server <- function(input, output) {
  # Intro Part
  
  
  
  # Viz1 Part
  
  
  
  # Viz2 Part
  
  
  
  
  # Viz3 Part
  output$state_total_vacc_plot <- renderPlotly({
    
    selected_data <- state_vacc %>% 
      filter(date %in% input$user_select_date[1]:input$user_select_date[2] & location %in% input$user_select_state)
    
    state_vacc$date <- as.Date(state_vacc$date)
    
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