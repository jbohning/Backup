library(reshape2)
library(UsingR)
library(ggplot2)
data(galton)

mydata <- melt(galton)

names(mydata) <- c('group', 'size')

ggplot(mydata, aes(x = size, col = group)) +
        
        geom_density(alpha = 0.5, adjust=2) +
        
        scale_colour_manual(values = c("green","gray"))

ggplot(mydata, aes(x = size, fill = group)) +
        
        geom_density(alpha = 0.5, adjust=2) +
        
        scale_fill_manual(values = c("green","gray"))