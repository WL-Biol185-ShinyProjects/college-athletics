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
        choices = unique(ncaa_data_tidy$scl_name),
        multiple=TRUE,
        selected=unique(ncaa_data_tidy$scl_name[1]),
      )
    ),
    mainPanel(
      plotOutput("aprDensity")
    )
  )
  
)

