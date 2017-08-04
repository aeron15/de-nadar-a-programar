# server.R
# Esta es la parte donde va el código de las gráficas

datos_df<-read_tsv("../datos/datos_arrecifes_especies.tsv")

shinyServer(

  #Source code and functions for the app
    
  function(input, output) {
   
    #Seleccionar tipo de gráfico 
    tipoGrafico <- eventReactive(input$button1,{
      input$dataset
    })
    
    #Leer el archivo
    datos <- eventReactive(input$button1,{
      #datos<-read.table("datos_STACK.csv",header= TRUE, sep = ",")
      datos_df<-read_tsv("../datos/datos_arrecifes_especies.tsv")
      
    })
    
    output$graficoResultado <- renderPlot({
      
      tipo <-tipoGrafico()
      
      if(tipo=="grafico_1"){
        
        datos_m_r <- filter(datos_df , especie =='Mycteroperca_rosacea')
        p <- ggplot(datos_m_r,aes(x=localidad, y= total)) + geom_boxplot()+coord_flip()
        print(p)
      }
      
      
      if(tipo=="grafico_2"){
        
        p <- ggplot(datos_df) + geom_line(aes(x=latitud, y=especie, color=especie))
        print(p)
      }
      
      if(tipo=="grafico_3"){
       
        p <-  datos_df %>% ggplot(aes(x = especie, y = total)) + geom_bar(stat = "identity") + theme(axis.title.x = element_text(angle = 67.5, hjust = 1)) + facet_wrap(~localidad) + theme(axis.title.x = element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
        print(p)
      }
      
      if(tipo=="grafico_4"){
        
        p <- ggplot(datos_df, aes(x=densidad, y=total, color=especie, size=densidad)) + geom_point() + facet_grid(region~especie) + ggtitle('Densidad total de especies por region')
        
        print(p) 
      }
      
      if(tipo=="grafico_5"){
        
        p <- ggplot(datos_df, aes(x=month, y=densidad))+geom_bar(stat="identity", fill='coral1')+facet_wrap(~especie)+ theme(axis.text.x = element_text(angle = 90, hjust = 1))+theme_bw()+ggtitle("Densidad por mes de cada especie")
        print(p)
      }
      
      
    }, height = 600, width = 800)  
    
    #output$trendPlot <- renderPlotly({
    #  #Plot results in an interactive bar chart
    #  results<-results1()
    #  test.TF<-results$enrichment
    #  plot_bar_chart(test.TF) 
    #      
    #})
   
    # Agregar texto
    
    output$text1 <- renderText({ 
      paste("Seleccionaste  datos de ", tipoGrafico())
    })
    
    output$ex1 <- DT::renderDataTable(
      data.frame(nombre="coso",link="test")
    )
    
  }
)