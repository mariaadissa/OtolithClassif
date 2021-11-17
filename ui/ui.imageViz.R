
tabPanel(title = "Visualisation",
         tabsetPanel(
           tabPanel(title = "Image visualisation",
                    sidebarLayout(
                      sidebarPanel(
                        shinyFilesButton("img_btn", "Choose an image" ,
                                         title = "Please select an image:", multiple = FALSE),
                        verbatimTextOutput("img_text")
                      ),
                      mainPanel(
                        fluidRow(tableOutput("data.table")),
                        imageOutput("img_viz")
                        
                        )
                    )),
           tabPanel(title = "Parameters visualisation",
                    sidebarLayout(
                      sidebarPanel(
                        uiOutput("select.param")
                      ),
                      mainPanel(
                        fluidRow(column(width = 6, verbatimTextOutput("param.summary"))),
                        fluidRow(plotlyOutput("boxplot"))
                      )
                    ))
         )
         
         )

