#Height and Weight 

# This demo will show how we can predict the future data wit hLinear Regression

#Regression Analysis builds a relationship model bewteen two or more variables 

# The general mathmatical equation for linear regression is 
# y = ax + b 

# y = response variable (value we need to find out using a predictor variable)
# x = predictor variable (value that we know / gather through experiments)
# a = constant (regression coefficient)
# b = constant (regression coefficient)

# In the following example we have two variabels: height and weight. These variables
# have some values and they have a relation. In the below example data: 
# 60kg of weight has 150cm in height, 70kg in wheigh has 160cm in height and so on

# for linear regression anlysis, at first we need to create a relationship model
# between two variabels using the lm() function. After that we use the predict() function to predict value
# The summary of the relation ship can be fetched using the summary() function

height <- c (150, 160, 140, 155, 148, 177, 167, 126, 149, 131)
weight <- c (60, 70, 55, 55, 58, 80, 75, 45, 50, 44)

relation <- lm(weight ~ height)
print(relation)

summary(relation)


#Regression equation:
#  Y = a + bX

#Y = weight in pounds 
#a = intercept at the line 
#b = slope of the line 
#x = height in inches 

#b = describes the best linear relationship between height and weight as defined by ordinary least squares
#Weight = a + b(height) + e 

#Residual Standard Error - – residual that catches the variation in weight for each individual that is not explained by height  
#R-squared is a statistical measure of how close the data are to the fitted regression line.
# 100% indicates that the model explains all the variability of the response data around its mean.


#Now we can insert a new value to height and predict what the weight will be
newValue <- data.frame(height = 170)
print(newValue)
result <- predict(relation, newValue)
print(result)
#The prediction of weight is ~73kg for the height of 170cm

#we can plot the scatter graph of height and weight data
plot(weight, height)

#Set directory to the folder where the hw.data.csv for height and weight is
# use tab complete [TAB] to help set working directory 
setwd("~/")

#Now, we need to read in the CSV in R using read.csv, like this:
#Since the first line of the CSV is the labels, so we pass header=T 
#(T shorthand for TRUE) parameter to skip it. 
hw.data <- read.csv("gender-height-weight.csv", header=T)
hw.data <- as.data.frame(hw.data)

#The data now is a matrix, which you can use dim function to verify:
dim(hw.data)

#show the count by gender 
table(hw.data$Gender)

# histogram plot of Gender and weight in kg
ggplot(data=hw.data) +
  geom_histogram(aes(x=Weight..kg., fill=Gender), position = "dodge")


#Now, we need to separate the data into two sets, 
#the training data set and the verification data set. 
#The common mistake for Big-Data-Mining learners is to use the machine 
#learning algorithm on the data set and make prediction on the 
#same data set, in which normally very good results are obtained.

#we split by odd instances for training data
training <- hw.data[seq(1, nrow(hw.data), 2), ]
#we split here by odd instances for test 
test <- hw.data[seq(2, nrow(hw.data), 2), ]

#each contains half records:
dim(training)
dim(test)

plot(hw.data$Weight, hw.data$Height)

# extract hw.data into variables 
# Now, let’s further extract these data into variables.
#The weight data is located at the fifth column and the height data 
# is located at the fourth column (in R, the index starts at ONE, not zero-based).

training_weight <- training[,5]
training_height <- training[,4]
test_weight <- test[,5]
test_height <- test[,4]

#Now, we can use the lm() to fit the linear model using the following:
fit <- lm(Weight~Height, data = hw.data)

#We are basically constructing the linear model: 
#weight = k * height + b. What we get is:
fit
summary(fit)
#That means the model is: Weight = -350.73719 + (7.71729) x 71 in inches
#so what is next? We can plot the fit vividly.
plot(hw.data$Height, hw.data$Weight, col='black',
abline(fit,col='red'))

# pred_weight = Number * verification_height - number

# mean(pred_weight-verification_weight)
#This plots the points and fit the line:
ggplot(hw.data) +
  aes(x = Height, y = Weight, color = Gender) +
  geom_point() + 
  geom_smooth(method = 'lm', formula = y~x)

hist(hw.data$Height)

box_gender_weight <- ggplot(hw.data, aes(x = Gender, y = Weight)) +
  geom_boxplot()
box_gender_weight

box_gender_height <- ggplot(hw.data, aes(x = Gender, y = Height)) +
  geom_boxplot()
box_gender_height

ggplot(hw.data) +
  aes(x = Height, colour = Gender) +
  geom_freqpoly()


#HOW GOOD IS THE MODEL?
#We can make predictions using the linear model and compare the accuracy:

#-350.73719 + (7.71729) x 71 in inches
pred_weight = -350.73719 * test_height - 158.101

# Hands on Exercise 

#1. subset the MALE data into its own dataframe 

#2. plot a histogram of the height and weight (use either pound or kg for weight and either cm or inches for height)

#3. split the data into training and test with 70% training and 30% test 

#4. run the fit function of weight given height with a linear model

#5. summarize the plot and substitute the values of the regression equation 
#  Y = a + bX 

#6. predict the weight for a height of 121
