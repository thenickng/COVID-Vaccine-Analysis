library(shiny)
library(plotly)
library(dplyr)

# Load data
state_vacc <- read.csv("us_state_vaccinations.csv", stringsAsFactors = FALSE)


server <- function(input, output) {
  # Intro Part
  
  
  
  # Viz1 Part
  
  
  
  # Viz2 Part
  
  
  
  
  # Viz3 Part
  output$state_total_vacc <- renderPlotly({
    
    selected_data <- state_vacc %>% 
      filter(year %in% input$user_select_year[1]:input$user_select_year[2] & country %in% input$user_select_state)
    
    state_total_vacc_plot <- ggplot(selected_data) +
      geom_line(aes(x = date, y = total_vaccinations, color = location)) +
      labs(title = "Total Vaccinations of COVID-19 in selected states from 2021 to 2023",
           x = "Year",
           y = "Total Vaccinations",
           color = "States") +
      scale_x_date(date_labels = "%Y", date_breaks = "year") +
      scale_y_continuous(labels = label_number_si()) +
      scale_color_brewer(palette = "Set2")

    return(ggplotly(state_total_vacc_plot))
  })
  
  
  
  
  
  # Conclusion Part
}