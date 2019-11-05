#data manipulation file

library(tidyverse)
library(readr)

#import data
ncaa_data <- read_csv("data/ncaa_data.csv")

#columns to lowercase
names(ncaa_data) <- tolower(names(ncaa_data))

#rearrange columns alphabetically
ncaa_data <- ncaa_data[ , order(names(ncaa_data))]

#delete unnecessary columns
ncaa_data_selected <- ncaa_data %>%
  select(-scl_unitid, -sport_code, -academic_year, -scl_sub_18, -d1_fb_conf_18, -elig_rate_2004, -elig_rate_2005, -elig_rate_2006, -elig_rate_2007, -elig_rate_2008, -elig_rate_2009, -elig_rate_2010, -elig_rate_2011, -elig_rate_2012, -elig_rate_2013, -elig_rate_2014, -elig_rate_2015, -elig_rate_2016, -elig_rate_2017, -elig_rate_2018, -ret_rate_2004, -ret_rate_2005, -ret_rate_2006, -ret_rate_2007, -ret_rate_2008, -ret_rate_2009, -ret_rate_2010, -ret_rate_2011, -ret_rate_2012, -ret_rate_2013, -ret_rate_2014, -ret_rate_2015, -ret_rate_2016, -ret_rate_2017, -ret_rate_2018, -data_tab_annualrate, -data_tab_generalinfo, -data_tab_multiyrrate, -datatab_publicaward, -num_of_athletes_2004, -num_of_athletes_2005, -num_of_athletes_2006, -num_of_athletes_2007, -num_of_athletes_2008, -num_of_athletes_2009, -num_of_athletes_2010, -num_of_athletes_2011, -num_of_athletes_2012, -num_of_athletes_2013, -num_of_athletes_2014, -num_of_athletes_2015, -num_of_athletes_2016, -num_of_athletes_2017, -num_of_athletes_2018)

#gather columns
#year_apr_rate
ncaa_data_tidy <- gather(ncaa_data_selected, key = "year_apr_rate", value = "apr_rate", apr_rate_2004_1000:apr_rate_2018_1000)


#year_pub_award
ncaa_data_tidy <- gather(ncaa_data_tidy, key= "year_pub_award", value= "pub_award", pub_award_06:pub_award_19)


#num_of_athletes #may end up deleting all num_athletes columns or aggregating somehow
#ncaa_data_tidy <- gather(ncaa_data_tidy, key = "year_num_of_athletes", value = "num_of_athletes", num_of_athletes_2004:num_of_athletes_2018)

#extracting years using substr()
ncaa_data_tidy$year_apr_rate <- substr(ncaa_data_tidy$year_apr_rate, start=10, stop=13)

ncaa_data_tidy$year_pub_award <- substr(ncaa_data_tidy$year_pub_award, start=11, stop=12)

ncaa_data_tidy$year_pub_award <- paste("20", ncaa_data_tidy$year_pub_award, sep="")

#making interactive plots
# ?plotOutput
#binding click event/brush event to inputId
#direction- x- if you want to brush on x axis; y if you want to brush on y axis
#resenOnNew=TRUE



