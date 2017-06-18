library(shiny);library(DAAG)

shinyUI(fluidPage(

  titlePanel("Named US Hurricane Damage"),

  sidebarLayout(
    sidebarPanel(
      p("Things to try:"),
      p("1. Select a region of the graph"),
      p("2. Click Show Model to see fit line on graph and intercept, slope values"),
      checkboxInput("showModelOutputs","showModelOutputs",value=TRUE)
    ),

    mainPanel(
      plotOutput("plot1",brush=brushOpts(id="plotBrush")),#,delay=5000)),
      textOutput("modelOutputs")
    )
  )
))
