# Author: Ron Ammar
# Contact: ron.ammar@gmail.com
# Description: Shiny app 
# Start date: 2016-12-10
# Version 0.1.0


##### The following section improves reproducibility when scripting ------------

# Clear the current session, to avoid errors from persisting data structures
rm(list=ls())

# Free up memory by forcing garbage collection
invisible(gc())

# Manually set the seed to an arbitrary number for consistency in reports
set.seed(1234)

# Do not convert character vectors to factors unless explicitly indicated
options(stringsAsFactors=FALSE)

#-------------------------------------------------------------------------------

############# Standard shiny template below (from RStudio) ---------------------


library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

