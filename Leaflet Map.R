library(tidyverse)
library(leaflet)
library(rgdal)
leafletdf <- read_csv("leafletdf.csv")
state_names<- read_csv("states.csv")
statesGEO  <- rgdal::readOGR("states.geo.json")
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