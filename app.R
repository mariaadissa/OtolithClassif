library(shiny)
library(shinythemes)
library(shinyFiles)
library(DT)
library(plotly)


#options(shiny.maxRequestSize = 30*1024^2)

#functions
source(file.path("functions", "img_plot.R"))
source(file.path("functions", "splitting.R"))
#global
source(file.path("global.R"))

  ui <- list( ui = tagList(
    
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
    div(
      id = "mainPage",
      navbarPage(
        theme = shinytheme("cerulean"),
        title='OtolithClassif',
        id="OtolithClassif",
        source(file.path("ui", "ui.imageViz.R"), local = TRUE)$value
      )
    ))
  
  server <- function(input, output, session){
    source(file.path("server", "server.imageViz.R"), local = TRUE)$value
  }
  
  # Build the application
  shinyApp(ui = ui, server = server)

