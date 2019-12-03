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
          title = "Box",
          title = "Box Plots Showing APR",
          
          sidebarLayout(
            sidebarPanel(
              selectInput(
                inputId = "aprGroupBy",
                label = "Group by",
                choices = list(Sport = "sport_name",
                               Conference = "confname_18",
                               School = "scl_name"
                )),
              selected = "sport_name",
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