library(shiny)
library(ggplot2)
library(tidyverse)
library(rgdal)
library(leaflet)
library(shinydashboard)

multiyr_ncaa <- read.csv("multiyr_ncaa.csv")
leafletdf <- read_csv("leafletdf.csv")
state_names<- read_csv("states.csv")
statesGEO  <- rgdal::readOGR("states.geo.json")

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
  
  #output$retentionDensity <- renderPlot({
    #multiyr_ncaa %>%
     # filter(scl_name %in% input$densityIncludeSchools) %>%
      #ggplot (aes_string(""))
 # })
  
  output$plotFilter <- renderUI({
    if(input$aprGroup == 'sport_name') {
      selectInput('sport_name', "Sport:", choices = unique(multiyr_ncaa$sport_name), multiple = TRUE, selected=unique(multiyr_ncaa$sport_name[1]))
    } else if(input$aprGroup == 'confname_18') {
      selectInput('confname_18', "Conference:", choices = unique(multiyr_ncaa$confname_18), multiple = TRUE, selected=unique(multiyr_ncaa$confname_18[1]))
    } else {
      selectInput('scl_name', "School:", choices = unique(multiyr_ncaa$scl_name), multiple = TRUE, selected=unique(multiyr_ncaa$scl_name[1]))
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
    }else {
      multiyr_ncaa %>%
        filter(scl_name %in% input$scl_name) %>%
        ggplot(aes(x=scl_name, y=multiyr_apr_rate_1000_official, fill=scl_name)) +
        geom_boxplot() +
        xlab("School") +
        ylab("Academic Performance Rate") +
        labs(fill='scl_name') +
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
                title        = "Does this work",
                labFormat    = labelFormat(suffix = "%"))
  }
  )
  
  
  
}


