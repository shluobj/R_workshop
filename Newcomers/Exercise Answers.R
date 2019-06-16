# Exercise 2 answers
# import the UN data csv file 
UN.data <- read.csv("Desktop/workshops/Predictive Analytics World/Newcomers/UN_gdp_data.csv")

UN.data <- as.data.frame(UN.data)
dim(UN.data)
colnames(UN.data)
class(UN.data$continent)
UN.data[1,2]

#Exercise 3 Answers
max(UN.data$pop)
subset(UN.data, pop == 1318683096)

min(UN.data$lifeExp)
subset(UN.data, lifeExp == 23.599)

tail(arrange(UN.data, pop, continent))

summary(UN.data)
