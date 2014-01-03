library(shiny)
library(rCharts)


 
shinyUI(pageWithSidebar(
  
  
  
  headerPanel("rCharts for Web"),
  
  
  sidebarPanel(

  ),
  
  mainPanel(
    
    tabsetPanel(
      tabPanel("Time: Morris", showOutput("timeMorris", "morris")),
      tabPanel("Time: High", showOutput("timeHigh", "Highcharts")),
<<<<<<< HEAD
      #tabPanel("Time: Rickshaw", showOutput("timeRickshaw", "rickshaw")),
=======
      tabPanel("Time: Rickshaw", showOutput("timeRickshaw", "rickshaw")),
>>>>>>> 806f87961060edaaf24e29922cbc642772c95dbe
      tabPanel("Time: NVD3", showOutput("timeNvd3", "nvd3")),
      tabPanel("Box: High", showOutput("boxHigh", "Highcharts"))
      
          
  )
)))
