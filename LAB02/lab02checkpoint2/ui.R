#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(tidyverse)

series_from_imdb <- read_csv("https://raw.githubusercontent.com/nazareno/imdb-series/master/data/series_from_imdb.csv")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("Desempenho de uma série de acordo com dados do IMDB"),
  
  sidebarLayout(
    
    
    sidebarPanel(
      selectInput("select_series_name", "Nome da série:", 
                  choices=unique(series_from_imdb$series_name)),
      helpText("O banco de dados conta com, aproximadamente, 512 séries.")
    ), 
    
    mainPanel(
      br(),
      p("Na análise de hoje, eu vou mostrar para vocês o desempenho de várias séries cujas notas foram coletadas a partir
        do Internet Movie Database (IMDB), que é o site mais popular no quesito avaliação de séries."),
      p("Para ver o desempenho da sua série favorita, basta procurá-la na lista ao lado e os gráficos serão gerados.
        Temos dois tipos de gráficos, um de linha e um de caixa. O gráfico de linha é mais intuitivo e se refere às notas
        em relação a cada episódio. As avaliações por temporadas são divididas por cores também, para facilitar a leitura. O gráfico de caixa, por outro lado, nos mostra informações mais interessantes, como por exemplo,
        a nota geral da série (baseada na mediana), além da maior e menor nota que um episódio já recebeu na série."),
      p("Aproveitem e visitem todas as suas séries favoritas, tem o bastante para se divertir por um bom tempo."),
      br(),
      br(),
      h4("Avaliação da série ao longo do tempo"),
      plotlyOutput("line_graph"),
      hr(),
      hr(),
      h4("Avaliação geral da série"),
      plotlyOutput("dd")
    )

  )))
