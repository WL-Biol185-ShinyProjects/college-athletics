#practice for scatterplot

library(tidyverse)
library(broom)

multiyr_ncaa <- read.csv ("multiyr_ncaa.csv")

scatter <- multiyr_ncaa %>%
  ggplot(aes(x=sport_name, y=multiyr_apr_rate_1000_official)) +
  geom_point() +
  geom_abline()

#exogenous variables: sport_name, scl_name, scl_div_18, conf_name18, scl_hbcu, scl_private, pub_award?

APRreg <- lm(formula = multiyr_apr_rate_1000_official ~ sport_name + scl_div_18 + confname_18 + scl_hbcu + scl_private + multiyr_pub_award, data = multiyr_ncaa)

summary(APRreg)
glance(APRreg)


function(input, output) {
  
  output$aprScatter <- renderPlot({
    multiyr_ncaa %>%
      filter(scl_name %in% input$aprIncludeSchools) %>%
      ggplot(aes_string(x=input$aprGroupBy, y=multiyr_apr_rate_1000_official)) +
      geom_point() +
      geom_smooth(method="lm", se = FALSE)
  })
}