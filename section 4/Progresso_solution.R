library(coefplot)
library(ggplot2)

setwd("~/Desktop/NYC_Data_Science_Academy/github_copy/Section 6_Intro_Regression/")
PS<-read.csv(file="Progresso_Soup.csv", header=TRUE, sep=",")


#check out the data


# Create Dummy Variables for Winter Months
PS$Winter <- PS$Month_Jan_Dec 
PS$Winter<- ifelse(PS$Winter > 2 & PS$Winter < 10, c("notwinter"), c("winter"))

#identify income levels 
PS$Incomelvl <- ifelse(PS$High_Income > 0, c("highincome"), c("lowincome"))

# market share of Progresso for each store-month
PS$progmk <- PS$sales_prog / PS$Category_sales

# Box plots of market shares across all stores
ggplot(PS, aes(x=Winter, y=progmk, fill=Winter))+geom_boxplot ()

ggplot(PS, aes(x=Region, y=progmk, fill=Winter))+geom_boxplot ()


# Aggregate sales to get market shares 
cat<-aggregate(Category_sales~Winter, data=PS, FUN=sum)
prog1<-aggregate(sales_prog~Winter, data=PS, FUN=sum)
prog_sales<-prog1[,2]
agshare<-cbind(cat,prog_sales)
agshare$progmk <- agshare$prog_sales / agshare$Category_sales
agshare




# Linear Regression with just prices
reg1 <- lm(Log_sales.Progresso~Log_Price.Progresso+Log_Price.Campbell +Log_Price.PL, data=PS)
summary(reg1)
library(coefplot)
coefplot(reg1)


# Add control for Seasonality
reg2 <- lm(Log_sales.Progresso~Log_Price.Progresso+Log_Price.Campbell +Log_Price.PL+Winter, data=PS)
summary(reg2)
coefplot(reg2)



# Add control for REGIONS
reg3 <- lm(Log_sales.Progresso~Log_Price.Progresso+Log_Price.Campbell +Log_Price.PL+Winter+Region, data=PS)
summary(reg3)
coefplot(reg3)



# Add income
reg4 <- lm(Log_sales.Progresso~Log_Price.Progresso+Log_Price.Campbell +Log_Price.PL+Winter+Incomelvl+Region, data=PS)
summary(reg4)
coefplot(reg4)

multiplot(reg1, reg2, reg3, reg4)


# Panel Data

install.packages("plm")
library(plm)


# Set data as panel data
pdata <- plm.data(PS, index=c("IRI_KEY","Month"))
