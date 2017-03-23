# Week 9: ggplot2

![Japan Population Pyramid](https://blueshift.io/japan-population-pyramid.gif "Japan Population Pyramid")

Japan Population Pyramid, 1990-2050


## Links

[US Census API key](http://api.census.gov/data/key_signup.html)

[ggplot2 cheat sheet](https://www.rstudio.com/wp-content/uploads/2016/11/ggplot2-cheatsheet-2.1.pdf)

[Color Brewer](http://colorbrewer2.org/)

## Assignment

Create an animated choropleth map that displays the density of crimes across Philadelphia's Census tracts, year-by-year from 2009 to 2016.

This assignment is **required**. You may turn it in by email (galkamaxd at gmail) or in person at class.

**Due:** 29-Mar

### Deliverable:

The final deliverable should include:
- the map itself, either as an animated GIF or HTML file
- any code used in the construction of the map
- a written description of the steps you took to create it

### Task:

This assignment is more open-ended than the previous ones. Given all the tools you now have under your belt, you have many options for how you complete each step. Several possibilities are suggested below, but if you have a different method, you are welcome to use it.

**Downloads:**
- [Philadelphia Crime Incidents](https://www.opendataphilly.org/dataset/crime-incidents) (you may ignore any crimes that are missing coordinates)
- [Philadelphia Census Tracts](https://github.com/MUSA-620-Fall-2017/MUSA-620-Week-2)


**1. For each Philly census tract, calculate the number of crimes that occurred there during each year, 2009 to 2016.**
For this step, you have many options.
- You can use QGIS, ArcGis, or PostGIS to join the accident count directly to the Philly-tracts shapefile using a spatial join.
- Alternatively, you can follow the process we used in [step 2 of the accidents assignment](https://github.com/MUSA-620-Fall-2017/MUSA-620-Week-6), using a spatial join to match each crime to a Census tract. In this case, the crime data and the Census tract shapefile can be loaded separately into R, and connected using a left join, as we did in the [ggplot example](https://github.com/MUSA-620-Fall-2017/MUSA-620-Week-9/blob/master/ggplot2-map.R) in class.
- Regardless of the method you choose, you are welcome to use BigQuery to make the crime data more compact and easier to work with, as we did with the NYC taxi data.

**2. Visualize the crime as an animated choropleth**
You may create this map using either ggplot2 or D3. Design considerations are up to you and will be factored into the grade. The objective is clear presentation of the spatiotemporal crime trends. A nice looking map is a plus, but it is not the goal.

Added features (legend, compass, title, labels, dropshadow, etc) are encouraged where appropriate, but remember that more is not necessarily better.

### Extra Credit
Extra credit for building a map that shows the crime **month-by-month** (12 months x 8 years = 96 total map frames). This should be done in a systematic way, not by manually copying and pasting the same code 96 times.
