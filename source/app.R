#  app
library(dplyr)
library(plotly)
library(ggplot2)
library(shiny)

source("app_server.R")
source("app_ui.R")

shinyApp(ui = ui, server = server)

