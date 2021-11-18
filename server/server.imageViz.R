
    # getting user's home directory
    volumes = c(Home = fs::path_home(), "R Installation" = R.home())
    
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
                    row_from_path(file_selected$datapath,csv.data)
                })
            }
        }
    })
    
    # input 
    output$select.param <- renderUI({
        if (is.null(csv.data)) return(NULL)
        df <- csv.data[,-c(1:4)]
        selectInput("select.param", "Select a parameter",names(df))
    })
    # param summary 
    output$param.summary <- renderPrint({
        if(is.null(csv.data)) return(NULL)
        summary(csv.data[,input$select.param])
    })
    
    #param boxplot
    output$boxplot <- renderPlotly({
        fig <- plot_ly(data = csv.data, y = csv.data[,input$select.param], color = ~as.factor(age), type = "box")
        fig <- fig %>% layout(yaxis = list(title = input$select.param), xaxis = list(title = "age"))
        fig
    })
    
