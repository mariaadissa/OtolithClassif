
    # getting user's home directory
    volumes = c(Home = fs::path_home(), "R Installation" = R.home())
    
    # img input
    observe({  
        shinyFileChoose(input, "img_btn", roots = volumes, session = session, filetypes = 'JPG')
        
        if(!is.null(input$img_btn)){
            file_selected<-parseFilePaths(volumes, input$img_btn)
            #text plot
            output$img_text <- renderText(as.character(file_selected$datapath))
            if(!identical(file_selected$datapath, character(0))){
                #image plot
                output$img_viz <- renderImage({
                    outfile <- tempfile(fileext = '.jpg')
                    png(outfile, width = 400, height = 400)
                    plot_jpeg(file_selected$datapath)
                    dev.off()
                    # Return a list containing the filename
                    list(src = outfile, contentType = 'image/png',width = 400,height = 300,alt = "This is alternate text")
                }, deleteFile = TRUE)
                # table plot
                output$data.table <- renderTable({
                    row_from_path(file_selected$datapath,rv$csv.data)
                })
            }
        }
    })
    
    # csv input
    observe({
        req(input$infile)
        tryCatch(
            {
                csv.data <- read.csv(input$infile$datapath,
                              header = TRUE,
                              sep = ",",
                              stringsAsFactors = TRUE,
                              row.names = NULL)
                
            },
            error = function(e) {
                # return a safeError if a parsing error occurs
                stop(safeError(e))
            }
        )
        # Reactive values updated from x
        rv$csv.data <- csv.data
    })
    
    # input 
    output$select.param <- renderUI({
        if (is.null(df)) return(NULL)
        df <- rv$csv.data[,-c(1:4)]
        selectInput("select.param", "Select a parameter",names(df))
    })
    # param summary 
    output$param.summary <- renderPrint({
        if(is.null(rv$csv.data)) return(NULL)
        summary(rv$csv.data[,input$select.param])
    })
    
    #param boxplot
    output$boxplot <- renderPlotly({
        fig <- plot_ly(data = rv$csv.data, y = rv$csv.data[,input$select.param], color = ~as.factor(age), type = "box")
        fig <- fig %>% layout(yaxis = list(title = input$select.param), xaxis = list(title = "age"))
        fig
    })
    
    #Correction
    observeEvent(input$correctBtn,{
        param <- input$select.param
        val <- input$val
        age <- input$age
        row_number <- which(rv$csv.data[,param]==val & rv$csv.data[,"age"]==age) 
        rv$csv.data[row_number,param]  <- NA
    })
    
    
    
    
    
