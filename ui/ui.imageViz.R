
# tabPanel(title = "Visualisation",
#          sidebarLayout(
#            sidebarPanel(
#              shinyFilesButton("img_btn", "Choose an image" ,
#                               title = "Please select an image:", multiple = FALSE),
#              verbatimTextOutput("img_text"),
#              uiOutput("select.param")
#            ),
#          mainPanel(imageOutput("img_viz"),
#                    dataTableOutput("data.table"),
#                    verbatimTextOutput(("param.summary")),
#                    plotlyOutput("boxplot")
#                    ))
#          )


tabPanel(title = "Visualisation",
         fluidRow(
           column(width = 12,
                  sidebarLayout(
                    sidebarPanel(
                      shinyFilesButton("img_btn", "Choose an image" ,
                                       title = "Please select an image:", multiple = FALSE),
                      verbatimTextOutput("img_text"),
                      uiOutput("select.param")
                    ),
                    mainPanel(
                      wellPanel(
                        tabsetPanel(
                          
                          tabPanel(title = "Paramètres de l'image",
                                   
                                                   fluidRow(
                                                     column(width = 4,imageOutput("img_viz"))
                                                    
                                                     
                                                   ),
                                                  fluidRow(
                                                    column(width = 4, dataTableOutput("data.table"))
                                                  )
                          )
                        )
                      )
                    )
                  )
           )
         ),
         fluidRow(
           column(verbatimTextOutput(("param.summary")),width = 4),
           column(plotlyOutput("boxplot"),width=8)
         )
         
         
)
