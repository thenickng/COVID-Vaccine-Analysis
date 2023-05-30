library(shiny)
library(plotly)
library(dplyr)
library(lubridate)

# Load data
state_vacc <- read.csv("us_state_vaccinations.csv", stringsAsFactors = FALSE)

# Introductory page
intro_tab <- tabPanel(
  "Introductory Page"
)

# Visualization 1
viz1_tab <- tabPanel(
  "Visualization1 Page"
)


# Visualization 2
viz2_tab <- tabPanel(
  "Visualization2 Page"
)



# Visualization 3
viz3_tab <- tabPanel(
  "Visualization3 Page",
  h1("Total Vaccinations (COVID-19 doses) administered from 2021 to 2023 for Selected States"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "user_select_date", label = h3("Date:"),
        min = 2021,
        max = 2023,
        value = c(2021, 2023), 
        step = 1
      ),
      selectInput(
        inputId = "user_select_state", label = h3("Select States"),
        choices = c("California", "American Samoa", "Washington", "New York State", "Pennsylvania"),
        selected = "Washington",
        multiple = TRUE
      )
    ),
    mainPanel(
      plotlyOutput("state_total_vacc_plot")
      # textOutput("plot_description")
    )
  )
)



# Conclusion Page
conclusion_tab <- tabPanel(
  "Conclusion Page"
)



ui <- navbarPage(
  "INFO201 Final Project",
  intro_tab,
  viz1_tab,
  viz2_tab,
  viz3_tab,
  conclusion_tab
)