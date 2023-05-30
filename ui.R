library(shiny)
library(plotly)
library(dplyr)
library(lubridate)
library(bslib)
# Load data
state_vacc <- read.csv("us_state_vaccinations.csv", stringsAsFactors = FALSE)

# Theme
my_theme <- bs_theme(bg = "#0b3d91", #background color
                     fg = "white", #foreground color
                     primary = "#FCC780", # primary color
                     base_font = c("Grandstander", "sans-serif")
) 

# Introductory page
intro_tab <- tabPanel(
  "Introduction",
  h2("The Purpose of Exploring COVID-19 vaccination Trends"),
  textOutput("purpose1"),
  h5("What is the relationship between the proportion of fully vaccinated people by states and the 
    political leaning of states?"),
  h5("Which states have the most efficient utilization of vaccinations in relation to the number of 
     vaccinations distributed?"),
  h5("What are the key findings in the total number of COVID-19 vaccinations administered over the years
  (2021 to 2023) for the selected states of significance?"),
  textOutput("purpose2"),
  h2("The Dataset"),  
  tags$a(href = "https://data.world/ourworldindata/covid-19-vaccinations/workspace/file?filename=us_state_vaccinations.csv", "US State Vaccination"),
  textOutput("dataset"), 
  h2("Limitations & Challenges"),
  textOutput("limitations")
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
  theme = my_theme,
  intro_tab,
  viz1_tab,
  viz2_tab,
  viz3_tab,
  conclusion_tab
)