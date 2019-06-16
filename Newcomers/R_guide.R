#Guide 

library(ggplot2)
install.packages("ggplot2")
#For any documentation or usage of the function in R Studio, just type the name of the function and then press cntrl+space to get the auto completion window.
#You can use "?" before any function name to view the official documentation

#‘>’ – indicates that this is where to type the input. 
#This starts the beginning of the input and is not meant to be added. Enter commands after the ‘>’

#From the “Console” (lower left quadrant of RStudio) 
#We can begin using R as a simple calculator.
#Example: 
1+1
#‘[1]’ - is the indicator of the index of the first line 

#	Comparisons & Boolean & NA
1 != 1 
#[1] FALSE
#^asking if 1 is not equal to 1. R identified it to be a FALSE Boolean statement 
#Evaluate a statement 
Average.Age <- 41
My.Age <- 34
(Average.Age >= 10)
(My.Age <= 32)
Average.Age >= 10 & My.Age >= 10 

#We can combine statements to get a Boolean answer back as well 
#ORDER OF OPERATIONS – PEMDAS () ^ * / + - 
(1+2) * 10 
#The answer is 30 because R follows the order of operations where it takes the 1+2 
#first which is in the parenthesis and then multiples the result times 10 to give an answer of 30
10 / 2 * 6  


#Exercise 1 from slides

# Creating variables.
#One of the most important things to be able to do in any programming language
#is store information in variables.
#You can think of variables as a label for one or more pieces of information.
#When doing statistical analysis in R all of your data (the variables you measured
#in your study) will be stored as variables in R. You can also create variables for
#other things too, which we will learn later on in the course.

#Try the example below. In this example, for a single product, we’ve created two
#variables cost and price and assigned them values. We then computed profit by
#taking the difference of price and cost and assigned the result to the variable
#profit. Then we printed out the result of profit

cost <- 9.60
price <- 12
profit <- price - cost
profit

#Now, let's assume you sold 82,342 units. Let’s compute your profit.
units <- 82342
units * profit

#our variables can be
#assigned to values that contain numbers, words, a mix of letters and numbers,
#Boolean values and much more.

instock <- FALSE
inventory <- 0
productid <- "9882avcde32"

class(productid)
#Try the other variabeles for their class type

#create a vector
apple <- c('red','green', 'yellow')
print(apple)

#A list is an R-object which can contain many different 
#types of elements inside it like vectors, functions and even another list inside it

list1 <- list(1,2,3,'Brennan')
print(list1)
list1[4]

# Create a matrix.
#Matrices are two-dimensional structures addresses by rows and columns

M = matrix( c('a','a','b','c','b','a'), nrow = 2, ncol = 3, byrow = TRUE)
print(M)


# Create a vector
crayons <- c('red', 'blue', 'green', 'yellow', 
             'orange', 'violet', 'brown', 'black', 
             'red','red','yellow','brown','orange','blue')

# create a factor object
factor_crayons <- factor(crayons)

#print the factor
print(factor_crayons)
print(nlevels(factor_crayons))

# Create an array 
#While matrices are confined to two dimensions, 
#arrays can be of any number of dimensions.
array1 <- array(c('red','orange','yellow'), dim = c(3,3,2))
print(array1)

# Create the data frame 
#R’s central data structure is called the data frame. 
#A data frame is organized into rows and columns. 
#A data frame is a list of columns of different types
demographics <- data.frame(
  gender = c('M', 'F','F'),
  height = c(172, 121, 111),
  weight = c(175, 124, 111), 
  Age = c(23, 24, 25)
)

print(demographics)
View(demographics)



#R commands and functions
# Use the data.frame() function to create new data frame
# Use the $ operator to extract the variable you are interested in from a data
#frame.Using the $ operator
#If you only want to extract one column of your data frame you can use the $
#operator. Example demographics$Age
# Use the View() function to view a data frame in RStudio
# Use the names() function to list the names of the variables in your data
#frame
# The dim() function displays the dimensions of an object or data frame. It
#can also be used to set the dimensions.
# use the brackets and dataframe access the 1st instance of the weight column 
# example demographics[1,3]
# as.factor() converts a variable of a different data type (e.g. numeric,
                                                            #character) to a variable of type factor.
#class() function describes the data type
#To create vector, use the combine function called c(). Then pass the values you
#want to store in the vector to the c() function, separated by commas. 

#1. Importing Data in R Studio For this tutorial we will use the sample census data set ACS . 
#There are two ways to import this data in R. One way is to import the data programmatically 
#by executing the following command in the console window of R Studio 


#download the data 
acs <- read.csv(url("http://stat511.cwick.co.nz/homeworks/acs_or.csv"))
#Once this command is executed by pressing Enter, 
#the dataset will be downloaded from the internet, read as a csv file and assigned to the variable name
#acs.

#ensure acs is a datafram 
acs <- as.data.frame(acs)

names(acs)
dim(acs)
acs[1, "age_wife"]
#transform the data

#access a particular column
acs$age_husband

#access data as a vector
#1st row column 3 
acs[1,3]

#subset
#create new factor a of acs data where age of husband is greater than age of wife
a <- subset(acs, age_husband > age_wife)
View(a)

#The first parameter to the subset function is the dataframe you want to apply that function to and
#the second parameter is the boolean condition that needs to be checked for each 
#row to be included or not. So the above statement will return the set the rows in which the 
#age_husband is greater than age_wife and assign those rows to acs

#Exercise 2

# Our data packages to include 
library(hflights) #A data frame with 227,496 rows and 21 columns.

# getting help
?hflights 
View(hflights)
head(hflights, n = 3L) #Return the First 3 lines 
str(hflights) #Compactly Display the Structure of an Arbitrary R Object
dim(hflights) #Dimensions of an Object (# of observations | # of values 
summary(hflights) #summary is a generic function used to produce result summaries of the results of various 
nrow(hflights) #count of number of rows 

hflights <- as.data.frame(hflights)

#Functions
#¥  Min - minimum value min()
#¥  Max - maximum value max()
#¥	Mean – average - mean()
#¥	Median – middle value – median()
#¥	Mode – most common value – mode()
#¥	Range – difference between the largest and the smallest value – range()
#¥	Variance – numerical measure of how the data values are dispersed around the mean. The average of the squared distances from the mean – var()
#¥	Standard deviation – a measure of how spread out the numbers are - sd()

#check for NA's
sapply(hflights, function(x) sum(is.na(x)))


#Tidying
library(dplyr)
# The subset() function is an easy way to select particular rows and columns based on criteria. The
#function is organized as follows: #subset(x =, subset =, select =)
# x is the data frame you want to subset
# A vector of logical values indicating which observations (rows) of the
# data frame you want to keep. By default all rows will be retained.

#select. Indicates the variables (columns) you want to keep. By default all
#columns will be retained
acs_subset <- subset(x = acs, subset = age_husband == 34, select = c(household, number_children))
acs_subset

#filter()  - pick observations by their values. Notice that filter will bring back all columns
filter(acs, acs$bedrooms == 1)

#Arrange
# arrange() works similary to filter() excep that instaed of selecting rows it changes their order
arrange(acs, age_husband, age_wife, income_husband, income_wife)

#Mutate() – create new  variables with functions of existing varables 
# mutate always adds new columns at the end of your dataset
acs <- mutate(acs, household_income = income_husband + income_wife)

#summarize() collapses a data frame to a single row
summarize(acs, median(household_income))

# group_by() – changes the scope of each function from operating on the entire data set to operating on it group-by-group 
internet <- group_by(acs, internet)
summarize(internet, count = n())

#min
min(hflights$Distance)
#max
max(hflights$Distance)
# mean Distance
mean(hflights$Distance)
# median distance
median(hflights$Distance)
#MODE 
mode(hflights$Distance)
#rangeof Months
range(hflights$Month)
#variance
var(hflights$DayOfWeek)
#standard deviation
sd(hflights$Distance)

#Exercise 3 - UN Data


#Data Viz 
#using table to create your charts and x, y axis is important, simple and powerful 
internet_plot <- table(acs$internet)
table(acs$internet)
barplot(internet_plot)

#mtcars plotting
?mtcars
attach(mtcars)
head(mtcars)
names(mtcars)
summary(mtcars)

table(mtcars$gear)
gear_count <- table(mtcars$gear)
barplot(gear_count, main="Car Distribution", xlab="number of gears")

#piechart
pie(table(mtcars$cyl))

#histogram
hist(mtcars$mpg)
names(mtcars)

#boxplot
boxplot(mtcars$mpg)

#timeseries
library(quantmod)
getSymbols("GOOGL", src="yahoo")
GOOGL.2018 <- GOOGL['2018-01-01::2018-12-31']
barChart(GOOGL)
barChart(GOOGL, subset = "last 3 months")

library(ggplot2)
qplot(GOOGL.Open, GOOGL.Close, data = GOOGL.2018, geom = "point")

#scatter plot 2 
qplot(GOOGL.Open, GOOGL.Close, data = GOOGL.2018, geom = "smooth")

#scatter plot 3 
qplot(GOOGL.Open, GOOGL.Close, data = GOOGL.2018, geom = c("point","smooth"))

#Bubble Chart
ggplot(data=GOOGL.2018, aes(x=GOOGL.Open, y=GOOGL.Close)) +  geom_point(aes(size=GOOGL.Volume)) +  theme(legend.position = "none")

#TREEMAP
library(treemap)
data(GNI2014)
treemap(GNI2014,
        index=c("continent", "iso3"),
        vSize="population",
        vColor="GNI",
        type="value",
        format.legend = list(scientific = FALSE, big.mark = " "))

#R pivot table
library(rpivotTable)
rpivotTable(hflights)

  #plot 
s <- acs[1:100,]
plot(x = s$age_husband , y = s$age_wife, type = 'p')

#hist
hist(acs$number_children)

#bar plots
counts <- table(acs$bedrooms) 
barplot(counts, main="Bedrooms Distribution", xlab="Number of Bedrooms")
