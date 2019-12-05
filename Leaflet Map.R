library(tidyverse)
library(leaflet)
statesGEO  <- rgdal::readOGR("states.geo.json", "OGRGeoJSON")
state<- read_csv("state_multiyr_ncaa.csv")
map <- leaflet(state)
View(map)

