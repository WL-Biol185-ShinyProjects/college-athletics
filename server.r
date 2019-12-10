library(shiny)
library(ggplot2)
library(tidyverse)
library(rgdal)
library(leaflet)
library(shinydashboard)
library(png)
library(htmltools)

multiyr_ncaa <- read.csv("multiyr_ncaa.csv")
leafletdf <- read_csv("leafletdf.csv")
state_names<- read_csv("states.csv")
statesGEO  <- rgdal::readOGR("states.geo.json")

function(input, output){
  
  output$plotFilterDens <- renderUI({
    if(input$aprGroupBy == 'sport_name') {
      selectInput('sport_name', "Sport:", choices = unique(multiyr_ncaa$sport_name), multiple = TRUE, selected=unique(multiyr_ncaa$sport_name[1]))
    } else if(input$aprGroupBy == 'confname_18') {
      selectInput('confname_18', "Conference:", choices = unique(multiyr_ncaa$confname_18), multiple = TRUE, selected=unique(multiyr_ncaa$confname_18[1]))
    } else if(input$aprGroupBy == 'scl_name'){
      selectInput('scl_name', "School:", choices = unique(multiyr_ncaa$scl_name), multiple = TRUE, selected=unique(multiyr_ncaa$scl_name[1]))
    } 
  })
  
  output$aprDensity <- renderPlot({
    
    if(input$aprGroupBy == 'sport_name') {
      multiyr_ncaa %>%
        filter(sport_name %in% input$sport_name) %>%
        ggplot(aes(x=multiyr_apr_rate_1000_official, fill=sport_name)) +
        geom_density(alpha=0.2) +
        xlab("Academic Performance Rate") +
        labs(fill='Sport:') +
        theme_gray()
    }else if(input$aprGroupBy == 'confname_18') {
      multiyr_ncaa %>%
        filter(confname_18 %in% input$confname_18) %>%
        ggplot(aes(x=multiyr_apr_rate_1000_official, fill=confname_18)) +
        geom_density(alpha=0.2) +
        xlab("Academic Performance Rate") +
        labs(fill='Conference:') +
        theme_gray() 
    }else if(input$aprGroupBy == 'scl_name'){
      multiyr_ncaa %>%
        filter(scl_name %in% input$scl_name) %>%
        ggplot(aes(x=multiyr_apr_rate_1000_official, fill=scl_name)) +
        geom_density(alpha=0.2) +
        xlab("Academic Performance Rate") +
        labs(fill='School:') +
        theme_gray() 
    }
  })
  
  # output$plotRetentionFilter <- renderUI({
  #   if(input$retGroupBy == 'sport_name') {
  #     selectInput('sport_name', "Sport:", choices = unique(multiyr_ncaa$sport_name), multiple = TRUE, selected=unique(multiyr_ncaa$sport_name[1]))
  #   } else if(input$retGroupBy == 'confname_18') {
  #     selectInput('confname_18', "Conference:", choices = unique(multiyr_ncaa$confname_18), multiple = TRUE, selected=unique(multiyr_ncaa$confname_18[1]))
  #   } else if(input$retGroupBy == 'scl_name'){
  #     selectInput('scl_name', "School:", choices = unique(multiyr_ncaa$scl_name), multiple = TRUE, selected=unique(multiyr_ncaa$scl_name[1]))
  #   }
  # })
  
  output$retDensity <- renderPlot({ 
    
    if(input$aprGroupBy == 'sport_name') {
      multiyr_ncaa %>%
        filter(sport_name %in% input$sport_name) %>%
        ggplot(aes(x=multiyr_ret_rate, fill=sport_name)) +
        geom_density(alpha=0.2) +
        xlab("Retention Rate") +
        labs(fill='Sport:') +
        theme_gray()
    }else if(input$aprGroupBy == 'confname_18') {
      multiyr_ncaa %>%
        filter(confname_18 %in% input$confname_18) %>%
        ggplot(aes(x=multiyr_ret_rate, fill=confname_18)) +
        geom_density(alpha=0.2) +
        xlab("Retention Rate") +
        labs(fill='Conference:') +
        theme_gray() 
    }else if(input$aprGroupBy == 'scl_name'){
      multiyr_ncaa %>%
        filter(scl_name %in% input$scl_name) %>%
        ggplot(aes(x=multiyr_ret_rate, fill=scl_name)) +
        geom_density(alpha=0.2) +
        xlab("Retention Rate") +
        labs(fill='School:') +
        theme_gray() 
    }
  })
  
  output$plotFilterBox <- renderUI({
    if(input$aprGroup == 'sport_name') {
      selectInput('sport_name', "Sport:", choices = unique(multiyr_ncaa$sport_name), multiple = TRUE, selected=unique(multiyr_ncaa$sport_name[1]))
    } else if(input$aprGroup == 'confname_18') {
      selectInput('confname_18', "Conference:", choices = unique(multiyr_ncaa$confname_18), multiple = TRUE, selected=unique(multiyr_ncaa$confname_18[1]))
    } else if(input$aprGroup == 'scl_name'){
      selectInput('scl_name', "School:", choices = unique(multiyr_ncaa$scl_name), multiple = TRUE, selected=unique(multiyr_ncaa$scl_name[1]))
    } else if(input$aprGroup == 'scl_hbcu'){
      selectInput('scl_hbcu', "HBCU:", choices = unique(multiyr_ncaa$scl_hbcu), multiple = TRUE, selected=unique(multiyr_ncaa$scl_hbcu[1]))
    } else if(input$aprGroup == 'scl_private'){
      selectInput('scl_private', "Private:", choices = unique(multiyr_ncaa$scl_private), multiple = TRUE, selected=unique(multiyr_ncaa$scl_private[1]))
    }
  })
  
  output$aprBoxPlot <- renderPlot({
    
    if(input$aprGroup == 'sport_name') {
      multiyr_ncaa %>%
        filter(sport_name %in% input$sport_name) %>%
        ggplot(aes(x=sport_name, y=multiyr_apr_rate_1000_official, fill=sport_name)) +
        geom_boxplot() +
        xlab("Sport") +
        ylab("Academic Performance Rate") +
        labs(fill='Sport:') +
        theme_gray()
    }else if(input$aprGroup == 'confname_18') {
      multiyr_ncaa %>%
        filter(confname_18 %in% input$confname_18) %>%
        ggplot(aes(x=confname_18, y=multiyr_apr_rate_1000_official, fill=confname_18)) +
        geom_boxplot() +
        xlab("Conference") +
        ylab("Academic Performance Rate") +
        labs(fill='Conference:') +
        theme_gray() 
    }else if(input$aprGroup == 'scl_name'){
      multiyr_ncaa %>%
        filter(scl_name %in% input$scl_name) %>%
        ggplot(aes(x=scl_name, y=multiyr_apr_rate_1000_official, fill=scl_name)) +
        geom_boxplot() +
        xlab("School") +
        ylab("Academic Performance Rate") +
        labs(fill='School:') +
        theme_gray() 
    }else if(input$aprGroup == 'scl_hbcu'){
      multiyr_ncaa %>%
        filter(scl_hbcu %in% input$scl_hbcu) %>%
        ggplot(aes(x=scl_hbcu, y=multiyr_apr_rate_1000_official, fill=scl_hbcu)) +
        geom_boxplot() +
        xlab("HBCU") +
        ylab("Academic Performance Rate") +
        labs(fill='HBCU:') +
        theme_gray() 
    }else if(input$aprGroup == 'scl_private'){
      multiyr_ncaa %>%
        filter(scl_private %in% input$scl_private) %>%
        ggplot(aes(x=scl_private, y=multiyr_apr_rate_1000_official, fill=scl_private)) +
        geom_boxplot() +
        xlab("School Type") +
        ylab("Academic Performance Rate") +
        labs(fill='School Type:') +
        theme_gray() 
    }
  })
  
  output$aprMap <- renderLeaflet({
    #merge data frame into states
    statesGEO@data <- statesGEO@data %>%
      left_join(state_names, by = c("NAME" = "State")) %>%
      left_join(leafletdf, by = c("Abbreviation" = "state"))
    
    
    pal <- colorNumeric("YlOrRd", NULL)
    map<-
      leaflet(data= statesGEO) %>%
      setView(-96, 37.8, 4)%>% 
      addTiles() %>%
      addPolygons(stroke = FALSE, 
                  smoothFactor     = 0.3,
                  fillOpacity      = 0.7,
                  opacity          = 1,
                  dashArray        = "3",
                  weight           = 2,
                  color            = "white",
                  fillColor        = ~pal(leafletdf$stateAvg),
                  label            = ~paste0(NAME, ": ", formatC(leafletdf$stateAvg)),
                  highlightOptions = highlightOptions(color = "white",
                                                      fillOpacity = 2,
                                                      bringToFront = TRUE
                  )) %>%
      addLegend("bottomright",
                pal          = pal, 
                values       = ~(leafletdf$stateAvg), 
                opacity      = 0.8, 
                title        = "Average APR",
                labFormat    = labelFormat(suffix = "%"))
  }
  )
  
  
  
}