# server.R

#library(dplyr)
#library(stringr)
#library(DT)
#library(GeneOverlap)
#library(data.table)
#library(plotly)
#library(tidyr)

shinyServer(

  #Source code and functions for the app
    
  function(input, output) {
    datasetInput <- eventReactive(input$button1,{
      switch(input$dataset,
             "barras" = "barras",
             "dispersion" = "dispersion"
             #"iPSCs" = "data/pos_list_genes_iPSCs_iMNsTF_anno.txt"
             )
    })
  
    output$distPlot <- renderPlot({
      
      filename <-datasetInput()
      if(filename=="barras"){
        # generate an rnorm distribution and plot it
        dist <- rnorm(30)
        hist(dist)  
      }else{
        dist2 <- rnorm(30)
        dist1 <- rnorm(30)
        plot(dist1,dist2)
      }
      
    })  
    
    #output$trendPlot <- renderPlotly({
    #  #Plot results in an interactive bar chart
    #  results<-results1()
    #  test.TF<-results$enrichment
    #  plot_bar_chart(test.TF) 
    #      
    #})
    
  }
)