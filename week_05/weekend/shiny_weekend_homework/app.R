library(CodeClanData)
library(dplyr)
library(ggplot2)
library(shiny)
library(data.table)

source("global.R")


ui <- fluidPage(
    
    theme = shinytheme("sandstone"),
    
    titlePanel(tags$b("Video Games 1988-2018")),
    
    
    tabsetPanel(
        
        tabPanel(
            "Top Ten Selling Games",
            column(4,
                   selectInput("genre",
                               "Choose genre",
                               choices = unique(game_sales$genre))
            ),
            column(4,
                   selectInput("year",
                               "Choose year",
                               choices = unique(game_sales$year_of_release))  
            ),
            column(4,
                   selectInput("developer",
                               "Choose developer",
                               choices = unique(game_sales$developer))
            ),
            column(4,
                   selectInput("platform",
                               "Choose platform",
                               choices = unique(game_sales$platform))
            ),
            
            actionButton("update", "Find game"),
            
            DT::dataTableOutput("table_output")
        ),
        
        tabPanel(
            "Score Comparison",
            
            column(4,
                   
                   plotOutput("scatter")),
            
            column(4,
                   
                   sliderInput("transparency",
                               "Transparency",
                               min = 0, max = 1, value = 0.8)        
            )
            
        )
    )    
)


server <- function(input, output) {
    
    game_data <- eventReactive(input$update, {
        
        game_sales %>%
            filter(genre == input$genre)  %>%
            filter(year_of_release == input$year) %>%
            filter(developer == input$developer) %>%
            filter(platform == input$platform) %>% 
            slice(1:10) %>%
            mutate(round((user_score * 10)))
        
        
    })
    
    output$table_output <- DT::renderDataTable({
        game_data()
        
    })
    
    game_data2 <- reactive({
      
      game_sales
      
    })
    
    output$scatter <- renderPlot({
      ggplot(game_data2()) +
        aes(x = critic_score,
            y = user_score) +
        geom_point(alpha = input$transparency)
        
    })
}

# Run the app
shinyApp(ui = ui, server = server)
