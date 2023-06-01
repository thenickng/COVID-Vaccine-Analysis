library(shiny)
library(plotly)
library(dplyr)
library(scales)
library(rlang)
library(stringr)
library(lubridate)
library(tidyverse)
library(ggplot2)
library(maps)


# Load data
state_vacc <- read.csv("us_state_vaccinations.csv", stringsAsFactors = FALSE)
state_vacc$date <- as.Date(state_vacc$date, "%Y-%m-%d")



server <- function(input, output) {
  # Intro Part
  output$purpose1 <- renderText({
    paste("With the latest updates from the World Health Organization(WHO), COVID-19 has been officially 
          announced to be no longer constituted as a public health emergency of international concern 
          and transitioned to a persistent health issue, symbolizing for a significant historical moment 
          in human history. Is it actually the end though? While this development brings hope, we must 
          remain vigilant given the ongoing cases of infection and the continued vaccination efforts. 
          We are interested in understanding the true impact of COVID-19, specifically by exploring the 
          effectiveness of vaccination at the state level, the distribution of medical resources, and the 
          comprehensive coverage of healthcare services. Some main questions we are center on includes:")
  })
  
  output$purpose2 <- renderText({ 
    paste("With these questions in mind, our aim is to derive analytical insights that can provide a 
  foundation for shaping future policies, aspired to inform future policy decisions aimed at increasing 
  vaccine acceptance, improving information dissemination, ensuring equitable access, and boosting overall 
  vaccination rates.")
  })
  
  output$dataset <- renderText({ 
    paste("This dataset collected state-by-state data on United 
    States COVID-19 vaccinations which was sourced from Our World in Data (OWID). OWID is a scientific 
    online publication dedicated to addressing global issues such as poverty, disease, and inequality. 
    The Our World in Data team collected and updated the vaccination data daily depending on the most recent
    data from the United States Centers for Disease Control and Prevention, and estimated the population data
    from the last revision of the United Nations World Population Prospects. The data was collected under the
    motivation of making the existing research and data accessible and understandable, providing a 
    comprehensive perspective on global living conditions, and achieving more progress people are capable of. 
    The dataset has 53,733 rows of observations and 16 columns including date, location, people_vaccinated, 
    people_fully_vaccinated, and people_vaccinated_per_hundred, etc.. Some differences of the population 
    between the number in the dataset and the ones reported by the government could be observed due to various 
    differences in measures. The population in our dataset uses the total population in each state, while the 
    official data reports the vaccination coverage as the percentage of eligible individuals who have been 
    vaccinated, which typically refers only to adult population. In addition, clinical trials participants on 
    the vaccine arm are excluded since such data is largely unavaliable especially for the ongoing trials.")
  })
  
  output$limitations <- renderText({
    paste("There are several challenges and limitations that we might need to consider while developing our 
          Shiny app on COVID vaccination data in the US. One of the most significant challenges that we may 
          run into is data quality and reliability. The vaccination data can be complex, messy, and may not 
          always be up-to-date, so it is important to have a reliable source of data to ensure the accuracy 
          of our app’s output. Additionally, the data may have different levels of precision depending on the 
          source, which can impact how we visualize and analyze the data. Another challenge is data privacy 
          and security. As vaccination data is sensitive and sometimes protected information, we will need to 
          ensure that we comply with data privacy regulations and protect user data when developing our app. 
          Furthermore, developing a Shiny app requires some programming skills, and we need to make sure we 
          have a good understanding of the R programming language to build a functional and interactive app. 
          Finally, the success of our Shiny app may also depend on the availability of the data and the speed
          at which it is updated. We must ensure that our app can handle real-time data and provide timely 
          insights to our users.")
  })
  
  # Viz1 Intro
  output$viz1_intro <- renderText({
    paste("This visualization allows us to analyze each aspect of our data for each individual state. Unfortunately, New 
          York does not have their information available, but we still can compare the status of each state in combating covid. 
          Once you select a category, you can see a state's activeness in taking vaccines. The more green a state is, the more
          vaccination it has. The more red a state is, the fewer vaccination is has.
          In this visualization, you can compare total vaccinations, total distributed, people vaccinated, 
          people fully vaccinated per hundred,total vaccinations per hundred, people fully vaccinated, 
          people vaccinated per hundred, distributed per hundred, and share doses used between states.")
  })
  
  output$viz1_p2 <- renderText({
    paste("The reason why we are interest in this is to see which states are actively trying to combat covid.
          Is it the democratic states or republican states? With this visualization, we can analyze trends in population,
          political idealogy, and other factors that can help us explain this activeness with vaccines.")
    
  })
  
  
  # Viz1 Part
  output$vacc_map <- renderPlotly({
    state_vacc$location <- tolower(state_vacc$location)
    their_cat <- gsub(" ", "_", input$cat_select)
    latest_state_vacc <- state_vacc %>%
      group_by(location) %>%
      filter(date == max(date))
    state_shape <- map_data("state")
    combined_vacc_state <- left_join(state_shape, latest_state_vacc, by = c("region" = "location"))
      viz1 <- ggplot(combined_vacc_state) +
      geom_polygon(mapping = aes(x = long,
                                 y = lat,
                                 group = group,
                                 text = str_to_title(region),
                                 fill = !!sym(their_cat))) +
      scale_fill_continuous(low = 'red',
                            high = 'green',
                            labels = label_number_si()) +
      labs(title = paste0(input$cat_select, " most recently ", "(", max(state_vacc$date), ")"),
           fill = input$cat_select)
    return(ggplotly(viz1))
  })
  
  # Viz1 Results
  output$viz1_details <- renderText({
    their_choice <- gsub(" ", "_", input$cat_select)
    most_recent <- state_vacc %>%
      filter(date == max(date) & location != "United States")
    highest <- most_recent %>%
      filter(!!sym(their_choice) == max(!!sym(their_choice), na.rm = TRUE))
    lowest <- most_recent %>%
      filter(!!sym(their_choice) == min(!!sym(their_choice), na.rm = TRUE))
    average <- most_recent %>%
      summarise(average = mean(!!sym(their_choice), na.rm = TRUE))
    paste0("On ", max(state_vacc$date), " we can see that ", highest$location, " has the highest ", 
           input$cat_select, " with ", highest[[their_choice]], " and ", lowest$location, " has the lowest with ",
           lowest[[their_choice]], ". The average ", input$cat_select, " in the United States is ", 
           round(average$average, 2), ".")
  })
  
  
  
  # Viz2 Part
  output$bar_chart <- renderPlotly({ 
    temp_df <- state_vacc %>%
      filter(!is.na(date)) %>%
      filter(!is.na(total_vaccinations)) %>%
      filter(!is.na(total_distributed)) %>%
      filter(!is.na(total_vaccinations)) %>%
      filter(!is.na(location))
    
    filtered_data <- temp_df %>%
      filter(as.Date(date) == as.Date(input$dateSlider)) %>%
      filter(!is.na(date) & as.Date(date) == input$dateSlider) 
      
    top_states <- filtered_data %>%
      mutate(ratio = total_vaccinations / total_distributed) %>%
      arrange(desc(ratio)) %>%
      head(input$numCountries) 
    
    bar_chart <- ggplot(top_states, aes(x = reorder(location, -ratio), y = ratio)) +
      geom_bar(stat = "identity", fill = "blue") +
      labs(
        title = "Top Entities with Highest Vaccination Ratio",
        x = "State",
        y = "Vaccination Ratio"
      ) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggplotly(bar_chart)  
  })
  
  # Viz2 description
  output$viz2_details <- renderText({
    paste("This insightful visualization explores vaccination ratios across various states 
    and spans a certain time period. It's a product of careful research, compiling data 
    from credible health departments and agencies. The graph isn't just a bunch of 
    numbers—it's a clear portrayal of our progress in the battle against disease through 
    the power of immunization. Our goal with this graph is to make vaccination data more 
    accessible, allowing for an in-depth comparison across regions. Presenting the data 
    visually helps foster informed discussions about public health strategies, ultimately 
    guiding us towards effective vaccination initiatives. Think of this as a snapshot of 
    our nation's health narrative, demonstrating the intricate dance between policy-making,
    healthcare infrastructure, and public response.")
  })
  
  # Viz3 Part
  output$state_total_vacc_plot <- renderPlotly({
    
    state_vacc$date <- as.Date(state_vacc$date)
    
    selected_data <- state_vacc %>% 
      filter(as.integer(substr(date, 1, 4)) >= input$user_select_date[1] &
               as.integer(substr(date, 1, 4)) <= input$user_select_date[2] &
               location %in% input$user_select_state &
               !is.na(total_vaccinations))
    
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
  
  # Viz3 description
  output$plot_description <- renderUI({
    description <- paste("The line chart above shows the total vaccinations or saying total number of COVID-19 doses administered in each year from 2021 to 2023 for California, New York State, Pennsylvania, Washington, and American Samoa."," ", "I choose the line plot to visualize the total vaccination data for the five states - California, New York State, Pennsylvania, Washington, and American Samoa - because it effectively reveals the trend and changes in the number of vaccinations administered over the years. The line plot is clearly showing the difference on the number of total vaccinations each states administered and it's a great tool for comparing between the data. It also easily to see the trend of the vaccinations through the line plot, whether it is increasing in a higher rate or lower rate through years.", " ", "Based on the plot, we can see California has the most total vaccinations of COVID in these five states and it's increasing in a high rate between year to year. Comparatively, the other four states are increasing at a lower rate than California. In these five states, we can see total vaccinations in American Samoa from the chart is almost stay in the value of 0, which is due to the number of total vaccinations here has a comparatively low number than the other states(e.g. total vaccination in California in 2021:816301, total vaccination in American Samoa in 2021: 2124). From the plot, all of the total vaccinations in five states are increasing at a higher rate between 2021 to 2022 than 2022 to 2023.", " ", "The reason to choose these five states:", "-- California: State with the highest number of COVID-19 cases", "-- American Samoa: State with the lowest COVID-19 cases", "-- New York State: State with most death due to the COVID-19", "-- Pennsylvania: State with the highest death ratio of COVID-19", "-- Washington: State with the earliest COVID-19 case", sep="<br/>")
    HTML(description)
  })
  
  
  
  
  # Conclusion Part
  output$conclusion1 <- renderText({
    paste("The World Health Organization (WHO) had made monumental changes when they officially declared COVID-19 to be a persistent health issue and no longer a global health emergency after three long years. The pandemic has drastically changed peoples lives and many individuals and groups of people are still dealing with the fallout of the pandemic and its ongoing effects. COVID-19 not only changed the lives of people, but also played a trivial role in dividing the nation based on political views. 
According to the data that was collected and analyzed throughout this project there was a discernible relationship between Right states and low vaccination rates, which was a clear juxtaposition to Left states and high vaccination rates. When comparing “Total Vaccinations Per Hundred” in Visualization 1, majority right leaning Southeastern states had low vaccination rates, with every state in that area having less than 200 vaccinations per hundred, with states such as Alabama, Louisiana and Mississippi, having less than 150 vaccinations per hundred. However, Western and Northeastern states, where the majority is left leaning politically, had the highest vaccination rates per 100 in the Country. Though there are fewer percentages of people willing to get vaccinated in red leaning states, these states are also faced with less distributed vaccines per 100, with states such as Louisiana and Wyoming having less than 250 distributed vaccines per 100. 
This comparison is vital as people living in these states are not provided with the necessary amount of vaccines and therefore do not have equal access to vaccines compared to people living in left leaning states. The data analyzed is extremely important as it shows that not only do these states have less vaccines provided per 100, but they also have a lower utility rate for vaccinations. Future policies should focus on both ensuring correct information dissemination and equal access to vaccinations and vaccination sites. Based on the large amount of falsified information and its effects on the low percentage of vaccinations, campaigns need to focus on spreading correct information. In addition, a larger amount of vaccination sites should be placed in these areas with greater volumes of vaccines being sent to these sites. This initiative has to be taken so that no matter their political beliefs or location, everybody will have equal access to life saving vaccines.
")
    
  })
}