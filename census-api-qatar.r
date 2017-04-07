library(idbr) # Census API
library(ggplot2)
library(animation)
library(dplyr)
library(ggthemes)


idb_api_key("your api key") # Request an API key here: http://api.census.gov/data/key_signup.html

qmale <- idb1('QA', 1990:2050, sex = 'male') %>%
  mutate(POP = POP * -1, SEX = 'Male')

qfemale <- idb1('QA', 1990:2050, sex = 'female') %>%
  mutate(SEX = 'Female')

qatar <- rbind(qmale, qfemale)

saveGIF({
  
  for (i in 1990:2050) {
    
    year <- as.character(i)
    
    qatar_data <- filter(qatar, time == i)
    
    yearplot <- ggplot(qatar_data, aes(x = AGE, y = POP, fill = SEX, width = 1)) +
      coord_fixed() + 
      coord_flip() +
      geom_bar(data = subset(qatar_data, SEX == "Female"), stat = "identity") +
      geom_bar(data = subset(qatar_data, SEX == "Male"), stat = "identity") +
      scale_y_continuous(breaks = c(-60000,-40000,-20000,0,20000,40000,60000),
                         labels = paste0(as.character(c(60,40,20,0,20,40,60)), "k"),
                         limits = c(-70000, 70000)) +
      theme_economist(base_size = 15) + 
      scale_fill_manual(values = c('#fe66cb', '#0000fe')) + 
      labs(title = paste("Population Structure of Qatar: ",year), y='Population',x='Age') +
      theme(legend.position = "bottom", legend.title = element_blank()) + 
      guides(fill = guide_legend(reverse = TRUE))
    
    print(yearplot)
    
  }
  
  print(yearplot)
  print(yearplot)
  print(yearplot)
  print(yearplot)
  print(yearplot)
  print(yearplot)
  
}, movie.name = 'qatar-pyramid.gif', interval = 0.1, ani.width = 600, ani.height = 420)

