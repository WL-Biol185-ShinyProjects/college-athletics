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
    if(input$aprGroup == 'sport_name') {
      selectInput('sport_name', "Sport:", choices = unique(multiyr_ncaa$sport_name))
      #print("I should be in Sport")
    } else if(input$aprGroup == 'confname_18') {
      selectInput('confname_18', "Conference:", choices = unique(multiyr_ncaa$confname_18))
      #print("I should be in conference")
    } else {
      selectInput('scl_name', "School:", choices = unique(multiyr_ncaa$scl_name))
      #print("I should be in school")
    }
  })
  
  output$aprBoxPlot <- renderPlot({
    multiyr_ncaa %>%
      #filter(aprGroupBy %in% input$aprInclude) %>%
      ggplot(aes_string(x=input$aprGroup, y="multiyr_apr_rate_1000_official")) +
      geom_boxplot()
  })
  
}

