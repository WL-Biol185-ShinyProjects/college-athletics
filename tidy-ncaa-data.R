#data manipulation file

library(tidyverse)
library(readr)

#import data
ncaa_data <- read_csv("data/ncaa_data.csv")

#columns to lowercase
names(ncaa_data) <- tolower(names(ncaa_data))

#rearrange columns alphabetically
ncaa_data <- ncaa_data[ , order(names(ncaa_data))]
  

#gather columns
ncaa_data <- gather(ncaa_data[83:96], key = "year_award", value = "award", PUB_AWARD_19:PUB_AWARD_06)

pub_awards <- ncaa_data %>%
  select(PUB_AWARD_06, PUB_AWARD_07, PUB_AWARD_08, PUB_AWARD_09, PUB_AWARD_10, PUB_AWARD_11, PUB_AWARD_12, PUB_AWARD_13, PUB_AWARD_14, PUB_AWARD_15, PUB_AWARD_16, PUB_AWARD_17, PUB_AWARD_18, PUB_AWARD_19)

pub_awards_gathered <- gather(pub_awards, key = "year", value = "award", PUB_AWARD_06:PUB_AWARD_19)

