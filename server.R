library(shiny)
library(plotly)
library(ggplot2)
library(tidyr)
library(dplyr) 

#le_df <- read.csv("data/le_database.csv", stringAsFactors = FALSE)
data <- read.csv("C:/Users/knel2/Downloads/health_ineq_online_table_1 (1).csv", stringAsFactors = FALSE)

# summary information 

# server
server <- function(input, output) {
  output$climate_graph <- renderPlotly(
    data%>%group_by(gnd)%>%summarize(total_life_Expec = sum(le_agg)),
    gnd_life_expectacy<- ggplot(data = changes_life_expentacy) +
    geom_col(aes(x= gnd , y= total_life_Expec, fill = gnd)) + scale_color_brewer(palette = "Set3") +
      
    labs(title = "Trends of life Expentacy through gender", x = "Gender", y = "life expectancy"), 
    ggplotly(gnd_life_expectacy)
  )
}
shinyServer(server)