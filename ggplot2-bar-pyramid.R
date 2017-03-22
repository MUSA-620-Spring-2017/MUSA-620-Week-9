library(ggplot2)
library(animation)
library(dplyr)
library(ggthemes)

## Themes
# https://cran.r-project.org/web/packages/ggthemes/vignettes/ggthemes.html
#   theme_fivethirtyeight(), theme_few(), theme_wsj(), theme_tufte(), 
   



japanData <- read.csv("d:/japan-age.csv")


# ***Bar Chart***

yeardata <- filter(japanData, time == 2010)
femaleonly = subset(yeardata, SEX == "Female")

ggplot(data=femaleonly, aes(x = AGE, y = POP)) +
  geom_bar(colour="black", stat="identity", position = "stack", fill="orange") +
  guides(fill=FALSE)


# ***Stacked Bar***

yeardata <- filter(japanData, time == 2010)

ggplot(data=yeardata, aes(x = AGE, y = POP, fill = SEX )) +
  geom_bar(colour="black", stat="identity", position = "stack") +
  scale_fill_manual(values = c('#fe66cb', '#0000fe')) + 
  guides(fill=FALSE)


# ***Population Pyramid***

japanAgePop <- mutate(japanData, POP = ifelse(SEX == 'Male', POP * -1, POP)) # make male ages negative

year_data <- filter(japanAgePop, time == 2010)

ggplot(year_data, aes(x = AGE, y = POP, fill = SEX, width = 1)) +
  coord_fixed() + 
  coord_flip() +
  geom_bar(data = subset(year_data, SEX == "Female"), stat = "identity") +
  geom_bar(data = subset(year_data, SEX == "Male"), stat = "identity") +
  scale_y_continuous(breaks = seq(-1000000, 1000000, 500000), # from -1m to 1m, counting by 500k
                     labels = paste0(as.character(c(1, 0.5, 0, 0.5, 1)), "m"),
                     limits = c(-1200000, 1200000)) +
  theme_economist(base_size = 14) + 
  #theme_hc() +
  scale_fill_manual(values = c('#fe66cb', '#0000fe')) + 
  labs(title = "Population structure of Japan", y='Population',x='Age') +
  theme(legend.position = "bottom", legend.title = element_blank()) + 
  guides(fill = guide_legend(reverse = TRUE))


# ***Animated Population Pyramid***

saveGIF({
  
  for (i in 2010:2050) {
    
    year <- as.character(i)
    
    year_data <- filter(japanAgePop, time == i)
    
    yearplot <- ggplot(year_data, aes(x = AGE, y = POP, fill = SEX, width = 1)) +
      coord_fixed() + 
      coord_flip() +
      geom_bar(data = subset(year_data, SEX == "Female"), stat = "identity") +
      geom_bar(data = subset(year_data, SEX == "Male"), stat = "identity") +
      scale_y_continuous(breaks = seq(-1000000, 1000000, 500000), # from -1m to 1m, counting by 500k
                         labels = paste0(as.character(c(1, 0.5, 0, 0.5, 1)), "m"),
                         limits = c(-1200000, 1200000)) +
      theme_economist(base_size = 14) + 
      scale_fill_manual(values = c('#fe66cb', '#0000fe')) + 
      labs(title = paste("Population structure of Japan: ",year), y='Population',x='Age') +
      theme(legend.position = "bottom", legend.title = element_blank()) + 
      guides(fill = guide_legend(reverse = TRUE))
    
    print(yearplot)
    
  }
  
}, movie.name = 'japan-pop-pyramid.gif', interval = 0.2, ani.width = 700, ani.height = 600)
  
  