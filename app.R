#  app
library(shiny)
library(plotly)
library(dplyr)

source("ui.R")
source("server.R")

shinyApp(ui, server)

