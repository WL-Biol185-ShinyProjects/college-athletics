# library(shiny)
# 
# 
# 
# multiyr_ncaa <- read.csv ("multiyr_ncaa.csv")
# 
# fluidPage(
# 
#   title= "APR Made Interactive",
#   tabsetPanel(
#     tabPanel (title = "Density Distribution",
# 
#   sidebarLayout(
# 
#     sidebarPanel(
#       selectInput(
#         inputId = "aprGroupBy",
#         label = "Group by",
#         choices = list(Conference= "confname_18",
#                        School= "scl_name"
#         ),
#         selected = "confname_18",
# 
#       ),
#       selectizeInput(
#         inputId = "aprIncludeSchools",
#         label = "Schools",
#         choices = unique(multiyr_ncaa$scl_name),
#         multiple=TRUE,
#         selected=unique(multiyr_ncaa$scl_name[1]),
#       )
#     ),
#     mainPanel(
#       plotOutput("aprDensity")
#     )
#   )
# ),
# 
# tabPanel(title = "Box Plots Showing APR",
# 
#          sidebarLayout(
#            sidebarPanel(
#              selectInput(
#                inputId = "aprGroupBy",
#                label = "Group by",
#                choices = list(Sport = "sport_name",
#                               Conference = "confname_18",
#                               School = "scl_name"
#                               )),
#                selected = "sport_name",
#                uiOutput('plotFilter')
#              ),
#            mainPanel(
#              plotOutput("aprBoxPlot"))
#            )
# 
#          )
# )
# 
# 
#          )
  


library(shiny)
library(shinydashboard)
multiyr_ncaa <- read.csv ("multiyr_ncaa.csv")

dashboardPage(
  dashboardHeader(title="APR Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("density", tabName = "density"),
      menuItem("boxplots", tabName = "boxplots")
    )
  ),
  
  dashboardBody(
    tabItems(
      #First tab content
      tabItem(tabName = "density",
              fluidRow(
                box(
                  width= 12,
                  title = "Density",
                  sidebarLayout(
                    
                    sidebarPanel(
                      selectInput(
                        inputId = "aprGroupBy",
                        label = "Group by",
                        choices = list(Conference= "confname_18",
                                       School= "scl_name"
                        ),
                        selected = "confname_18",
                        
                      ),
                      selectizeInput(
                        inputId = "aprIncludeSchools",
                        label = "Schools",
                        choices = unique(multiyr_ncaa$scl_name),
                        multiple=TRUE,
                        selected=unique(multiyr_ncaa$scl_name[1]),
                      )
                    ),
                    mainPanel(
                      plotOutput("aprDensity")
                    )
                  )
                )
              )
      ),
      #second tab
      tabItem(tabName = "boxplots",
              fluidRow(
                box(
                  title = "Box Plots Showing APR",
                  width= 12,
                  sidebarLayout(
                    sidebarPanel(
                      selectInput(
                        inputId = "aprGroup",
                        label = "Group by",
                        choices = list(Sport = "sport_name",
                                       Conference = "confname_18",
                                       School = "scl_name"
                        ),
                      selected = "sport_name"),
                      uiOutput('plotFilter')
                    ),
                    mainPanel(
                      plotOutput("aprBoxPlot"))
                  )
                  
                )
              )      
      )
    )
    
  )
)


