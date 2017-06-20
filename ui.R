library(shiny);library(DAAG)

shinyUI(fluidPage(

  titlePanel("Named US Hurricane Damage"),

  sidebarLayout(
    sidebarPanel(
      checkboxInput("showModelOutputs","Show Model Outputs",value=TRUE),
      checkboxInput("showKatrina","Indicate Hurricane Katrina (Red)",value=FALSE),
      checkboxInput("showSandy","Indicate Hurricane Sandy (Green)",value=FALSE),
      sliderInput("yearSlider","Limit the Number of Years",1950,2012,value=c(1950,2012)),
      tags$hr(
            tags$style(HTML("hr {border-top: 1px solid #000000;}"))
      ),
      h4("Things to Try!"),
      p("1. Select a region of the graph by clicking and dragging the cursor."),
      p("2. If a region is selected, check the Show Model Outputs checkbox 
        to see fit line on graph and display intercept, slope values"),
      p("3. Check the Hurricane Katrina and/or Sandy buttons to see 
        the data points of these two big hurricanes."),
      p("4. Use the slider to select the years to limit the number
        of points plotted and used in the model.")
    ),
    mainPanel(
       tabsetPanel(type="tabs",
          tabPanel("Play With Plot!",br(),
              plotOutput("plot1",brush=brushOpts(id="plotBrush"),height="600px",width="600px"),
              textOutput("modelOutputs")
          ),
          tabPanel("Documentation",br(),
              h4("About the data..."),
              p('The Names US Atlantic Hurricanes data is from the R package "DAAG" 
                     and gives details of atmosperic pressure and windspeed at landfall,
                     estimated damage in millions of dollars and deaths for named
                     hurricanes that made landfall in the US mainland from 1950 to 2012.'),
              br(),
              h4("About the calculations..."),
              p("The linear model used to fit the relationship between windspeed
                and damage was the 'lm' package.  The formula is"),
              p("damage = m * windspeed + b"),
              p("where m is the slope and b is the intercept.  On the plot tab you can
                see the calculated intercept and slope (and resulting line on the graph)
                provided you selected a region and also checked the Show Model 
                Outputs checkbox."),
              p("In addition, you can limit the amount of data used in the calculation
                by selected not all the points and also by reducing the range of years
                selected using the slider.")
                
          )
       )
    )
  )
))
