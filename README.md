# Week 9: ggplot2

![Japan Population Pyramid](https://blueshift.io/japan-population-pyramid.gif "Japan Population Pyramid")

Japan Population Pyramid, 1990-2050


## Links

[US Census API key](http://api.census.gov/data/key_signup.html) -- [Qatar pyramid example](https://github.com/MUSA-620-Fall-2017/MUSA-620-Week-9/blob/master/qatar-population-pyramid.md) ([code](https://github.com/MUSA-620-Fall-2017/MUSA-620-Week-9/blob/master/qatar-population-pyramid.md)) 

[ggplot2 cheat sheet](https://www.rstudio.com/wp-content/uploads/2016/11/ggplot2-cheatsheet-2.1.pdf)

[Color Brewer](http://colorbrewer2.org/)

Below are three videos I've mentioned in class, all of which I will be touching on next week -- watching them is highly recommended, but not required

[The West Wing: Mercator vs Gall-Peters projection](https://www.youtube.com/watch?v=vVX-PrBRtTY) - A great intro to map projections. This week, [Boston became the first city](http://www.npr.org/sections/thetwo-way/2017/03/21/520938221/boston-students-get-a-glimpse-of-a-whole-new-world-with-different-maps) to introduce the Gall-Peters projection in public schools.

[Hans Rosling: The best stats you've ever seen](https://www.ted.com/talks/hans_rosling_shows_the_best_stats_you_ve_ever_seen) - Outstanding presentation in every respect. See if you can count how many dimensions are visualized in the graphic.

[The Fallen of WWII](http://www.fallen.io/) - "Cinematic" data visualization by Neil Halloran, a fellow Philadelphian. Created using only Javascript.


## Assignment

Create an animated choropleth map that displays the density of crimes across Philadelphia's Census tracts, year-by-year from 2009 to 2016.

This assignment is **required**. You may turn it in by email (galkamaxd at gmail) or in person at class.

**Due:** ~~29-Mar~~ extended to 5-Apr

### Deliverable:

The final deliverable should include:
- the map itself, either as an animated GIF or HTML file
- any code used in the construction of the map
- a written description of the steps you took to create it

### Task:

This assignment is more open-ended than the previous ones. Given all the tools you now have under your belt, you have many options for how you complete the assignment. Several possibilities are suggested below, but if you have a different method, you are welcome to use it.

**Downloads:**
- [Philadelphia Crime Incidents](https://www.opendataphilly.org/dataset/crime-incidents) -- You may ignore any crimes that are missing coordinates. **Edit:** The Philly Open Data site is now showing the links as broken, so I've uploaded the data to Google Drive (download as [csv](https://drive.google.com/open?id=0B3ZNkQw4p_w6QmR6YjVOSWFYQVU) or [geojson](https://drive.google.com/open?id=0B3ZNkQw4p_w6cFc0X0VybTVaS0E))
- [Philadelphia Census Tracts](https://github.com/MUSA-620-Fall-2017/MUSA-620-Week-2)


**1. For each Philly census tract, calculate the number of crimes that occurred there during each year, 2009 to 2016.**

For this step, you have several options.
- You can use QGIS, ArcMap, or PostGIS to join the accident count directly to the Philly-tracts shapefile using a spatial join.
- Alternatively, you can follow the process we used in [step 2 of the accidents assignment](https://github.com/MUSA-620-Fall-2017/MUSA-620-Week-6), using a spatial join to match each crime to a Census tract. In this case, the crime data and the Census tract shapefile can be loaded separately into R, and connected using a left join, as we did in the [ggplot example](https://github.com/MUSA-620-Fall-2017/MUSA-620-Week-9/blob/master/ggplot2-map.R) in class.


**2. Visualize the crime as an animated choropleth**

- You may use ggplot2 or D3 to create the map. Design considerations are up to you and will be factored into the grade. The objective is clear presentation of the spatiotemporal crime trends. A nice looking map is a plus, but it is not the goal.
- Added features (legend, compass, title, labels, dropshadow, etc) are encouraged where appropriate, but remember that more is not necessarily better.

**Tips**

- The crime incidents dataset is very large (> 2m records). Depending on how you go about building the map, the size may not be a problem. But if you are finding it difficult to work with, you may consider using BigQuery or PostGIS as a preprocessing step. You can repeat what we did with the NYC taxi data, using a GROUP BY query to condense the number of line items. Or you can run a query to break the data up into multiple smaller files and remove unneeded columns.
- I would recommend using PostGIS for the spatial join, since it is designed for handling large datasets like this one. If you do decide to use QGIS or ArcMap, you can speed up the query by creating a spatial index on both layers beforehand. In the QGIS menu bar, go to: *Vector > Data Management Tools > Create Spatial Index*. In ArcMap, go to: *ArcToolbox > Data Management Tools > Indexes > Add Spatial Index*.
- To extract the year of the crimes from the date column, this SQL function may come in handy: *LEFT(dispatchdate, 4)*
- If you run into problems getting ImageMagick working, it's actually quite easy to create the animated GIF manually. Save the plots as image files using [ggsave](http://docs.ggplot2.org/0.9.2.1/ggsave.html) and upload them to [ezgif](https://ezgif.com/maker).

### Extra Credit
Extra credit for building a map that shows the crime **month-by-month** (12 months x 8 years = 96 total map frames). This should be done in a systematic way, not by manually copying and pasting the same code 96 times.
