## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  eval = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## ----basic_ui-----------------------------------------------------------------
#  library(shiny)
#  
#  ui <- fluidPage(
#    numericInput("number", "Select number:", 5, 1, 10),
#    actionButton("delete", "Remove input"),
#    p("Selected number:", textOutput("number_out", inline = TRUE))
#  )
#  
#  server <- function(input, output, session) {
#    output$number_out <- renderText(input$number)
#  
#    observeEvent(input$delete, removeUI("#number"))
#  }
#  
#  shinyApp(ui, server)

## ----destroy_ui---------------------------------------------------------------
#  library(shiny)
#  library(shiny.destroy)
#  
#  ui <- fluidPage(
#    numericInput("number", "Select number:", 5, 1, 10),
#    actionButton("delete", "Remove input"),
#    p("Selected number:", textOutput("number_out", inline = TRUE))
#  )
#  
#  server <- function(input, output, session) {
#    output$number_out <- renderText(input$number %||% "input unavailable")
#  
#    observeEvent(
#      input$delete,
#      removeInput("number", selector = ":has(> #number)")
#    )
#  }
#  
#  shinyApp(ui, server)

## ----destroy_output-----------------------------------------------------------
#  library(shiny)
#  library(shiny.destroy)
#  
#  ui <- fluidPage(
#    numericInput("bins", "Number of bins:", min = 1, max = 50, value = 30),
#    actionButton("delete", "Remove output"),
#    plotOutput("distPlot", height = "200px", width = "400px")
#  )
#  
#  server <- function(input, output, session) {
#    output$distPlot <- renderPlot({
#      x <- faithful[, 2]
#      bins <- seq(min(x), max(x), length.out = input$bins + 1)
#      hist(
#        x,
#        breaks = bins,
#        col = "darkgray",
#        border = "white",
#        xlab = "Waiting time to next eruption (in mins)",
#        main = "Histogram of waiting times"
#      )
#    })
#  
#    observeEvent(input$delete, removeOutput("distPlot"))
#  }
#  
#  shinyApp(ui, server)

## ----module_example-----------------------------------------------------------
#  shiny::runExample(
#    "01_boxes",
#    package = "shiny.destroy"
#  )

## ----stop_observer------------------------------------------------------------
#  library(shiny)
#  
#  ui <- fluidPage(
#    actionButton("update", "Increase"),
#    actionButton("stop", "Stop increasing"),
#    p("Updates:", textOutput("number_out", inline = TRUE))
#  )
#  
#  server <- function(input, output, session) {
#    clicks <- reactiveVal(0)
#  
#    update_obs <- observeEvent(input$update, clicks(clicks() + 1))
#  
#    observeEvent(input$stop, update_obs$destroy())
#  
#    output$number_out <- renderText(clicks())
#  }
#  
#  shinyApp(ui, server)

