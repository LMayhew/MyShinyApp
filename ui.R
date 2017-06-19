library(shiny);library(DAAG)

shinyUI(fluidPage(

  titlePanel("Named US Hurricane Damage"),

  sidebarLayout(
    sidebarPanel(
      p("Things to try:"),
      p("1. Select a region of the graph"),
      p("2. Check Show Model to see fit line on graph and intercept, slope values"),
      p("3. Uncheck the Hurricane Katrina and/or Sandy buttons"),
      p("4. Use the slider to select the years for the plot and model"),
      checkboxInput("showModelOutputs","Show Model Outputs",value=TRUE),
      checkboxInput("showKatrina","Indicate Hurricane Katrina (Red)",value=TRUE),
      checkboxInput("showSandy","Indicate Hurricane Sandy (Green)",value=TRUE),
      sliderInput("yearSlider","Limit the Number of Years",1950,2012,value=c(1950,2012))
    ),

    mainPanel(
      plotOutput("plot1",brush=brushOpts(id="plotBrush"),height="600px",width="600px"),
      textOutput("modelOutputs")
    )
  )
))
