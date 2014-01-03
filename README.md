WebPlots
========================================================

This is a Shiny app with 4 plots using the `rCharts` package and example environmental data. It requires the installation of `rCharts` from GitHub using the `devtools` package

```
require(devtools)
install_github('rCharts', 'ramnathv')
```

Time Series: Morris
-------------------------------------------------------

This plot displays a popup when you move the cursor over the line.

Time Series: Highcharts
------------------------------------------------------

This plot also displays a popup when moving the cursor over the line, as well as removing and adding data by clicking on the pollutant name at the bottom of the plot.

Time Series: NVD3
------------------------------------------------------

Has popup displays, adds and removes data, and zooms in on time period (click and drag cursor on bottom panel).

Box Plot: Highcharts
------------------------------------------------------

Box plot with popups.


