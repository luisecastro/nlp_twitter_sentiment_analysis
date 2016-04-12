source("global.R")
shinyServer(function(input, output, session){
    
    output$textual <- renderPrint({input$text})
    
    selectedData <- reactive({
        input$go
        isolate(final(input$text,input$tweets,as.character(input$dateRange[1]),
                      as.character(input$dateRange[2])))
    })
    
    
    output$plot <- renderPlot({
        plot(selectedData()[,21],type="l",col="dark green",xlab="# of Tweets",
             ylab="Difference between total positive & negative")
    })
    
        
    output$table <- renderDataTable({
        sources(selectedData()[,10])
    })
    

    })



    
