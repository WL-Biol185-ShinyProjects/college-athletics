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
#year_apr_rate
ncaa_data <- gather(ncaa_data, key = "year_apr_rate", value = "apr_rate", apr_rate_2004_1000:apr_rate_2018_1000)

#year_elig_rate
ncaa_data <- gather(ncaa_data, key= "year_elig_rate", value= "elig_rate", elig_rate_2004:elig_rate_2018)

#num_of_athletes
ncaa_data <- gather(ncaa_data, key = "year_num_of_athletes", value = "num_of_athletes", num_of_athletes_2004:num_of_athletes_2018)

#ret_rate
ncaa_data <- gather(ncaa_data, key = "year_ret_rate", value = "ret_rate", ret_rate_2004:ret_rate_2018)



