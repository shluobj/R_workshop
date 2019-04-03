#Exercise 1 Guide 

#download the data 
acs <- read.csv(url("http://stat511.cwick.co.nz/homeworks/acs_or.csv"))

#transform the data

#access a particular column
acs$age_husband

#access data as a vector
#1st row column 3 
acs[1,3]

#subset
#create new factor a of acs data where age of husband is greater than age of wife
a <- subset(acs, age_husband > age_wife)

#mean
mean(acs$age_husband)

#median
median(acs$age_husband)

#quantile
quantile(acs$age_wife)

#variance
var(acs$age_wife)

#standard deviation
sd(acs$age_wife)

#plot 
s <- acs[1:100,]
plot(x = s$age_husband , y = s$age_wife, type = 'p')

#hist
hist(acs$number_children)

#bar plots
counts <- table(acs$bedrooms) 
barplot(counts, main="Bedrooms Distribution", xlab="Number of Bedrooms")
