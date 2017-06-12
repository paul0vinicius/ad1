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

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  series_from_imdb <- read_csv("https://raw.githubusercontent.com/nazareno/imdb-series/master/data/series_from_imdb.csv")
  all_series_name <- unique(series_from_imdb$series_name)
  selected_series_name <- c("Modern Family","The 100","Black Mirror","Sense8")
  
  dataSeries <- series_from_imdb %>% filter(series_name %in% selected_series_name)
  
  #selected_series_name <- c(selected_series_name, "The Simpsons")
  
  observeEvent(input$select_series_button, {
    selected_series_name <- c(selected_series_name, input$select_series)
    })
  
  output$event <- renderPrint({
    d <- selected_series_name
    if (is.null(d)) "Hover on a point!" else d
  })
  
  output$distPlot <- renderPlotly({
    
    # Plotagem final dos dados usando plotly
    f <- list(
      size = 10,
      color = "#7f7f7f"
    )
    
    plot_ly(data=dataSeries, name="Notas gerais dos episódios", x=~series_name, y=~UserRating) %>%
      layout(xaxis = list(title = "Nome da série", tickfont=f), yaxis = list(title = "Nota dos episódios"))
    
  })
  
})
