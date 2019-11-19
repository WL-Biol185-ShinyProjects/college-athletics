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
  
}

