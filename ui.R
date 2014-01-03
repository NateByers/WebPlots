library(shiny)
library(rCharts)


 
shinyUI(pageWithSidebar(
  
  
  
  headerPanel("rCharts for Web"),
  
  
  sidebarPanel(

  ),
  
  mainPanel(
    
    tabsetPanel(
      tabPanel("Time Series: Morris", showOutput("timeMorris", "morris")),
      tabPanel("Time Series: Highcharts", showOutput("timeHigh", "Highcharts")),
      tabPanel("Time Series: NVD3", showOutput("timeNvd3", "nvd3")),
      tabPanel("Box Plot: Highcharts", showOutput("boxHigh", "Highcharts"))
      
          
  )
)))
