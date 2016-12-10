# Author: Ron Ammar
# Contact: ron.ammar@gmail.com
# Description: Shiny app 
# Start date: 2016-12-10
# Version 0.1.0

# Do not convert character vectors to factors unless explicitly indicated
options(stringsAsFactors=FALSE)

babyNames <- readRDS("data/baby_names.rds")

library(dplyr)
library(ggplot2)
library(shiny)
library(stringr)
library(tidyr)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   titlePanel("Popularity of baby names in the USA since 1880 (data from SSA)"),
   
   verticalLayout(
      sidebarPanel(
         sliderInput("year",
                     "Birth year",
                     min=min(babyNames$year),
                     max=max(babyNames$year),
                     value=1988,  # a great year!
                     sep='',
                     animate=TRUE)
      ),
      
      mainPanel(
         plotOutput("hist")
      )
   ),
   
   sidebarLayout(
     sidebarPanel(
       textInput("names",
                 "Lookup name",
                 value="Ron, Daniel, Helen, Michal")
     ),
     
     mainPanel(
       plotOutput("density")
     )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$hist <- renderPlot({
     # Plot a histogram of name counts for the top 20 names for a given year
     d <- babyNames %>%
       mutate(name=str_to_title(name)) %>%
       filter(year == input$year) %>%
       group_by(sex) %>%
       arrange(desc(count)) %>%
       top_n(20, count)
     
     # Below we use custom factor levels to preserve ordering when plotted
     d$name <- factor(d$name, levels=d$name)
     
     ggplot(d, aes(x=name, y=count, fill=sex)) +
       facet_wrap(~ sex, scale="free") +
       geom_bar(stat="identity") +
       labs(x="Baby name", y="Number of babies", fill="Sex") +
       theme_bw(17) +
       theme(axis.text.x = element_text(angle=60, hjust=1))
   })
   
   output$density <- renderPlot({
     # Density plot of specific name popularity over the years
     specificNames <- unlist(str_split(str_to_lower(input$names), ","))
     # Trim any whitespace between names
     specificNames <- str_trim(specificNames)
     d <- filter(babyNames, name %in% specificNames)
     
     ggplot(d, aes(x=year, y=count, color=name)) +
       facet_wrap(~ sex) +
       geom_line() + 
       theme_bw()
       
   })
}

# Run the application 
shinyApp(ui=ui, server=server)

