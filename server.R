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
    
  })
  
  
  
  
  
  # Conclusion Part
}