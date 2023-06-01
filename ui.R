library("ggplot2")
library("plotly")
library("dplyr")
library("styler")
library("bslib")
library("markdown")
library("shiny") 
library("shinythemes")
library("maps")

health_df <- read.csv("data/health_ineq_online_table_income_percent_year.csv", stringsAsFactors = FALSE)

#VIS 1- widget 

bar_plot <- sidebarPanel(
  selectInput(
    inputId = "cat_user",
    label = "Income Percentile",
    choices = unique(health_df$pctile),
    selected = 50,
    multiple = TRUE),
  
  sliderInput("scale", label = "Years", min = 2001, max = max(health_df$year), value = c(2001, 2014), sep = "", step = 1)
)

lineplot_main <- mainPanel(
  plotlyOutput(outputId = "lineplot")
)

#VIS 2- widget 

bar_plot2 <- sidebarPanel(
  selectInput(
    inputId = "dog_user",
    label = "Income Percentile",
    choices = unique(health_df$pctile),
    selected = 50,
    multiple = TRUE),

    # sliderInput("scale", label = "Years", min = 2001, max = max(health_df$year), value = c(2001, 2014), sep = "", step = 1)

)

lineplot_main2 <- mainPanel(
  plotlyOutput(outputId = "lineplot2")
)
 
 #UI
ui <- fluidPage(
  includeCSS("style.css"), 
  theme = shinythemes::shinytheme("yeti"),
  navbarPage("Life Expectancy Visualizations", 
  tabPanel("Introduction",  
        img(id = "map-img", src = "people_map.jpg", alt = "map"),
        mainPanel(class = "ctr", 
            h3(class = "title", "Overview"),
                 p("Our main question is how life expectancy changes across the U.S and the greater world under factors like gender, race, and income distribution. 
                 This question is important in acknolwledging the disparities in the U.S and how they can impact the health of disadvantaged groups. "),
            h4(class = "title", "Selected Dataset"),
                 p("To address this we will analyze each of these factors individually and how they might be associated. 
                The data used was collected and published by the", a(href = 'https://healthinequality.org/data/ ', "The Health Inequality Project", ".")),
                 p("The health inequality project provides profound insight on the disparities of life expectancy in America based on gender and income. We will be using a dataset based upon income and gender in table 2 of the website. The data was collected from history from 1999 - 2014 from tax and social security records to record income data. They try to identify people by social security records in which they can identify where they are located and the size of their household. This data is collected by the groups from ages of 40 to 76. It is important to analyze this data and use the findings to address how everyone can have the equal opportunity to live healthy lives."),
             h4(class = "title", "Ethical Questions and Limitations"),
                p("One aspect that we have noticed while examining the document regarding data collection methods is the exclusion of individuals without a tax return or social security record. This omission of information may lead to complications and raise questions regarding the future implementation of the dataset. By omitting such individuals, we fail to acquire essential data that is necessary for a comprehensive analysis. Additionally, the age range chosen, specifically from 40 to 70 years, raises some concerns as it primarily focuses on older individuals. It would be beneficial for our study to include individuals from various age groups to compare life expectancy and income, as this narrow age range may result in generalizations regarding life expectancy based on income. Additionally, the dataset is not pulled from the homeless population and may not reflect the reality of annual income for lower income percentiles in America"),
            h4(class = "title", "Questions"),
                 p(tags$ol(
                     tags$li("Which gender tends to have a higher mean household income?"),
                     tags$li("Which gender tends to have a longer unadjusted life expectancy?"),
                     tags$li("How does life expectancy in America compare with the rest of the world?")
                   )
                )
        )
  ), 
  tabPanel("Comparing Household Income",
    "Visualization",
     sidebarLayout(
      bar_plot, #Widget
      lineplot_main #Graph 
     ),
      h1("Insights"), 
      p("Accross all income percentiles, it is clear that women make significantly less than men, especially at the median household income. Towards the extreme incomes, the top and bottom 10 percent, this pattern is not as evident as these individuals are not impacted by gender expectations nearly as much as those in the bulk of income earners. Additionally, we can see how annual household income has changed over time and the drops that have occurred. It is clear that inflation and other economic factors has caused a severe drop in annual household income for all income percentiles, with the exception of the top 5%. Additionally, we can see how the 2008 recession impacted different groups and how it is very clear that it was more impactful for those in the bottom 5 percent than the those in the 25th percentile.")
  ), 
  tabPanel("Comparing Life Expectancy", 
    "Visualization",
     sidebarLayout(
      bar_plot2, #Widget
      lineplot_main2 #Graph 
     ),
      h1("Insights"), 
      p("Across all income percentiles, women live longer than men. This varies greatly accross different incomes in which we can see that those in the top 90% of income earners live upwards of 15 years longer than those in the bottom 10%. Although economical factors cannot be a sole predictor of longevity and life expectancy, it is clear that income plays a massive role in life expectancy in the U.S where healthcare and access to health education is highly dependent on income. Additionally, life expectancy seems to be on an upward trend for those in the upper percentile while more stagnant for those in the lower percentile. This could be attributed to the wealthy benefitting from advancements in healthcare and medicine while the poor are unable to gain access to these resources.")
  
  ),  
  tabPanel("World Gender Analysis",
      sidebarPanel(
        radioButtons(
          inputId = "gender",
          label = h3("Which gender would you like to analyze?"),
          choices = list("Female" = "le_F", "Male" = "le_M"),
          selected = "le_F"
        )
      ),
      mainPanel(
        plotlyOutput(outputId = "map"))
  ),
  
  tabPanel("Conclusion", 
    h2("Takeaway 1: Gender disparities exist among the income-earning majorities in the U.S "), 
    h4("From 2001-2014, the average household income for women is significantly less than men. This income disparity averages to around $10,830 and has the greatest disparity towards the upper percentile. Gender acts as a significant factor of household income for occupations that place individuals between 10-90% of income earners in the U.S. Towards the tail ends of income earners, gender acts as a less significant factor for income as these occupations are generally skewed by factors like generational wealth, or on the opposite end of the spectrum, inability to work or disabilities. Overall, the income disparity that existed in 2001 has not progressed and there needs to be greater advocacy for women to be paid more and receive the support to advocate for higher wages. "),
    h2("Takeaway 2: Life expectancy for women is higher than for men across the U.S "), 
    h4("Due to social, biological, and behavioral differences, women live upwards of 10 years longer than men. Similar to income, the differences in life expectancy seem to decline among the top and bottom household income earners in the U.S. It seems that this difference has been declining over time, which may be attributed to societal changes and improvements in healthcare for women. "),
    h2("Takeaway 3: Life expectancy in the U.S. is relatively high compared to the rest of the world"), 
    h4("The map demonstrates the average female life expectancy being around 82 years old and 78 years old for males. As such, compared to the rest of the world, the United States is near the top in life expectancy. Especially when contrasted with Chad, where the average female is estimated to live 69 years and the average man, 67. Surpassing America, countries such as Australia and Spain are averaging 86 years for females and 81 for males. These maps are important because they uncover global health disparities and highlight variations in healthcare systems, socioeconomic conditions, and societal practices. This fosters equitable public health initiatives and allows countries to compare and identify the best practices.")
  ) )
)


shinyUI(ui)
# page 1- introduction 

# page 2- visual 1 

# page 3- visual 2 

# page 4- visual 3 

# page 5- conclusion 
