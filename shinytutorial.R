library(shiny)
library(tidyverse)
library(rsconnect)

# generate a blank page user interface:

ui_ <- fluidPage( #select your inputs:
        sliderInput(inputId = "num",
                    label="Number of Observations",
                    value=51,min=2,max=100),
        textInput(inputId = "hist_title",
                  label = "Write a Title for the Histogram",
                  value = "Histogram of Random Normal Values"),
        plotOutput("hist"),
        verbatimTextOutput("stats")
        )

# Generate the Server Function to Assemble Outputs From Inputs

server_ <- function(input, output) {
  
  # Save outputs:
  obs <- reactive({
                  set.seed(1)
                  rnorm(input$num)
                 })
  
  output$hist <- renderPlot({
                            hist(obs(),main=input$hist_title)
                            })
  
  output$stats <- renderPrint({
                              summary(obs())
                              })
}

# Apply the server to user interface:

shinyApp(ui = ui_, server = server_)
