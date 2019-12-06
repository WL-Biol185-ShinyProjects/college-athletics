library(tidyverse)
library(leaflet)
library(rgdal)

statesGEO  <- rgdal::readOGR("states.geo.json")
#merge data frame into states
statesGEO@data <- statesGEO@data %>%
  left_join(state_names, by = c("NAME" = "State")) %>%
  left_join(state_multiyr_ncaa, by = c("Abbreviation" = "state"))

state_multiyr_ncaa<- read_csv("state_multiyr_ncaa.csv")

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
              fillColor        = ~pal(state_mulityr_ncaa$multiyr_apr_rate_1000_official),
              label            = ~paste0(NAME, ": ", formatC(state_mulityr_ncaa$multiyr_apr_rate_1000_official)),
              highlightOptions = highlightOptions(color = "white",
                                                  fillOpacity = 2,
                                                  bringToFront = TRUE
                                                  )) %>%
  addLegend("bottomright",
            pal          = pal, 
            values       = ~(state_mulityr_ncaa$multiyr_apr_rate_1000_official), 
            opacity      = 0.8, 
            title        = "Does this work",
            labFormat    = labelFormat(suffix = "%"))