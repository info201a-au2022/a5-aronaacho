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
  p("As we continue to inhabit Earth, we release byproducts such as carbon dioxide into the atmosphere due to our various inhabiting-activities. Using data collected by the Our World in Data organization, we can analyze how much carbon dioxide has been released. I chose to look into the net annual carbon emissions embedded in trade, as trade is essential in maintaining our globalized societies. After looking at the map visualization of the net annual carbon emissions from trade by Our World in Data, I realized a large number of African countries were missing from the map due to the lack of data compared to other continents. Therefore, I decided to create a visualization for Algeria, which was an African country with enough substantial data to produce a visualization, to provide more information about the net carbon emissions from that region. From the data, I used both annual net carbon dioxide from trade of production-based emissions measured by million tonnes and percentage rates to showcase both the unique number and how much share trade emissions took from the overall carbon emissions."),
  p(""),
  p(paste("The numbers from the net annual carbon emissions embedded in trade it can determine if Algeria is a net importer or exporter of carbon emissions. After adding up all of the net annual emissions from 1990 to 2020, Algeria’s net emissions total to"), (strong(net_status, "million tonnes (MT)")), ("meaning that Algeria is identified as a net importer of carbon emissions from trade, as indicated by the positive number. Furthermore, we can identify that the year"),(strong(max_net_year)), ("had the greatest net emissions of"), ((strong(max_net, "MT"))), ("and the year"), (strong(min_net_year)), ("had the lowest net emissions of"), ((strong(min_net, "MT"))), ("showing an overall positive growth of carbon emissions over the years. While Algeria may not be as socioeconomically impactful compared to those that hold world power status, it is the biggest country in the African continent. Their impact should still be considered as they are also implicit in producing carbon emissions from trade, which contribute to climate change. As a net importer, countries like Algeria should still be wary of their carbon emissions, as climate change not only affects the weather, but also can disrupt the current routes and modes of importing and exporting trade, which can increase the country’s importing costs, potential causing less imports and resources for the country’s people. Trade ultimately is a direct culprit to our changing climate, therefore as citizens of Earth we need to be responsible for the emissions we put into the atmosphere.")
  ))

intro_tab_panel <- tabPanel("Introduction", 
                            titlePanel("Algeria's Net Carbon Emissions from Trade"),
                            intro_main_content)

# interactive visualization page

viz_main_content <- mainPanel(
  plotlyOutput("scatter"),
  p(""),
  p(em("This scatter plot presents both Algeria’s amount of carbon dioxide emissions from trade production in million tonnes and the percentage of emissions. This data was visualized as a scatter plot for an easier understanding of how these emissions have changed over time. It is notable that there was a rapid increase in carbon emissions until the end of the 2000s, leading to a decline in emissions until the mid-2010s. Towards the end of the 2010s, there has been a slight increase in emissions, but not to the extent of the increase that happened in the 1990s. While both the trade emissions in million tonnes and as a percentage of production-based emissions follow similar trends, the percentage trendline is comparatively softer than the one shown in million tonnes, perhaps due to an increase in production-based emissions from sources other than trade emerging in the 21st century."))
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
                 tags$head(
                   tags$style(HTML("
      @import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap');
body {
  background-color: #FDFEFE;
  color: black;
}
/* Make text visible on inputs */
.shiny-input-container {
  color: #474747;
}
.navbar { 
  background-color: #D6EAF8 ;
  font-size: 15px;
  font-color: #474747;
}
"))), 
                 intro_tab_panel,
                 viz_tab_panel
                 )




