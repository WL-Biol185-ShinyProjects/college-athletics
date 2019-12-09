#data manipulation file

library(tidyverse)
library(readr)
library(dplyr)

#import data
ncaa_data <- read_csv("data/ncaa_data.csv")

#columns to lowercase
names(ncaa_data) <- tolower(names(ncaa_data))

#rearrange columns alphabetically
ncaa_data <- ncaa_data[ , order(names(ncaa_data))]


#delete unnecessary columns
ncaa_data_selected <- ncaa_data %>%
  select(-scl_unitid, -academic_year, -scl_sub_18, -d1_fb_conf_18, -elig_rate_2004, -elig_rate_2005, -elig_rate_2006, -elig_rate_2007, -elig_rate_2008, -elig_rate_2009, -elig_rate_2010, -elig_rate_2011, -elig_rate_2012, -elig_rate_2013, -elig_rate_2014, -elig_rate_2015, -elig_rate_2016, -elig_rate_2017, -elig_rate_2018, -ret_rate_2004, -ret_rate_2005, -ret_rate_2006, -ret_rate_2007, -ret_rate_2008, -ret_rate_2009, -ret_rate_2010, -ret_rate_2011, -ret_rate_2012, -ret_rate_2013, -ret_rate_2014, -ret_rate_2015, -ret_rate_2016, -ret_rate_2017, -ret_rate_2018, -data_tab_annualrate, -data_tab_generalinfo, -data_tab_multiyrrate, -datatab_publicaward, -num_of_athletes_2004, -num_of_athletes_2005, -num_of_athletes_2006, -num_of_athletes_2007, -num_of_athletes_2008, -num_of_athletes_2009, -num_of_athletes_2010, -num_of_athletes_2011, -num_of_athletes_2012, -num_of_athletes_2013, -num_of_athletes_2014, -num_of_athletes_2015, -num_of_athletes_2016, -num_of_athletes_2017, -num_of_athletes_2018, -multiyr_apr_rate_1000_ci, -multiyr_apr_rate_1000_raw, -raw_or_ci)


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


#replaced NA's with 0s in pub_award_column
ncaa_data_tidy$pub_award[is.na(ncaa_data_tidy$pub_award)] <- 0


#created multi year pub award variable
ncaa_data_tidy <- ncaa_data_tidy %>%
  group_by(scl_name, sport_name) %>%
  mutate(multiyr_pub_award = sum(pub_award))


#create multi year table
multiyr_ncaa <- ncaa_data %>%
  select(confname_18, multiyr_apr_rate_1000_official, multiyr_elig_rate, multiyr_ret_rate, multiyr_squad_size, scl_div_18, scl_hbcu, scl_name, scl_private, sport_code, sport_name, pub_award_06, pub_award_07, pub_award_08, pub_award_09, pub_award_10, pub_award_11, pub_award_12, pub_award_13, pub_award_14, pub_award_15, pub_award_16, pub_award_17, pub_award_18, pub_award_19)

#create mult year public award variable
multiyr_ncaa <- gather(multiyr_ncaa, key= "year_pub_award", value= "pub_award", pub_award_06:pub_award_19)

multiyr_ncaa$pub_award[is.na(multiyr_ncaa$pub_award)] <- 0

multiyr_ncaa <- multiyr_ncaa %>%
  group_by(scl_name, sport_name) %>%
  mutate(multiyr_pub_award = sum(pub_award))

multiyr_ncaa <- multiyr_ncaa %>%
  select(-pub_award, -year_pub_award)

#changing scl_hbcu and acl_private columns to factors from integers
multiyr_ncaa$scl_hbcu <- factor(multiyr_ncaa$scl_hbcu,
                                levels = c(0, 1),
                                labels = c("Not HBCU", "HBCU"))
multiyr_ncaa$scl_private <- factor(multiyr_ncaa$scl_private,
                                   levels = c(0, 1),
                                   labels = c("Public", "Private"))


#import data set with universities by state
ncaa_uni_state <- read_csv("ncaa_uni_state.csv")
#merge with NCAA dataset
state_multiyr_ncaa <- inner_join(multiyr_ncaa, ncaa_uni_state, by= "scl_name")
#create an average APR by state column
state_multiyr_ncaa<- state_multiyr_ncaa %>%
  drop_na(multiyr_apr_rate_1000_official)%>%
  group_by(state)%>%
  mutate(stateAvg = mean(multiyr_apr_rate_1000_official))

leafletdf<- data.frame("state"= unique(state_multiyr_ncaa$state), "stateAvg"=unique(state_multiyr_ncaa$stateAvg))

#import data set with state names and abbreviations
state_names<- read_csv("states.csv")

#create table of data by year 
ncaa_by_year <- ncaa_data_tidy %>%
  select(-multiyr_apr_rate_1000_official, -multiyr_elig_rate, -multiyr_pub_award, -multiyr_ret_rate, -multiyr_squad_size)



#create gender column

ncaa_data_tidy$gender <- NA
ncaa_data_tidy[ncaa_data_tidy$sport_code <=17, "gender"] <- "Male"
ncaa_data_tidy[ncaa_data_tidy$sport_code  >=18 & ncaa_data_tidy$sport_code < 37, "gender"] <- "Female"
ncaa_data_tidy[ncaa_data_tidy$sport_code ==37, "gender"] <- "Mixed"

#apply gender column to all data frames
multiyr_ncaa$gender <- NA
multiyr_ncaa[multiyr_ncaa$sport_code <=17, "gender"] <- "Male"
multiyr_ncaa[multiyr_ncaa$sport_code  >=18 & multiyr_ncaa$sport_code < 37, "gender"] <- "Female"
multiyr_ncaa[multiyr_ncaa$sport_code ==37, "gender"] <- "Mixed"

ncaa_by_year$gender <- NA
ncaa_by_year[ncaa_by_year$sport_code <=17, "gender"] <- "Male"
ncaa_by_year[ncaa_by_year$sport_code  >=18 & ncaa_by_year$sport_code < 37, "gender"] <- "Female"
ncaa_by_year[ncaa_by_year$sport_code ==37, "gender"] <- "Mixed"
#may need to execute this sort of code for the state_multiyr_ncaa

write.csv(multiyr_ncaa, "multiyr_ncaa.csv")
write.csv(ncaa_by_year, "ncaa_by_year.csv")
write.csv(state_multiyr_ncaa, "state_multiyr_ncaa.csv")
write.csv(state_names, "states.csv")
write.csv(leafletdf, "leafletdf.csv")
