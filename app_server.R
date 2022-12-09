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
          labs(x = "Year", y = "Annual Net Carbon Emissions", caption = "This scatter plot present both of Algeria’s amount of carbon dioxide emissions from trade production in million tonnes and percentage of emissions. This data was visualised as a scatter plot for easier understanding of how these emissions have changed over time. It is notable that there was a rapid increase in carbon emissions until the end of the 2000s, leading to a decline in emissions until the mid 2010s. Towards the end of the 2010s, there has been a slight increase in emissions, but not to the extent of the increase that happened in the 1990s. While both the trade emissions in million tonnes and as a percentage of production-based emissions follow similar trends, the percentage trendline is comparatively softer then the one shown in million tonnes, perhaps due to an increase in production-based emissions from sources other than trade emerging in the 21st century.")
    if(input$trendline_box) {
      co2_plot <- co2_plot +
        geom_smooth()
    }
    return(co2_plot)
  })
}

