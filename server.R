library("ggplot2")
library("plotly")
library("dplyr")
library("styler")
library("bslib")
library("markdown")
library("shiny") 
library("tidyr")
library("maps")

#VIS 1 AND 2 DF
health_df <- read.csv("data/health_ineq_online_table_income_percent_year.csv", stringsAsFactors = FALSE)

#VIS 3 DF 
data <- read.csv("data/le_database.csv", stringsAsFactors = FALSE)
df <- read.csv("data/health_ineq_online_table_country_FM.csv", stringsAsFactors = FALSE)
df <- df %>% 
  mutate(country = gsub("United States of America", "USA", country)) %>%
  mutate( country = gsub("Russian Federation", "Russia", country)) %>%
  mutate(country = gsub("Saint Vincent and the Grenadines", "Grenadines", country)) %>%
  mutate(country = gsub("Bolivia (Plurinational State of)", "Bolivia", country)) %>%
  mutate(country = gsub("Venezuela (Bolivarian Republic of)", "Venezuela", country))
map_data <- map_data("world")
merged_data <- left_join(map_data, df, by = c( "region" = "country"))




# summary information 

# server
server <- function(input, output) {
  #VIS 1 CODE 
 output$lineplot <- renderPlotly({
    health_df <- health_df %>% filter(pctile %in% input$cat_user)
    health_df <- health_df %>% filter(year >= input$scale[1])
    health_df <- health_df %>% filter(year <= input$scale[2])

    # Filter and plot data for women (F)
    women_df <- health_df %>% filter(gnd == "F")
    lineplot <- ggplot(data = women_df) +
      geom_line(mapping = aes(
        x = year, 
        y = hh_inc, 
        color = "Women",
        linetype = as.factor(pctile)
      ), size = 1.2) +
      labs(
        title = "Annual Household Income For Men And Women 2001-2014",
        x = "Year",
        y = "Household income",
        color = "Gender percentile" 
      )

    # Filter and plot data for men (M)
    men_df <- health_df %>% filter(gnd == "M")
    lineplot <- lineplot +
      geom_line(data = men_df, mapping = aes(
        x = year, 
        y = hh_inc, 
        color = "Men",
        linetype = as.factor(pctile)
      ), size = 1.2)

    # Set custom color and linetype scales
    lineplot <- lineplot +
      scale_color_manual(values = c("Women" = "pink", "Men" = "blue")) +
      scale_linetype_manual(values = c("1", "2", "3", "4"))  # Adjust linetypes as needed

    lineplot
})
#VIS 2 CODE 
 output$lineplot2 <- renderPlotly({
    health_df <- health_df %>% filter(pctile %in% input$dog_user)
    # health_df <- health_df %>% filter(year >= input$scale[1])
    # health_df <- health_df %>% filter(year <= input$scale[2])

    # Filter and plot data for women (F)
    women_df <- health_df %>% filter(gnd == "F")
    lineplot <- ggplot(data = women_df) +
      geom_line(mapping = aes(
        x = year, 
        y = le_agg, 
        color = "Women",
        linetype = as.factor(pctile)
      ), size = 1.2) +
      labs(
        title = "Life Expectancy For Men And Women 2001-2014",
        x = "Year",
        y = "Life Expectancy",
        color = "Gender percentile" 
      )

    # Filter and plot data for men (M)
    men_df <- health_df %>% filter(gnd == "M")
    lineplot <- lineplot +
      geom_line(data = men_df, mapping = aes(
        x = year, 
        y = le_agg, 
        color = "Men",
        linetype = as.factor(pctile)
      ), size = 1.2)

    # Set custom color and linetype scales
    lineplot <- lineplot +
      scale_color_manual(values = c("Women" = "pink", "Men" = "blue")) +
      scale_linetype_manual(values = c("1", "2", "3", "4"))  # Adjust linetypes as needed

    lineplot
})
#VIS 3 CODE
output$map <- renderPlotly({
    map <- ggplot(merged_data) +
      geom_polygon(mapping = aes(x = long, 
                                y = lat, 
                                group = group,
                                fill = !!as.name(input$gender),
                                text = paste("Country: ", region, "<br>"))) + 
      scale_fill_gradient(name = if (input$gender == "le_F") "Female Life Expectancy" 
                                else "Male Life Expectancy", 
                          low = "lightblue", 
                          high = "darkblue", 
                          na.value = "gray") +
      coord_map() +
      labs(title = if (input$gender == "le_F") "World Female Life Expectancy Map" 
                  else "World Male Life Expectancy Map",
           x = "Longitude",
           y = "Latitude")
    ggplotly(map, tooltip=c("text")) %>%
      layout(showlegend = TRUE)
    return(ggplotly(map))
  })

}
shinyServer(server)