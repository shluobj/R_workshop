#Recall the built-in dataset into R with 
# loading the data into your environment
#
data("mtcars")
?mtcars
#View the data
View(mtcars)
#head the data

head(mtcars)
is.na(mtcars)
summary(mtcars)
nrow(mtcars)
ncol(mtcars)
names(mtcars)
colnames(mtcars)
table(mtcars$am)
hist(mtcars$wt)
hist(mtcars$mpg)
colnames(mtcars)[4]

#find out more about this variable 
help("mtcars")
##dataset that was extracted from the 1974 Motor Trend US magazine
#and comprises fuel consumption and 10 aspects of automobile
#design and performance for 32 automobiles (1973–74 models)


#You'll observed that each line of mtcars
#represents a car model
#what are the column names? 
colnames(mtcars)

#our problem:
# Which transmission type (manual or automatic)
# gets better MPG (miles per gallon)

#EDA - Exploratroy Data Analysis
#Then a mapping of the aesthetics (in this case, transmission 
#on the x-axis and miles per gallon on the y-axis.
#we need to turn am into a factor because ggplot2 prefers the x-axis of a 
#boxplot to be a factor
# the type of graph we are using is a geom_boxplot
library(ggplot2)
ggplot(mtcars, aes(x=factor(am), y=mpg)) + geom_boxplot()


#It appears that manual cars have higher miles per gallon
# and better efficiency 

#Now we want compare the two samples to see if they have
#different means we'll use the t-test
t.test(mpg ~ am, data=mtcars)

#We get a lot of data to intrepret from the t-test
# For the P-value, its very low and we can be confident that 
# there isa difference between the groups
# The %95 confidence interval describes how much lower the miles per 
# gallon is in manual cars than it is in automatic cars
# We can be confident that the true difference is between 3.2 and 11.3 (MPGs)

#Lets assign the t test to its own varible to use it later
tt <- t.test(mpg ~ am, data = mtcars)

# We can also identify certain values 
tt$p.value
tt$conf.int


#Correlation
# Our T-test determined whether a numeric variable differed 
# from the two categories 
#Now we want to see if there is any correlation between the 
# values
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()

#this shows a negative correlation or a higher weight means
# a higher miles per gallon and therfore a lower fuel efficiency
# a heavy car requires more fuel

#the simplest way to test for a relationship between two variabels 
# is with a correlation test and using the cor.test function
cor.test(mtcars$mpg, mtcars$wt)

# The p-value reads as 1.294 times 10 to the power of negative 10 which is very small
# A smaller p-value relates to a more significant correlation

# save the correlation test values
ct <- cor.test(mtcars$mpg, mtcars$wt)
ct$p.value
ct$estimate

#Linear Regression
#Now we want to turn this relationship into a prediciton. 
# Lets say we want to predict what the fuel efficeny of a 4500 pound car is

#we can do this by fitting a linear model or lm function
# saving a model is called fit
fit <- lm(mpg ~ wt, mtcars)
summary(fit)

#we can predict a gas milage for our existing cars
predict(fit)

# we have the MPGs of all cars but what if we wanted to test a 
# new car with a weight of 4500 pounds 

summary(fit)
#We can then add together the intercept term (37.2851) and 
#the weight coefficient (-5.3445) times our new weight, 
#which is 4.5 thousands of pounds:
37.2851 + (-5.3445) * 4.5
#This predicts a fuel efficiency of 13.2 miles per gallon. This is what a linear model actually means: this is 
#a linear combination of the intercept and the slope.

#short cut to adding this the predict funciton
predict_newcar <- data.frame(wt=4.5)
predict(fit, predict_newcar)

#Plot a linear model on our lm 
ggplot(mtcars, aes(wt, mpg)) + geom_point() + geom_smooth(method = "lm")

#identify correlations on all variables
install.packages("ggcorrplot")
library(ggcorrplot)
corr <- round(cor(mtcars), 1)
head(corr[, 1:6])
ggcorrplot(corr,  hc.order = TRUE,outline.col = "white")
ggcorrplot(corr, method = "circle")
ggcorrplot(corr, hc.order = TRUE, type = "lower",
           lab = TRUE)

