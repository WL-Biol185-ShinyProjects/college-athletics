library(tidyverse)
library(leaflet)
library(rgdal)
#why doesnt this work/where does this data play into 
statesGEO  <- rgdal::readOGR("states.geo.json", "OGRGeoJSON")
state_multiyr_ncaa<- read_csv("state_multiyr_ncaa.csv")

state_mulityr_ncaa<- as.data.frame(state_multiyr_ncaa)

#View(map)
#what data are we supposed to read into the leaflet
pal <- colorNumeric("YlOrRd", NULL)
#map<-
leaflet(data= state_multiyr_ncaa) %>%
setView(-96, 37.8, 4)%>% 
addTiles() %>%
  addPolygons(stroke = FALSE, 
              smoothFactor     = 0.3,
              fillOpacity      = 0.7,
              opacity          = 1,
              dashArray        = "3",
              weight           = 2,
              color            = "white",
              fillColor        = ~pal(state_mulityr_ncaa$state),
              label            = ~paste0(NAME, ": ", formatC(state_mulityr_ncaa$state)),
              highlightOptions = highlightOptions(color = "white",
                                                  fillOpacity = 2,
                                                  bringToFront = TRUE
                                                  )) %>%
  addLegend("bottomright",
            pal          = pal, 
            values       = ~(state_mulityr_ncaa$state), 
            opacity      = 0.8, 
            title        = "Does this work",
            labFormat    = labelFormat(suffix = "%"))