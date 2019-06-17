data("diamonds")
library(lattice)
?diamonds

factor.color <- as.factor(diamonds$color)
factor.color <- as.numeric(factor.color)
factor.color.df <- as.data.frame(factor.color)

names()

View(factor.color.df)
histogram(factor.color)


# customer vs diamond dealer
# budget is $14k 

# seller - what 3 diamonds would you try to sell to the buyer? 
# buyer - what 3 diamonds would you put on your list to buy? 


#dealers
# dealers code
ggplot(tbl_df(diamonds) %>% mutate(area = x * y) %>% 
         filter(price >= 13000 & price <= 14000)) +
  geom_point(aes(x = area, y = price))

ggplot(tbl_df(diamonds) %>% mutate(area = x * y) %>% 
         filter(price >= 13000 & price <= 14000)) +
  geom_point(aes(x = area, y = price, colour = color)) +
  facet_grid(color~cut)

tbl_df(diamonds) %>% mutate(area = x * y) %>% 
  filter(price >= 13000 & price <= 14000) %>%
  arrange(desc(area)
          

#with this data set what would our approach be? 

install.packages("ggplot2")
# once per computer
library(ggplot2)
# every time you open R
head(diamonds)
str(diamonds)
# Two ways to inspect a data set
# Make sure you type things exactly;

#What can we learn from
#this data?

#Figure out what the variables are from 
http://#www.diamondse.info/ and wikipedia