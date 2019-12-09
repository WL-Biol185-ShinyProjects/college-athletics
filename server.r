library(shiny)
library(ggplot2)
library(tidyverse)

multiyr_ncaa <- read.csv("multiyr_ncaa.csv")

function(input, output){
  output$aprDensity <- renderPlot({
    multiyr_ncaa %>%
      filter(scl_name %in% input$aprIncludeSchools) %>%
      ggplot (aes_string("multiyr_apr_rate_1000_official", fill = input$aprGroupBy)) + 
      geom_density(alpha=0.2) +
      xlab("Academic Performance Rate") +
      labs(fill = "Name:") +
      theme_gray()
    
  })
  
  output$plotFilter <- renderUI({
    if(input$aprGroup == 'sport_name') {
      selectInput('sport_name', "Sport:", choices = unique(multiyr_ncaa$sport_name), selected=unique(multiyr_ncaa$sport_name[1]))
    } else if(input$aprGroup == 'confname_18') {
      selectInput('confname_18', "Conference:", choices = unique(multiyr_ncaa$confname_18), selected=unique(multiyr_ncaa$confname_18[1]))
    } else {
      selectInput('scl_name', "School:", choices = unique(multiyr_ncaa$scl_name), selected=unique(multiyr_ncaa$scl_name[1]))
    }
  })
  
  output$aprBoxPlot <- renderPlot({
    
    if(input$aprGroup == 'sport_name') {
      multiyr_ncaa %>%
        filter('sport_name' %in% input$sport_name) %>%
        ggplot(aes_string(x='sport_name', y="multiyr_apr_rate_1000_official")) +
        geom_boxplot(color="black", fill="light blue", alpha=0.2) +
        xlab("Sport") +
        ylab("Academic Performance Rate") +
        theme_gray()
    }else if(input$aprGroup == 'confname_18') {
      multiyr_ncaa %>%
        filter('confname_18' %in% input$confname_18) %>%
        ggplot(aes_string(x='confname_18', y="multiyr_apr_rate_1000_official")) +
        geom_boxplot(color="black", fill="light blue", alpha=0.2) +
        xlab("Conference") +
        ylab("Academic Performance Rate") +
        theme_gray() 
    }else {
      multiyr_ncaa %>%
        filter('scl_name' %in% input$scl_name) %>%
        ggplot(aes_string(x='scl_name', y="multiyr_apr_rate_1000_official")) +
        geom_boxplot(color="black", fill="light blue", alpha=0.2) +
        xlab("School") +
        ylab("Academic Performance Rate") +
        theme_gray() 
    }
  }
  
  )
  
}


