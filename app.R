#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Thickness from Sheet Resistance"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         
         
         numericInput("Resistivity",
                      "Material Resistivty / uOhm x cm",
                      value=8.81),
         
         numericInput("Sheet_R",
                      "Measured Sheet Resistance / Ohm/sq",
                      value=0.22)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
              h2("Thickness Results"),
              
              tableOutput("table_res")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
        output$table_res<- renderTable({

                Thickness=round(input$Resistivity*1e-6/input$Sheet_R*1e7)               
                data.frame("Resistivity"=input$Resistivity, "Thick_in_nm"= Thickness)
                
        }) 
  
}

# Run the application 
shinyApp(ui = ui, server = server)

