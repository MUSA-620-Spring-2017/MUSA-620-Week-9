library(rgeos)
library(maptools)

library(ggplot2)

library(viridis)
#font_import(paths = NULL, recursive = TRUE, prompt = TRUE,pattern = NULL)


income <- read.csv("d:/median-income-1970-2015.csv")

fsas <- readShapeSpatial("d:/philly-census-tract.shp")

data <- fortify(fsas, region = "GISJOIN")
plotData <- left_join(data, income, by=c("id" = "GISJOIN"))

plotData <- mutate(plotData, clean1970 = ifelse(is.na(y1970),0,y1970) )
plotData <- mutate(plotData, clean2015 = ifelse(is.na(y2015),0,y2015) )

map <- ggplot() +
  geom_polygon(data = plotData, aes(x = long, y = lat, group = group,
                                    fill = clean1970), color = "black", size = 0.1) +
  coord_map() # Mercator projection



plotData$incomeBucket1970 <- factor(
  cut(plotData$clean1970, c(-1, 30000, 50000, 80000, 9999999)),
  labels = c("Less than $30k", "$31k to $50k", "$51k to $80k", "More than $80k")
)
plotData$incomeBucket2015 <- factor(
  cut(plotData$clean2015, c(-1, 30000, 50000, 80000, 9999999)),
  labels = c("Less than $30k", "$31k to $50k", "$51k to $80k", "More than $80k")
)



ggplot(data = plotData, aes(x = long, y = lat, group = group,
                            fill = incomeBucket2015) ) +
  # drop shadow: draw another map underneath, shifted and filled in grey
  geom_polygon(aes(x = long + 0.005, y = lat - 0.002), color = "grey50", size = 0.01, fill = "grey50") +
  geom_polygon(color = "grey10", size = 0.01) +
  # set the projection (Mercator in this case)
  coord_map() +
  #set the color scale
  scale_fill_viridis(discrete = TRUE, direction = 1) +
  #scale_fill_brewer(palette="Greens") +
  labs(title = "Philadelphia, 2015",
       subtitle = "Median Income by Census Tract",
       caption = "U.S. Census Bureau, 2015 Decennial Census",
       # remove the caption from the legend
       fill = "Median Income") +
  #set the plot theme
  theme_void() +
  #theme_bw() +
  theme(text = element_text(size = 8),
        plot.title = element_text(size = 12, face = "bold"),
        panel.background = element_rect(fill = "NA", colour = "#cccccc"),
        plot.margin = unit(c(0.25, 0.25, 0.25, 0.25), "in"),
        legend.text = element_text(size = 7),
        legend.position = c(0.8, 0.25))




