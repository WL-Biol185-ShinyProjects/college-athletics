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
ncaa_data <- gather(ncaa_data, key = "year_apr_rate", value = "apr_rate", apr_rate_2004_1000:apr_rate_2018_1000)


