# Libraries
library(ggplot2)

year <- c(1900,1910,1920,1930,1940,1950,1960,1970,1980,1990)#,2000,2010,2020)
speakers <- c(60,53, 50, 43, 33, 32, 30, 25, 22, 18)#, 16, 8, 2)
DrogekDF <- data.frame(Year=year,Speakers=speakers)

# Plot
ggplot(DrogekDF, aes(x= Year, y=Speakers)) +
  ylab("Speaker percentage") +
  ylim(c(0,100)) +
  xlim(c(1910,2025)) +
  scale_x_continuous(breaks = seq(1910, 2025, by = 20)) +
  theme(
    axis.title = element_text(size = 16),
    axis.text = element_text(size = 12),
  ) +
  geom_line(color="red")
