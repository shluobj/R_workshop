#Bank Data Viz 
#bank data set for EDA
# using bank/bank-full.csv
library(readr)
#bank_full <- read_delim("~/Desktop/NYC_Data_Science_Academy/github_copy/Section 5_EDA/bank.csv", ",", escape_double = FALSE, delim = ";", quote = "\"",  trim_ws = TRUE)
bank_full <- read.csv("~/Desktop/NYC_Data_Science_Academy/github_copy/Section 5_EDA/bank.csv", sep = ";")
bank_full <- as.data.frame(bank_full)

nrow(bank_full)
colnames(bank_full)
table(bank_additional$y)

View(bank_full)
#remove NA's 
row.has.na <- apply(bank_full, 1, function(x){any(is.na(x))})
#sum(row.has.na)
bank_full <- bank_full[!row.has.na,]

summary(bank_full$balance)
#bank_full$y <- as.factor(bank_full$y)
# get percentage of success with telemarketing currently (yes)
prop.table(table(bank_full$y))

str(bank_full)
summary(bank_full)

library(psych)
describe(bank_full)


#check for na's 
#is.na(bank_full)
library(Amelia)
missmap(bank_full, main="Missing Data - Bank Subscription", col=c("red","grey"), legend=FALSE)


#educaiton type
ggplot(data.frame(bank_full), aes(x=education)) + geom_bar()
ggplot(data.frame(bank_full), aes(x=housing)) + geom_bar()
ggplot(data.frame(bank_full), aes(x=contact)) + geom_bar()
ggplot(data.frame(bank_full), aes(x=job)) + geom_bar()
ggplot(data.frame(bank_full), aes(x=loan)) + geom_bar()
summary(bank_full)

bank_full[complete.cases(bank_full),]
nrow(bank_full)
require(ggplot2)
plot_marital <- ggplot(bank_full, aes(factor(marital), duration))
plot_marital + geom_boxplot()
plot_job <- ggplot(bank_full, aes(factor(job), duration))
plot_job + geom_boxplot()

ggplot(data=bank_full)+
  geom_bar(
    mapping=aes(x=bank_full$y,y= ..prop.., group=1))+
  facet_wrap(~job)
library(sm)
bank_full$age <- as.numeric(bank_full$age)

qplot(bank_full$loan, bank_full$age, data = bank_full, geom = c("point","smooth"), color = factor(y))

bank_full$month <- as.factor(bank_full$month)
prop.table(table(bank_full$month, bank_full$y))

hist(bank_full$duration)
nrow(bank_full)
