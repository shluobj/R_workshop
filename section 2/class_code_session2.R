library(quantmod)
getSymbols("GOOGL", src="yahoo")
GOOGL.df <- as.data.frame(GOOGL)
GOOGL.df[1:2]
GOOGL.df$GOOGL.Open <- NULL
names(GOOGL.df)
library(dplyr)
summary(GOOGL.df)

setwd("Desktop/")
write.csv(GOOGL.df, file = "google.csv")
google.import <- read.csv("google.csv", na= "NA")
google.import.df <- as.data.frame(google.import)




require(dplyr)
library(dplyr)
colnames(GOOGL.df)

google.df.250 <- filter(GOOGL.df, GOOGL.Open > 250)
google.df.250
str(GOOGL.df$GOOGL.Open)

Google.Open <- GOOGL.df$GOOGL.Open
Google.Open.df <- as.data.frame(Google.Open)
colnames(Google.Open.df)
colnames(GOOGL.df)
Google.Open.df.250 <- filter(Google.Open.df, 
                             Google.Open.df$Google.Open > 250)
View(Google.Open.df.250)
mean(GOOGL.df$GOOGL.Open)
max(GOOGL.df$GOOGL.Open)
min(GOOGL.df$GOOGL.Open)
mode(GOOGL.df$GOOGL.Open)
range(GOOGL.df$GOOGL.Open)

#assignment 1 
columns.three <- subset(GOOGL.df, 
                        select=c(GOOGL.High, GOOGL.Low, GOOGL.Close))
columns.three.df <- as.data.frame(columns.three) 
getwd()
write.csv(columns.three, "columns_three.csv")
import.three.csv <- read.csv("columns_three.csv")
import.three.csv <- as.data.frame(import.three.csv)

colnames(import.three.csv)
import.three.csv$GOOGL.Close <- NULL

colnames(import.three.csv)

#Exercise 2 Hint to select dates 
getSymbols("GOOGL", src='google', from = as.Date("2017-08-01"), to = as.Date("2017-09-01"))

getSymbols("GOOGL", src='google')
GOOGL.df <- as.data.frame(GOOGL)
dates <- names("GOOGL")[0]

