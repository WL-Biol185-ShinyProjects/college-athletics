library(shiny)



multiyr_ncaa <- read.csv ("multiyr_ncaa.csv")

fluidPage(

  title= "APR Made Interactive",
  tabsetPanel(
    tabPanel (title = "Density Distribution",

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
),

tabPanel(title = "Box Plots Showing APR",

         sidebarLayout(
           sidebarPanel(
             selectInput(
               inputId = "aprGroupBy",
               label = "Group by",
               choices = list(Sport = "sport_name",
                              Conference = "confname_18",
                              School = "scl_name"
                              ),
               selected = "sport_name",
               uiOutput('plotFilter')
             ),
           mainPanel(
             plotOutput("aprBoxPlot"))
           )
         ))

)
)




