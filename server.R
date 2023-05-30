library(shiny)
library(plotly)
library(dplyr)

# Load data
state_vacc <- read.csv("us_state_vaccinations.csv", stringsAsFactors = FALSE)


server <- function(input, output) {
  
}