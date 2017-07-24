# ui.R
library(plotly)
library(shinyjs)
library(V8)
library(dplyr)
library(stringr)
library(DT)
library(GeneOverlap)
library(data.table)
library(plotly)
library(tidyr)

#shinyUI(fluidPage(
shinyUI(fluidPage(theme = "bootstrap.css",
  titlePanel("Test of different plots for data"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Este es un app de distintos tipos de datos"),

  
      #h4('Select the tissue to compare your data'),
      selectInput("dataset", 
                  label = "Escoger set de datos",
                  choices = c("barras","dispersion")),
      
      #Added nice colors to submission buttons
      bootstrapPage(
        actionButton("button1", "Submit gene list", class="btn-primary")
      )
      
      ),
    
    mainPanel(
      h2("Resultados del análisis"),
      
      #h3("Top enriched transcription factors (by p-values)"),
      #h3(textOutput("text1")),
      #textOutput("text1"),
      #plotlyOutput("trendPlot"),
      plotOutput("distPlot")
      
    )
  )
))