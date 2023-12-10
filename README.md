
## INFO 201 "Foundational Skills for Data Science" — Winter 2023

Authors: Nick Ng, Sally Shen, Candice Hu, Sid Thiagarajan, Anushka Damidi

**(https://nicolng.shinyapps.io/final-project-ssshenjy/)**

Please create the necessary files for your multi-page Shiny app in this GitHub repository. Consult the Canvas assignment for more details. Be sure to publish your app on Shinyapps.io.

When you are finished, please add the text from your introductory and concluding pages below. You might want to use this GitHub repository as part of your digital portfolio, so you want this README.md to offer a brief description of the project and key takeaways.

Feel free to delete these instructions for your final README.md file and to make your GitHub repository public if you would like others to be able to see it. 

# Introduction


## The Purpose of Exploring COVID-19 vaccination Trends

With the latest updates from the World Health Organization(WHO), COVID-19 has been officially announced to be no longer constituted as a public health emergency of international concern and transitioned to a persistent health issue, symbolizing for a significant historical moment in human history. Is it actually the end though? While this development brings hope, we must remain vigilant given the ongoing cases of infection and the continued vaccination efforts. We are interested in understanding the true impact of COVID-19, specifically by exploring the effectiveness of vaccination at the state level, the distribution of medical resources, and the comprehensive coverage of healthcare services. Some main questions we are center on includes:

- What is the relationship between the proportion of fully vaccinated people by states and the political leaning of states?

- Which states have the most efficient utilization of vaccinations in relation to the number of vaccinations distributed?

- What are the key findings in the total number of COVID-19 vaccinations administered over the years(2021 to 2023) for the selected states of significance?

With these questions in mind, our aim is to derive analytical insights that can provide a foundation for shaping future policies, aspired to inform future policy decisions aimed at increasing vaccine acceptance, improving information dissemination, ensuring equitable access, and boosting overall vaccination rates.


## The Dataset
[US State Vaccination](https://data.world/ourworldindata/covid-19-vaccinations/workspace/file?filename=us_state_vaccinations.csv)

This dataset collected state-by-state data on United States COVID-19 vaccinations which was sourced from Our World in Data (OWID). OWID is a scientific online publication dedicated to addressing global issues such as poverty, disease, and inequality. The Our World in Data team collected and updated the vaccination data daily depending on the most recentdata from the United States Centers for Disease Control and Prevention, and estimated the population data from the last revision of the United Nations World Population Prospects. The data was collected under the motivation of making the existing research and data accessible and understandable, providing a comprehensive perspective on global living conditions, and achieving more progress people are capable of. The dataset has 53,733 rows of observations and 16 columns including date, location, people_vaccinated, people_fully_vaccinated, and people_vaccinated_per_hundred, etc.. Some differences of the population between the number in the dataset and the ones reported by the government could be observed due to various differences in measures. The population in our dataset uses the total population in each state, while the official data reports the vaccination coverage as the percentage of eligible individuals who have been vaccinated, which typically refers only to adult population. In addition, clinical trials participants on the vaccine arm are excluded since such data is largely unavaliable especially for the ongoing trials.


## Challenges & Limitations

There are several challenges and limitations that we might need to consider while developing our Shiny app on COVID vaccination data in the US. One of the most significant challenges that we may run into is data quality and reliability. The vaccination data can be complex, messy, and may not always be up-to-date, so it is important to have a reliable source of data to ensure the accuracy of our app’s output. Additionally, the data may have different levels of precision depending on the source, which can impact how we visualize and analyze the data. Another challenge is data privacy and security. As vaccination data is sensitive and sometimes protected information, we will need to ensure that we comply with data privacy regulations and protect user data when developing our app. Furthermore, developing a Shiny app requires some programming skills, and we need to make sure we have a good understanding of the R programming language to build a functional and interactive app. Finally, the success of our Shiny app may also depend on the availability of the data and the speed at which it is updated. We must ensure that our app can handle real-time data and provide timely insights to our users.



# Conclusion / Summary Takeaways

The World Health Organization (WHO) had made monumental changes when they officially declared COVID-19 to be a persistent health issue and no longer a global health emergency after three long years. The pandemic has drastically changed peoples lives and many individuals and groups of people are still dealing with the fallout of the pandemic and its ongoing effects. COVID-19 not only changed the lives of people, but also played a trivial role in dividing the nation based on political views. 
According to the data that was collected and analyzed throughout this project there was a discernible relationship between Right states and low vaccination rates, which was a clear juxtaposition to Left states and high vaccination rates. When comparing “Total Vaccinations Per Hundred” in Visualization 1, majority right leaning Southeastern states had low vaccination rates, with every state in that area having less than 200 vaccinations per hundred, with states such as Alabama, Louisiana and Mississippi, having less than 150 vaccinations per hundred. However, Western and Northeastern states, where the majority is left leaning politically, had the highest vaccination rates per 100 in the Country. Though there are fewer percentages of people willing to get vaccinated in red leaning states, these states are also faced with less distributed vaccines per 100, with states such as Louisiana and Wyoming having less than 250 distributed vaccines per 100. 
This comparison is vital as people living in these states are not provided with the necessary amount of vaccines and therefore do not have equal access to vaccines compared to people living in left leaning states. The data analyzed is extremely important as it shows that not only do these states have less vaccines provided per 100, but they also have a lower utility rate for vaccinations. Future policies should focus on both ensuring correct information dissemination and equal access to vaccinations and vaccination sites. Based on the large amount of falsified information and its effects on the low percentage of vaccinations, campaigns need to focus on spreading correct information. In addition, a larger amount of vaccination sites should be placed in these areas with greater volumes of vaccines being sent to these sites. This initiative has to be taken so that no matter their political beliefs or location, everybody will have equal access to life saving vaccines.

