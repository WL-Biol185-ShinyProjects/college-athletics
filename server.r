library(shiny)
library(ggplot2)
library(tidyverse)

multiyr_ncaa <- read.csv ("multiyr_ncaa.csv")

function(input, output){
  
  output$aprDensity <- renderPlot({
    multiyr_ncaa %>%
      filter(scl_name %in% input$aprIncludeSchools) %>%
      ggplot (aes_string("multiyr_apr_rate_1000_official", fill = input$aprGroupBy)) + 
      geom_density(alpha=0.2)
    
  })
  
  output$plotFilter <- renderUI({
    if(input$aprGroupBy == "sport_name") {
      selectInput("sport_name", "Sport:", choices = unique(multiyr_ncaa$sport_name))
    } else if(input$aprGroupBy == "confname_18") {
      selectInput("conf_name", "Conference:", choices = unique(multiyr_ncaa$confname_18))
    } else {
      selectInput("scl_name", "School:", choices = unique(multiyr_ncaa$scl_name))
    }
  })
  
}

