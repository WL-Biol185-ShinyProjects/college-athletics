library(shiny)

fluidPage(
  
  title= "APR Made Interactive",
  titlePanel("APR"),
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

