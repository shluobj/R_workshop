library(Rblpapi)
library(ggplot2)
library(Hmisc)
install.packages("Hmisc")
library(DMwR)
install.packages("DMwR")
library(shiny)
install.packages("rpart")
library(rpart)
install.packages("RGtk2")
library(RGtk2)


install.packages("rattle")
library(rattle)


library(rpart.plot)
install.packages("rpart.plot")
library(RColorBrewer)
install.packages("RColorBrewer")
library(randomForest)
install.packages("randomForest")
library(party)
install.packages("party")


#prediction and titanic example
#In this competition, you must predict the fate of the passengers aboard the RMS Titanic
#Did the theory of "women and children first" actually happen on the Titanic ?
#https://www.kaggle.com/c/titanic/data?train.csv


#set working diriectory for where titanic files training and test sets are stored 
setwd("~/Downloads/")

# By default R imports all text strings as factors but we dont want all of them as factors right now  
train <- read.csv("train.csv", stringsAsFactors=FALSE)
test <- read.csv("test.csv", stringsAsFactors=FALSE)

#find the structure of the import
str(train)
str(test)

dim(train)
dim(test)

names(train)
names(test)

#isolate survivors [1 is survived]
table(train$Survived)

#proportion of survivors 
prop.table(table(train$Survived))

#everyone dies prediction only 418 rows in the test set
nrow(test)
test$Survived <- rep(0, 418)

library(Amelia)
missmap(train)


#everyone dies prediction 
test$Survived <- rep(0, 418)

#submit a csv file with the PassengerId as well as our Surived predictions
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "theyallperish.csv", row.names = FALSE)

#dplyr explore the data
library(dplyr)

#filter on female and create new dataframe "females"
#filter() allows you to select a subset of rows in a data frame. The first argument is the name of the data frame. 
#The second and subsequent arguments are the expressions that filter the data frame
females <- filter(train, Sex == "female")

#select first 5 rows using slice
slice5 <- slice(train, 1:5)
slice5

#arrange passengers by fare price (acending order)
fare_arranged <- arrange(train, Fare)
View(fare_arranged)

#arrange by descending order 
fare_desc <- arrange(train, desc(Fare))

#get distinct Pclass types
distinct(train, Pclass)


# avearge Pclass of all the passengers
summarise(train, average.class = mean(Pclass, na.rm=TRUE))

# max price for a fare
summarise(train, max_fare = max(Fare, na.rm=TRUE))

# max age
summarise(train, max_age = max(Age, na.rm=TRUE))

#disaster was famous for saving "women and children first"
summary(train$Sex)

#proportion of sex and survivors 1 is survived 
#we need to tell the command to give us proportions in the 1st dimension which stands for the rows 
prop.table(table(train$Sex, train$Survived),1)

#update our prediction to all females suriving 
test$Survived <- 0 
test$Survived[test$Sex == 'female'] <- 1 

#now on to test to see if all the children survived as well 
summary(train$Age)

#label the children with a binary of 0 not child and 1 as child 
train$Child <- 0
train$Child[train$Age < 18] <- 1

summary(train$Child)

#find the number of survivors for the different subsets 
#The aggregate command takes a formula with the target variable on the left hand side 
# of the tilde symbol and the variables to subset over on the right
aggregate(Survived ~ Child + Sex, data=train, FUN=sum)

#total number of people in each subset
#length of the Survived vector for each subset and output the result
aggregate(Survived ~ Child + Sex, data=train, FUN=length)

#We need to create a function that takes the subset vector as input and applies 
#both the sum and length commands to it, and then does the division to give us a proportion
aggregate(Survived ~ Child + Sex, data=train, FUN=function(x) {sum(x)/length(x)})

#another feature variable is costs of ticket 
# we'll bin the fares 
summary(train$Fare)
train$Fare2 <- '30+'
train$Fare2[train$Fare < 30 & train$Fare >= 20] <- '20-30' 
train$Fare2[train$Fare < 20 & train$Fare >= 10] <- '10-20'
train$Fare2[train$Fare < 10] <- '<10'

#longer aggregate function to see if there's anything interesting to work with here
aggregate(Survived ~ Fare2 + Pclass + Sex, data=train, FUN=function(x) {sum(x)/length(x)})

#While the majority of males, regardless of class or fare still don't do so well, we notice that most of the 
#class 3 women who paid more than $20 for their ticket actually also miss out on a lifeboat
#It's a little hard to imagine why someone in third class with an expensive ticket would be worse off in the accident, 
#but perhaps those more expensive cabins were located close to the iceberg impact site, or further from exit stairs

test$Survived <- 0 
test$Survived[test$Sex == 'female'] <- 1
test$Survived[test$Sex == 'female' & test$Pclass == 3 & test$Fare >= 20] <- 0


#decsion trees 


#rpart command works similarly to the aggregate function 
#You feed it the equation, headed up by the variable of interest 
#and followed by the variables used for prediction

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked,
             data=train,
             method="class")

summary(fit)
#boring but plot of the decision tree
plot(fit)
text(fit)
library(rpart)
library(rpart.plot)
rpart.plot(fit)

#new and exciting packages to make this plot pop

#library(party)

#fancyRpartPlot(fit)

#new prediction with decision tree @ 78%
Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
View(submit)
#write.csv(submit, file = "myfirstdtree.csv", row.names = FALSE)

#feature engineering 
# definition of feature engineering is to chop, 
#and combine different attributes that we were given to squeeze a little bit more value from them
setwd("~/Downloads/")

train <- read.csv("train.csv")
test <- read.csv("test.csv")



#See if name field could be a viable feature
train$Name[1]
#we see that there are titles for the people, "Master" and "Countess" 

#extract the titles of people to make new variables 

#remove Surivived from test to have equal number of columns 
test$Survived <- NA


#combine train and test set for feature engineering 
combi <- rbind(train, test)
#test$Survived <- NA
#train$Survived <- NA
#new dataframe called "combi" with all the same rows as the original two datasets
#stacked in the order in which we specified: train first, and test second.

#change name field to a character 
combi$Name <- as.character(combi$Name)
combi$Name[1]

#break apart title from persons name
strsplit(combi$Name[1], split='[,.]')

#^Those symbols in the square brackets are called regular expressions
#isolate the title 
strsplit(combi$Name[1], split='[,.]')[[1]][2]

#We feed sapply our vector of names and our function that we just came up with. 
#It runs through the rows of the vector of names, and sends each name to the function
combi$Title <- sapply(combi$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][2]})
View(combi)
# strip off those spaces from the beginning of the titles
combi$Title <- sub(' ', '', combi$Title)

#view the titles of everyone 
table(combi$Title)

#Mademoiselle and Madame are pretty similar (so long as you don't mind offending) so let's combine them into a single category
combi$Title[combi$Title %in% c('Mme', 'Mlle')] <- 'Mlle'

#%in% operator checks to see if a value is part of the vector we're comparing it to. 
#So here we are combining two titles, "Mme" and "Mlle", 
#into a new temporary vector using the c() operator and seeing if any of the existing titles 
#in the entire Title column match either of them. We then replace any match with "Mlle"

#reducing the outliers to more simple titles
combi$Title[combi$Title %in% c('Capt', 'Don', 'Major', 'Sir')] <- 'Sir'
combi$Title[combi$Title %in% c('Dona', 'Lady', 'the Countess', 'Jonkheer')] <- 'Lady'

#change the variable back to a factor
combi$Title <- factor(combi$Title)

#two variables SibSb and Parch that indicate the number of family members the passenger is travelling with
combi$FamilySize <- combi$SibSp + combi$Parch + 1

#Pretty simple! We just add the number of siblings, spouses, parents and children the passenger had with them, 
#and plus one for their own existence of course, 
#and have a new variable indicating the size of the family they travelled with.

#ensure the families with the same naems are combined together correctly 
combi$Surname <- sapply(combi$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][1]})

#convert the FamilySize variable temporarily to a string and combine it with the Surname to get our new FamilyID variable
combi$FamilyID <- paste(as.character(combi$FamilySize), combi$Surname, sep="")

#the new family groups test
table(combi$FamilyID)


#Perhaps some families had different last names, but whatever the case, all these one or two people groups is what we sought to avoid with the three person cut-off. 
#clean this up
famIDs <- data.frame(table(combi$FamilyID))

#subset this dataframe to show only those unexpectedly small FamilyID groups
famIDs <- famIDs[famIDs$Freq <= 2,]

#We then need to overwrite any family IDs in our dataset for groups that were not correctly identified and finally convert it to a factor
combi$FamilyID[combi$FamilyID %in% famIDs$Var1] <- 'Small'
combi$FamilyID <- factor(combi$FamilyID)

#break apart the comi dataframe into train and test sets again
train <- combi[1:891,]
test <- combi[892:1309,]

#new decision tree with newly engineering features
library(party)
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize + FamilyID,
             data=train, method="class")
#fancyRpartPlot(fit)
rpart.plot(fit)

Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, "guess.csv")
#part 5 randon forests
# Set working directory and import datafiles

train <- read.csv("train.csv")
test <- read.csv("test.csv")

# Install and load required packages for decision trees and forests
library(randomForest)

# Join together the test and train sets for easier feature engineering
test$Survived <- NA
combi <- rbind(train, test)

# Convert to a string
combi$Name <- as.character(combi$Name)

# Engineered variable: Title
combi$Title <- sapply(combi$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][2]})
combi$Title <- sub(' ', '', combi$Title)
# Combine small title groups
combi$Title[combi$Title %in% c('Mme', 'Mlle')] <- 'Mlle'
combi$Title[combi$Title %in% c('Capt', 'Don', 'Major', 'Sir')] <- 'Sir'
combi$Title[combi$Title %in% c('Dona', 'Lady', 'the Countess', 'Jonkheer')] <- 'Lady'
# Convert to a factor
combi$Title <- factor(combi$Title)

# Engineered variable: Family size
combi$FamilySize <- combi$SibSp + combi$Parch + 1

# Engineered variable: Family
combi$Surname <- sapply(combi$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][1]})
combi$FamilyID <- paste(as.character(combi$FamilySize), combi$Surname, sep="")
combi$FamilyID[combi$FamilySize <= 2] <- 'Small'

# Delete erroneous family IDs
famIDs <- data.frame(table(combi$FamilyID))
famIDs <- famIDs[famIDs$Freq <= 2,]
combi$FamilyID[combi$FamilyID %in% famIDs$Var1] <- 'Small'

# Convert to a factor
combi$FamilyID <- factor(combi$FamilyID)

# Fill in Age NAs
summary(combi$Age)
Agefit <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + FamilySize, 
                data=combi[!is.na(combi$Age),], method="anova")
combi$Age[is.na(combi$Age)] <- predict(Agefit, combi[is.na(combi$Age),])

# Check what else might be missing
summary(combi)
# Fill in Embarked blanks
summary(combi$Embarked)
which(combi$Embarked == '')
combi$Embarked[c(62,830)] = "S"
combi$Embarked <- factor(combi$Embarked)


# Fill in Fare NAs
summary(combi$Fare)
which(is.na(combi$Fare))
combi$Fare[1044] <- median(combi$Fare, na.rm=TRUE)

# New factor. only allowed <32 levels, so reduce number
combi$FamilyID2 <- combi$FamilyID
# Convert back to string
combi$FamilyID2 <- as.character(combi$FamilyID2)
combi$FamilyID2[combi$FamilySize <= 3] <- 'Small'
# And convert back to factor
combi$FamilyID2 <- factor(combi$FamilyID2)

# Split back into test and train sets
train <- combi[1:891,]
test <- combi[892:1309,]

# Build Random Forest Ensemble
set.seed(1234)
fit <- randomForest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + 
                      Embarked + Title + FamilySize + FamilyID2,
                    data=train, importance=TRUE, ntree=2000)

# Look at variable importance
varImpPlot(fit)


# Now let's make a prediction and write a submission file
Prediction <- predict(fit, test)
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)

write.csv(submit, file = "firstforest.csv", row.names = FALSE)



# Build condition inference tree Random Forest
set.seed(1234)
fit <- cforest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize + FamilyID,
               data = train, controls=cforest_unbiased(ntree=2000, mtry=3)) 
# Now let's make a prediction and write a submission file
Prediction <- predict(fit, test, OOB=TRUE, type = "response")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)

write.csv(submit, file = "ciforest.csv", row.names = FALSE)
