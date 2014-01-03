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
      #tabPanel("Time: Rickshaw", showOutput("timeRickshaw", "rickshaw")),
      tabPanel("Time: NVD3", showOutput("timeNvd3", "nvd3")),
      tabPanel("Box: High", showOutput("boxHigh", "Highcharts"))
      
          
  )
)))
