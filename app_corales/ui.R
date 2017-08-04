# ui.R
library(plotly)
#library(dplyr)
#library(stringr)
library(DT)
#library(data.table)
#library(tidyr)
library(ggplot2)

#shinyUI(fluidPage(
shinyUI(fluidPage(theme = "bootstrap.css",
  titlePanel("Resultados de clubes de ciencias Ensenada: De nadar a programar"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Este app muestra los resultados de los distintos análisis de CdeCMX 2017 Ensenada"),

  
      selectInput("dataset", 
                  label = "Escoger tipo de gráficos",
                  choices = c("grafico_1","grafico_2","grafico_3","grafico_4","grafico_5")),
      
      #Agregar colores a los gráficos
      bootstrapPage(
        actionButton("button1", "Escoge un gráfico", class="btn-primary")
      )
     ,width = 3 
      ),
    
    mainPanel(
      #h2("Resultados de las puntuaciones de los estudiantes"),
      
      h2(textOutput("text1")),
      
      plotOutput("graficoResultado")
      
      #shinyUI(navbarPage(
      #  title = 'Todos los apps hechos por el club',
      #  tabPanel('Apps',     DT::dataTableOutput('ex1'))
      #))
      
    )
  )
))