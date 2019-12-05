library(shiny)
library(ggplot2)
library(tidyverse)

state_multiyr_ncaa <- read.csv ("state_multiyr_ncaa.csv")

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
    } else if(input$aprGroup == 'confname_18') {
      selectInput('confname_18', "Conference:", choices = unique(multiyr_ncaa$confname_18))
    } else {
      selectInput('scl_name', "School:", choices = unique(multiyr_ncaa$scl_name))
    }
  })
  
  output$aprBoxPlot <- renderPlot({
    multiyr_ncaa %>%
      filter( 
        input$aprGroup %in%
        if(input$aprGroup == 'sport_name') {
          unique(multiyr_ncaa$sport_name)
        } else if(input$aprGroup == 'confname_18') {
          unique(multiyr_ncaa$confname_18)
        } else {
          unque(multiyr_ncaa$scl_name)
        } 

      ) %>%
      ggplot(aes_string(x=input$aprGroup, y="multiyr_apr_rate_1000_official")) +
      geom_boxplot()
  })
  
}

