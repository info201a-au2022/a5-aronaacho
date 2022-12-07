# ui
library(dplyr)
library(shiny)
library(plotly)

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
  # MT of lowest imports
  min_net <- trade_years %>% 
  select(year, trade_co2) %>% 
  filter(trade_co2 == min(trade_co2)) %>% 
  pull(trade_co2)

# intro page


intro_main_content <- mainPanel(
  p(paste("this is a test for para", net_status, "more"))
  )

intro_tab_panel <- tabPanel("Introduction", 
                            titlePanel("Introduction: Annual Net Carbon Emissions"),
                            intro_main_content)

# interactive visualization page

viz_main_content <- mainPanel(
  plotlyOutput("scatter")
)

viz_sidebar_content <- sidebarPanel(
  selectInput("co2_cols",
              "Annual net carbon dioxide (CO₂) emissions embedded in trade",
              choices = list("Measured in Million Tonnes" = "trade_co2",
                           "Measured as a percentage of production-based emissions" = "trade_co2_share")),
  checkboxInput("trendline_box",
                "Show Trendline",
                value = TRUE),
  "This scatter plot presents the amount of carbon dioxide emissions from trade over the years in Algeria. This graph can present both the percentage of emissions from trade production and the overall million tonnes of carbon dioxide produced by this select feature.")

viz_tab_panel <- tabPanel("CO₂ Visualization",
                          titlePanel("Carbon Dioxide Emissions in Algeria"),
                          sidebarLayout(
                            viz_sidebar_content,
                            viz_main_content)
                          )

ui <- navbarPage("CO2 Emissions",
                 intro_tab_panel,
                 viz_tab_panel
                 )




