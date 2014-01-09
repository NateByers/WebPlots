library(shiny)
if(!require(reshape2)){install.package("reshape2")}
library(reshape2)
library(rCharts)

# Load in data, a data frame named 'dbq.sub'
load("sample_data_sub.rda")

# Add 'month' and 'year' columns
month <- months(dbq.sub[,"sample.date"])
year <- as.numeric(format(dbq.sub[,"sample.date"], "%Y")) 
dbq.sub <- data.frame(month, year, dbq.sub)

# Change 'sample.date' column to class "Date"
dbq.sub[, "sample.date"] <- as.Date(dbq.sub[,"sample.date"])

# Order the data frame by the 'sample.date' column
dbq.sub <- dbq.sub[order(dbq.sub[,"sample.date"]),]

# Add 'date' column as character
date <- as.character(dbq.sub[,"sample.date"])
sbq.sub <- data.frame(date, dbq.sub)

# Reactive function for reshaping the data in wide format
getWideData <- function(){
  # get the data in long format
  long.data <- dbq.sub
  
  # reshape into wide format
  wide.data <- dcast(long.data, site.id + date + site.name ~ compound.name, 
                     value.var="concentration")
  
  return(wide.data)
}


shinyServer(function(input, output, session, clientData) {

  # Time series plot using Morris library from rCharts
  output$timeMorris <- renderChart({
    
    # get the data in wide format
    data <- getWideData()
    
    m1 <- mPlot(x="date", y=colnames(data)[-(1:3)], type = "Line", data = data)
    m1$set(pointSize = 0, lineWidth = 1)
    m1$set(dom = 'timeMorris')
    
    return(m1)
  })
  
  # Time series plot using Highcharts library from rCharts
  output$timeHigh <- renderChart({
    
    # format the date variable 
    dbq.sub$sample.date <- as.numeric(
      as.POSIXct(dbq.sub$sample.date, origin="1970-01-01")
    ) * 1000
    
    h1 = hPlot(concentration ~ sample.date, group = "compound.name", 
               data = dbq.sub, type = "line")
    h1$xAxis(type = "datetime")
    h1$chart(zoomType = "x")
    h1$plotOptions(
      line = list(
        marker = list(enabled = F)
      )
    )
    h1$set(dom="timeHigh")
    
    return(h1)
  })
  
  # Time series plot using the NVD3 library from rCharts
  output$timeNvd3 <- renderChart ({
    
    n1 = nPlot(concentration ~ sample.date, group = "compound.name", 
               data = dbq.sub, type = "lineWithFocusChart")
    n1$xAxis(
      tickFormat=
        "#!function(d) {return d3.time.format('%x')(new Date( d ));}!#"
    )
    n1$x2Axis(
      tickFormat=
        "#!function(d) {return d3.time.format('%x')(new Date( d ));}!#"
    )
    n1$set(dom="timeNvd3")
    
    return(n1)  
    })
  
  # Time series plot using the Rickshaw library from rCharts
  output$timeRickshaw <- renderChart({
    new.date <- as.double(as.POSIXct(dbq.sub[, "sample.date"], origin="1970-01-01"))
    print(new.date[1])
    new.dbq.sub <- data.frame(new.date, dbq.sub)
    print(colnames(new.dbq.sub))
    r1 <- Rickshaw$new()
    r1$layer(
      concentration ~ new.date,
      data = new.dbq.sub,
      groups = "compound.name",
      type = "line"
    )
    r1$set( 
      slider = TRUE, legend = T
    )
    return(r1)
  })
  
  # Box plot using the Highcharts library from rCharts
  output$boxHigh <- renderChart({
    
    bwstats = setNames(as.data.frame(boxplot(concentration ~ month, data = dbq.sub, 
                                             plot = F)$stats), nm = NULL)
    h2 = Highcharts$new()
    h2$set(series = list(list(name = "Toxics Distribution", data = bwstats)))
    h2$xAxis(categories = levels(dbq.sub$month), title = list(text = "Month"))
    h2$yAxis(title = list(text = "Concentration"))
    h2$chart(type = "boxplot")
    h2$set(dom="boxHigh")
    
    return(h2)
  })
  
})
