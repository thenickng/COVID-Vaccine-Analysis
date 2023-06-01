library(shiny)
library(plotly)
library(dplyr)
library(lubridate)
library(bslib)

# Load data
state_vacc <- read.csv("us_state_vaccinations.csv", stringsAsFactors = FALSE)
state_vacc$date <- as.Date(state_vacc$date)
#<<<<<<< HEAD
var1 <- c("total vaccinations", "total distributed", "people vaccinated", "people fully vaccinated per hundred",
          "total vaccinations per hundred", "people fully vaccinated", "people vaccinated per hundred", 
          "distributed per hundred", "share doses used")

# Theme
my_theme <- bs_theme(bg = "#009EDB", #background color
                     fg = "white", #foreground color
                     primary = "#FCC780", # primary color
                     base_font = "Helvetica")

# Introductory page
intro_tab <- tabPanel(
  "Introduction",
  h2("The Purpose of Exploring COVID-19 vaccination Trends"),
  textOutput("purpose1"),
  p(tags$b("What is the relationship between the proportion of fully vaccinated people by states and the 
    political leaning of states?")),
  p(tags$b("Which states have the most efficient utilization of vaccinations in relation to the number of 
     vaccinations distributed?")),
  p(tags$b("What are the key findings in the total number of COVID-19 vaccinations administered over the years
  (2021 to 2023) for the selected states of significance?")),
  textOutput("purpose2"),
  h2("The Dataset"),  
  tags$a(href = "https://data.world/ourworldindata/covid-19-vaccinations/workspace/file?filename=us_state_vaccinations.csv", "US State Vaccination"),
  textOutput("dataset"), 
  h2("Limitations & Challenges"),
  textOutput("limitations"),
  tags$img(src = "https://news.yale.edu/sites/default/files/styles/featured_media/public/vaccination-campaign.jpg?itok=5zUYvkSF&c=a75e254fe1da31f2732f6b0d7bce1413",
           width = "650px",
           height = "450px")
)

# Visualization 1
viz1_tab <- tabPanel(
  "State Vaccination Differences",
  sidebarLayout(
    sidebarPanel(
      
      
      # Choose what variable they want to see
      selectInput(inputId = "cat_select",
                  label = "Select a vaccine category", 
                  choices = var1,
                  multiple = FALSE)
    ),
    mainPanel(
      plotlyOutput("vacc_map"),
      h4("Plot Description"),
      textOutput("viz1_intro"),
      br(),
      textOutput("viz1_p2"),
      br(),
      textOutput("viz1_details")
    )
  )
)


# Visualization 2
viz2_tab <- tabPanel(
  "Vaccination Ratios",
  sidebarLayout(
    sidebarPanel(
      sliderInput("dateSlider",
                  "Select Date",
                  min = as.Date("2021-01-12"),
                  max = as.Date("2023-05-10"),
                  value = as.Date("2023-05-10")
      ),
      
      sliderInput("numCountries",
                  "Select Number of Countries",
                  min = 1,
                  max = 20,  
                  value = 10
      ),
      
    
    ),
    mainPanel(
      plotlyOutput("bar_chart"),
      h4("Plot Description"),
      textOutput("viz2_intro"),
      br(),
      textOutput("viz2_p2"),
      br(),
      textOutput("viz2_details")
    )
  )
)

# Visualization 3
viz3_tab <- tabPanel(
  "Vaccination Administered",
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
      plotlyOutput("state_total_vacc_plot"),
      h4("Plot description"),
      htmlOutput("plot_description")
    )
  )
)



# Conclusion Page
conclusion_tab <- tabPanel(
  "Conclusion",
  h2("The Impacts of Covid-19 Vaccination Trends"),
  textOutput("conclusion1")
  
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