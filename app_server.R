#  server
library(dplyr)
library(plotly)
library(ggplot2)
library(shiny)

# loading data...
df <- read.csv("owid-co2-data.csv")

#  Datawrangling...
trade_years <- df %>% 
  filter(country == "Albania") %>% 
  group_by(year) %>% 
  summarize(year, trade_co2, trade_co2_share)
trade_years <- trade_years [141:171, ]

# Relevant values:
  # Determine if Albania is net exporter/importer of CO2 emissions
  net_status <- trade_years %>% 
    summarise(net_status = (sum(trade_years$trade_co2)))
  # Million tonnes (MT) of highest imports
  max_net <- trade_years %>% 
    select(year, trade_co2) %>% 
    filter(trade_co2 == max(trade_co2)) %>% 
    pull(trade_co2)
  # Year of highest imports
  max_net_year <- trade_years %>% 
    select(year, trade_co2) %>% 
    filter(trade_co2 == max(trade_co2)) %>% 
    pull(year)
  # MT of lowest imports
  min_net <- trade_years %>% 
    select(year, trade_co2) %>% 
    filter(trade_co2 == min(trade_co2)) %>% 
    pull(trade_co2)
  # Year of lowest imports
  min_net_year <- trade_years %>% 
    select(year, trade_co2) %>% 
    filter(trade_co2 == min(trade_co2)) %>% 
    pull(year)

#  shiny server

server <- function(input, output) {
  output$scatter <- renderPlotly({
    co2_plot <- ggplot(trade_years, mapping = aes_string(x = trade_years$year, y = input$co2_cols)) +
      geom_point(
                 color = "#00BFC4") +
          labs(x = "Year", y = "Annual Net Carbon Emissions")
    if(input$trendline_box) {
      co2_plot <- co2_plot +
        geom_smooth()
    }
    return(co2_plot)
  })
}

