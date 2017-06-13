#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(plotly)
library(rsconnect)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  series_from_imdb <- read_csv("https://raw.githubusercontent.com/nazareno/imdb-series/master/data/series_from_imdb.csv")
  all_series_name <- unique(series_from_imdb$series_name)
  
  output$line_graph <- renderPlotly({
    
    # Plotagem final dos dados usando plotly
    f <- list(
      size = 10,
      color = "#7f7f7f"
    )
    
    plot_ly(data=series_from_imdb %>% filter(series_name %in% input$select_series_name), name="Notas gerais dos episódios", x=~series_ep, y=~UserRating) %>%
      layout(xaxis = list(title = "Número do episódio", tickfont=f), yaxis = list(title = "Nota dos episódios")) %>% 
      add_lines(hoverinfo = 'text', text=~paste('Episódio: ', season_ep, '<br>Temporada: ', season, '<br> Nome do episódio: ', Episode, '<br> Nota: ', UserRating), color=~as.character(season), showlegends=FALSE)
  })
  
  output$dd <- renderPlotly({
    
    # Plotagem final dos dados usando plotly
    f <- list(
      size = 10,
      color = "#7f7f7f"
    )
    
    plot_ly(data=series_from_imdb %>% filter(series_name %in% input$select_series_name), name="Notas gerais dos episódios", x=~series_name, y=~UserRating, type="box", hoverinfo='text') %>%
      layout(xaxis = list(title = "", tickfont=f), yaxis = list(title = "Nota dos episódios")) %>%
      add_markers(x=~series_name, y=~median(UserRating), hoverinfo='text', text=~paste('Nota da série: ', median(UserRating)), showlegends=FALSE) %>%
      add_markers(x=~series_name, y=~max(UserRating), hoverinfo='text', text=~paste('Nota máxima de um episódio: ', max(UserRating)), showlegends=FALSE) %>%
      add_markers(x=~series_name, y=~min(UserRating), hoverinfo='text', text=~paste('Nota mínima de um episódio: ', min(UserRating)), showlegends=FALSE)
    
  })
  
})
