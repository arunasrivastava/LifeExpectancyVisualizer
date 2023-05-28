library("plotly")
library("shiny")
library("shinythemes")

ui <- fluidPage(
  includeCSS("style.css"), 
  theme = shinythemes::shinytheme("yeti"),
  navbarPage("Life Expectancy Visualizations", tabPanel("Introduction"), tabPanel("V1"), tabPanel("V2"),tabPanel("V3"), tabPanel("Conclusion") )
)
shinyUI(ui)
# page 1- introduction 

# page 2- visual 1 

# page 3- visual 2 

# page 4- visual 3 

# page 5- conclusion 
