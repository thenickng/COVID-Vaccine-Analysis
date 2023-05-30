library(shiny)
library(plotly)
library(dplyr)

# Load data
state_vacc <- read.csv("us_state_vaccinations.csv", stringsAsFactors = FALSE)

# Introductory page
intro_tab <- tabPanel(
  
)

# Visualization 1
viz1_tab <- tabPanel(
  
)


# Visualization 2
viz2_tab <- tabPanel(
  
)



# Visualization 3
viz3_tab <- tabPanel(
  
)



# Conclusion Page
conclusion_tab <- tabPanel(
  
)



ui <- navbarPage(
  "INFO201 Final Project",
  intro_tab,
  viz1_tab,
  viz2_tab,
  viz3_tab,
  conclusion_tab
)