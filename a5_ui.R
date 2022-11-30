# ui
library(shiny)
library(plotly)

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
                           "Measured as a percentage of production-based emissions" = "trade_co2_share"))
)

viz_tab_panel <- tabPanel("CO₂ Visualization",
                          titlePanel("Carbon Dioxide Emissions in Algeria"),
                          sidebarLayout(
                            viz_sidebar_content,
                            viz_main_content
                          )
)

ui <- navbarPage("CO2 Emissions",
                 intro_tab_panel,
                 viz_tab_panel
                 )




