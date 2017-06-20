library(shiny);library(DAAG)

shinyServer(function(input, output) {

    output$myURL <- renderUI({
         tagList("URL link:", a("https://github.com/LMayhew/MyShinyApp", 
                                href="https://github.com/LMayhew/MyShinyApp"))
    })      
      
    getData <- reactive({
          minYr <- input$yearSlider[1]
          maxYr <- input$yearSlider[2]
          
          yearRangeIndex <- which(hurricNamed$Year >= minYr & hurricNamed$Year <= maxYr )
          
          dataX <- hurricNamed$LF.WindsMPH[yearRangeIndex]
          dataY <- hurricNamed$BaseDamage[yearRangeIndex]
          
          df <- data.frame(LF.WindsMPH=dataX,BaseDamage=dataY)
    })      
      
    model <- reactive({

          df <- getData()
          brushed_data <- brushedPoints(df,
                 input$plotBrush, 
                 #brush,
                 xvar="LF.WindsMPH", yvar="BaseDamage")

          if (nrow(brushed_data) < 2) {
                return(NULL)
          }

          lm(BaseDamage~LF.WindsMPH, data=brushed_data)
    })        
  
    output$plot1 <- renderPlot({
          
          xLimit <- range(hurricNamed$LF.WindsMPH)
          yLimit <- range(hurricNamed$BaseDamage)
          
          minYr <- input$yearSlider[1]
          maxYr <- input$yearSlider[2]

          yearRangeIndex <- which(hurricNamed$Year >= minYr & hurricNamed$Year <= maxYr )
          
          dataX <- hurricNamed$LF.WindsMPH[yearRangeIndex]
          dataY <- hurricNamed$BaseDamage[yearRangeIndex]
          
          plot(dataX,dataY, xlim = xLimit, ylim=yLimit,
               xlab="Windspeed (mph)", 
               ylab="Damage (Millions of US Dollars)",
               main="Damage from Named US Hurricanes",
               cex=1.5, pch=16, bty="n")
          if (input$showKatrina) {
                rowKatrina <- hurricNamed[hurricNamed$Name=="Katrina",]
                points(rowKatrina$LF.WindsMPH,rowKatrina$BaseDamage, col="red",cex=3)
          }
          if (input$showSandy) {
                rowSandy <- hurricNamed[hurricNamed$Name=="Sandy",]
                points(rowSandy$LF.WindsMPH,rowSandy$BaseDamage, col="darkgreen",cex=3)
          }
          if (!is.null(model()) && input$showModelOutputs) {
                abline(model(), col="blue",lwd=2)
          }
    })

   output$modelOutputs = renderText({
      if (input$showModelOutputs){
          if (is.null(model())){
                "MODEL OUTPUTS: No Model"
          } else { #sprintf(fmt="%.4f+%.6f",pi,exp(1)) 
             intercept <- sprintf(fmt="%.0f",model()[[1]][1])
             slope     <- sprintf(fmt="%.2f",model()[[1]][2])
             paste("MODEL OUTPUTS: Intercept:",intercept,"Slope:",slope)
          }
       } else{
          ""
       }
    })
  

})
