library(shiny);library(DAAG)

shinyServer(function(input, output) {

    model <- reactive({

          brushed_data <- brushedPoints(hurricNamed,
                 input$plotBrush, 
                 #brush,
                 xvar="LF.WindsMPH", yvar="BaseDamage")

          if (nrow(brushed_data) < 2) {
                return(NULL)
          }

          lm(BaseDamage~LF.WindsMPH, data=brushed_data)
    })        
  
    output$plot1 <- renderPlot({
          plot(hurricNamed$LF.WindsMPH,hurricNamed$BaseDamage,
               xlab="Windspeed (mph)", 
               ylab="Damage Millions of US Dollars",
               main="Damage from Named US Hurricanes",
               cex=1.5, pch=16, bty="n")
          if (!is.null(model())) {
                abline(model(), col="blue",lwd=2)
          }
    })

   output$modelOutputs = renderText({
      if (input$showModelOutputs){
          if (is.null(model())){
             "No Model"
          } else {
             paste("Intercept:",model()[[1]][1],"Slope:",model()[[1]][2])
          }
       } else{
          ""
       }
    })
  

})
