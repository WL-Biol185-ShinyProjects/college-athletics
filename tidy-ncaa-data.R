#data manipulation file

library(tidyverse)
library(readr)

ncaa_data <- read_csv("data/ncaa_data.csv")

ncaa_by_yr <- gather(ncaa_data[83:96], key = "year", value = "award", 2019:2006)

