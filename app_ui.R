# ui
library(dplyr)
library(plotly)
library(ggplot2)
library(shiny)

source("app_server.R")

# intro page


intro_main_content <- mainPanel(
  h4("Arona Cho"),
  h4("12-9-2022"),
  p("As we continue to inhabit Earth, we release byproducts such as carbon dioxide into the atmosphere due to our various inhabiting-activities. Using data collected by the Our World in Data organization, we can analyze how much carbon dioxide has been released. I chose to look into the net annual carbon emissions embedded in trade, as trade is essential in maintaining our globalized societies. After looking at the map visualization of the net annual carbon emissions from trade by Our World in Data, I realized a large number of African countries were missing from the map due to the lack of data compared to other continents. Therefore, I decided to create a visualization for Algeria, which was an African country with enough substantial data to produce a visualization, to provide more information about the net carbon emissions from that region."),
  p(""),
  p(paste("The numbers from the net annual carbon emissions embedded in trade it can determine if Algeria is a net importer or exporter of carbon emissions. After adding up all of the net annual emissions from 1990 to 2020, Algeria’s net emissions total to", net_status, "million tonnes (MT), meaning that Algeria is identified as a net importer of carbon emissions from trade, as indicated by the positive number. Furthermore, we can identify that the year", max_net_year, "had the greatest net emissions of", max_net, "MT and the year", min_net_year, "had the lowest net emissions of", min_net, "MT showing an overall positive growth of carbon emissions over the years."))
    
  )

intro_tab_panel <- tabPanel("Introduction", 
                            titlePanel("Algeria's Net Carbon Emissions from Trade"),
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




