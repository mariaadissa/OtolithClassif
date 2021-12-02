
tabPanel(title = "Visualisation",
         tabsetPanel(
           tabPanel(title = "Image visualisation",
                    sidebarLayout(
                      sidebarPanel(
                        shinyFilesButton("img_btn", "Choose an image" ,
                                         title = "Please select an image:", multiple = FALSE),
                        verbatimTextOutput("img_text"),
                        tags$br(),
                        fileInput("infile", "Choose a csv file", multiple = FALSE, accept = c("text/csv","text/comma-separated-values,text/plain",".csv"))
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
                        fluidRow(plotlyOutput("boxplot")),
                        fluidRow(tags$h3("Correction")),
                        fluidRow(
                          column(width = 2, numericInput("age",label = "Age",min = 1,value = 1)),
                          column(width = 2, numericInput("val",label = "Value",min = 0,value = 1))
                                ),
                        fluidRow(column(width = 3, actionButton("correctBtn",label = "Remove")))
                      )
                    ))
         )
         
         )

