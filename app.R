library(shiny)

ui <- fluidPage(
  titlePanel("Lesser Black-backed Gull Compensation Calculator"),
  sidebarLayout(
    sidebarPanel(
      numericInput("target", "Target number of birds:", value = 1, min = 0, step = 0.01),
      numericInput("survival_0_1", "Survival 0-1:", value = 0.82, min = 0, max = 1, step = 0.001),
      numericInput("survival_1_2", "Survival 1-2:", value = 0.885, min = 0, max = 1, step = 0.001),
      numericInput("survival_2_3", "Survival 2-3:", value = 0.885, min = 0, max = 1, step = 0.001),
      numericInput("survival_3_4", "Survival 3-4:", value = 0.885, min = 0, max = 1, step = 0.001),
      numericInput("survival_4_5", "Survival 4-5:", value = 0.885, min = 0, max = 1, step = 0.001),
      numericInput("productivity", "Productivity:", value = 0.53, min = 0, step = 0.01),
      sliderInput("ratio", "Compensation ratio = 1:_", value = 1, min = 1, max = 5)
    ),
    mainPanel(
      h3("Breeding Pairs Needed:"),
      textOutput("breeding_pairs")
    )
  )
)

server <- function(input, output) {
  output$breeding_pairs <- renderText({
    survival_product <- input$survival_0_1 * input$survival_1_2 * input$survival_2_3 * 
      input$survival_3_4 * input$survival_4_5
    
    if (input$productivity > 0) {
      breeding_pairs_needed <- (input$target / survival_product) * input$ratio / input$productivity
      round(breeding_pairs_needed, 2)
    } else {
      "Productivity must be greater than 0"
    }
  })
}

shinyApp(ui = ui, server = server)
