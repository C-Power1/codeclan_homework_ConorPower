library(shiny)
library(tidyverse)
library(CodeClanData)
library(shinythemes)
library(png)


source("global.R")

#UI section

ui <- fluidPage(
  
  theme = shinytheme("slate"),
  
  titlePanel(tags$b("Olympic Games")),
  
  
  tabsetPanel(
    
    tabPanel(
      "Top Five Teams by Medal Count",
      
      column(4,
             
      plotOutput("medal_plot")),
      
      column(4,
             
      radioButtons("medal",
                   "What medal?",
                   choices = c("Gold", "Silver", "Bronze")
                   
      )),
      column(4,
             
      selectInput("season",
                  "Summer or Winter Olympics?",
                  choices = c("Summer", "Winter")
      ))
      
    ),
    
    
    tabPanel("History",
             tags$a("The Official History of the Olympic Games", href="https://www.olympic.org/ancient-olympic-games/history")
             ),
    
    tabPanel(
      "Summer Gold Medal Count",
             plotOutput("percent_olympics_summer_gmedals_plot"))
    
  )
)


# Server section 
server <- function(input, output) {
    output$medal_plot <- renderPlot({
        
        plot_medal(input$medal, input$season)
    })
    
    output$percent_olympics_summer_gmedals_plot <- renderPlot({
      percent_olympics_summer_gmedals_plot(input$percent_of_medals)
    })
}

# Run the app
shinyApp(ui = ui, server = server)
