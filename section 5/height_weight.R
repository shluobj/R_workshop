#Height and Weight 

#Set directory to the folder where the hw.data.csv for height and weight is 
setwd("~/Desktop/NYC_Data_Science_Academy/github_copy/Section 6_Intro_Regression/")


#Now, we need to read in the CSV in R using read.csv, like this:
#Since the first line of the CSV is the labels, so we pass header=T 
#(T shorthand for TRUE) parameter to skip it. 
hw.data <- read.csv("gender-height-weight.csv", header=T)
hw.data <- as.data.frame(hw.data)

#The data now is a matrix, which you can use dim function to verify:
dim(hw.data)

table(hw.data$Gender)
ggplot(data=hw.data) +
  geom_histogram(aes(x=Weight..kg., fill=Gender), position = "dodge")


#Now, basically, we need to separate the data into two sets, 
#the training data set and the verification data set. 
#The common mistake for Big-Data-Mining learners is to use the machine 
#learning algorithm on the data set and make prediction on the 
#same data set, in which normally very good results are obtained.


training <- hw.data[seq(1, nrow(hw.data), 2), ]
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
plot(hw.data$Height, hw.data$Weight, col='blue',
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

box_gender_weight <- ggplot(hw.data, aes(x = Gender, y = Weight)) +
  geom_boxplot()
box_gender_weight

ggplot(hw.data) +
  aes(x = Height, colour = Gender) +
  geom_freqpoly()

ggplot(hw.data) +
  aes(x = Weight, colour = Gender) +
  geom_freqpoly()


#HOW GOOD IS THE MODEL?
#We can make predictions using the linear model and compare the accuracy:

pred_weight = 1.372 * test_height - 158.101

