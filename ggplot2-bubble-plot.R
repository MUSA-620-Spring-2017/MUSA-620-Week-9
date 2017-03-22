library(ggplot2)

agegdp <- read.csv("d:/agegdp.csv")

ggplot(agegdp, aes(x = age, y = debt, label=name)) +
  geom_point(aes(size = pop, colour = regionname, alpha=0)) + 
  geom_text(hjust = 1, size = 2) +
  scale_size(range = c(1,30)) +
  theme_bw()


