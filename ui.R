library("plotly")
library("shiny")
library("shinythemes")

ui <- fluidPage(
  includeCSS("style.css"), 
  theme = shinythemes::shinytheme("yeti"),
  navbarPage("Life Expectancy Visualizations", 
  tabPanel("Introduction",
         #img(id = "map-img", src = "https://www.clipartmax.com/png/middle/253-2533695_manage-all-health-monitoring-data-in-one-place-google-analytics-icons-free.png", alt = "map"),
        mainPanel(
            h3(class = "title", "Overview"),
                 p("Our main question is how life expectancy changes across the U.S under factors like gender, race, and income distribution. 
                 This question is important in acknolwledging the disparities in the U.S and how they can impact the health of disadvantaged groups. "),
            h4(class = "title", "Selected Dataset"),
                 p("To address this we will analyze each of these factors individually and how they might be associated. 
                The data used was collected and published by the", a(href = 'https://healthinequality.org/data/ ', "The Health Inequality Project", ".")),
                 p("The health inequality project provides profound insight on the disparities of life expectancy in America based on gender and income. The data was collected from history from 1999 - 2014 from tax and social security records to record income data. They try to identify people by social security records in which they can identify where they are located and the size of their household. This data is collected by the groups from ages of 40 to 76. It is important to analyze this data and use the findings to address how everyone can have the equal opportunity to live healthy lives."),
             h4(class = "title", "Ethical Questions and Limitations"),
                p("When looking at the data we can see the problem with the health inequality that the health system has over minority groups are reciving the help that they need. When we see the impact of the changes we have the question what is the impact of power that health systems have on people and how we can help solve this problem.
                One aspect that we have noticed while examining the document regarding data collection methods is the exclusion of individuals without a tax return or social security record. This omission of information may lead to complications and raise questions regarding the future implementation of the dataset. By omitting such individuals, we fail to acquire essential data that is necessary for a comprehensive analysis. Additionally, the age range chosen, specifically from 40 to 70 years, raises some concerns as it primarily focuses on older individuals. It would be beneficial for our study to include individuals from various age groups to compare life expectancy and income, as this narrow age range may result in generalizations regarding life expectancy based on income."),
            h4(class = "title", "Questions"),
                 p(tags$ol(
                     tags$li("Which gender tends to have a longer unadjusted life expectancy?"),
                     tags$li("Which gender tends to have a higher mean household income?"),
                     tags$li("How does income correlate with life expectancy?")
                   )
                )
        )
  ), 
  tabPanel("V1"), tabPanel("V2"),tabPanel("V3"), tabPanel("Conclusion") )
)
shinyUI(ui)
# page 1- introduction 

# page 2- visual 1 

# page 3- visual 2 

# page 4- visual 3 

# page 5- conclusion 
