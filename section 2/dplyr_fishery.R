#Using the DPLYR package
#We'll use dplyr to do data manipulations or 
# "tidying" for fisheries using data(FSAdata) from the 
# library(FSAdata) package
install.packages(dplyr)
library(dplyr)
library(FSAdata)

install.packages("~/Downloads/FSAdata_0.3.6.tar.gz", repos = NULL, type = "source")

#The RuffeSLRH92 data frame is then loaded.

#load the fishery data
data(RuffeSLRH92)

summary(RuffeSLRH92)
#get the strucuture of the dataset
str(RuffeSLRH92)

#Select (columns) Example
#Columns can be selected from a data.frame 
#with select(),given the original data.frame 
#as the first argument and the variables to select, 
#or include, as further arguments. 
#The following creates a data.frame without the fish.id, species, day and year variables (they are not very 
#useful in this context and will make the 
#output further below easier to read).

RuffeSLRH92.test <- select(RuffeSLRH92,fish.id,day,year)

nrow(RuffeSLRH92)
head(RuffeSLRH92)

#The following creates a data.frame of just the length and weight variables.
ruffeLW <- select(RuffeSLRH92,length,weight)
tail(RuffeSLRH92, n = 1)

#The dplyr package contains a variety of helpers 
#for selecting. As one example, 
#the following will select all variables that contains the letter “l”.

ruffeL <- select(RuffeSLRH92,contains("l"))
str(ruffeL)

#Filtering Example
#The filter() function can be used similarly to subset() to 
#select a set of rows from an original data.frame according to some 
#conditioning statement. As with subset(), filter() returns an object
#that maintains a list of the original levels whether those levels 
#exist in the new data.frame or not. Use droplevels() to restrict the 
#levels to only those that exist in the data.frame. 
#The example below finds just the males from the original data.frame.

male <- filter(RuffeSLRH92["sex"],sex=="male")

#Create a contingency table from cross-classifying factors, 
#usually contained in a data frame, using a formula interface
xtabs(~sex,data=male)

male <- droplevels(female)
xtabs(~sex,data=male)

table(RuffeSLRH92$sex)

#Multiple conditioning statements can be strung together as 
#additional arguments to filter(). The example below finds males that are also ripe.
maleripe <- filter(RuffeSLRH92,sex=="male",maturity=="ripe")
maleripe.or <- filter(RuffeSLRH92,sex=="male",maturity=="ripe")

xtabs(~sex+maturity+age,data=RuffeSLRH92)
maleripe2 <- filter(RuffeSLRH92,sex=="male" | maturity=="ripe")

xtabs.df <- xtabs(~sex+maturity,data=maleripe2)

#Arrange Example
#The arrange() function can be used to order individuals.
#The first argument is the data.frame and the following arguments are 
#the variables to sort by. The following sorts, in ascending order, 
#the male data.frame created above by length.
malea <- arrange(male,length)
head(malea)

tail(malea)

#The following does the same but in descending order.
maled <- arrange(RuffeSLRH92,desc(length))
head(maled)
tail(maled)

#Multiple levels of ordering can be completed by including 
#multiple variables as arguments to arrange(). 
#The following sorts the data by ascending length and 
#then ascending weight.
ruffe2 <- arrange(RuffeSLRH92,length,weight)
head(ruffe2)
tail(ruffe2)

#Add new variables (i.e., columns) Example
#The mutate() function can be used to add new variables to a data.frame. 
#It requires the original data.frame as the first argument and then arguments to create new variables as the remaining arguments. 
#The example below adds the natural log of length and weight to the data.frame created above that contains just the length and weight variables.
ruffeLW <- mutate(ruffeLW,logL=log(length),logW=log(weight))
head(ruffeLW)

#Aggregation and Summarization Example
#The dplyr package also provides functions that allow for simple aggregation
#of results. The group_by() function first sets up how you want to 
#group your data. In the code below, the byMon data.frame is 
#going to create groups by the month variable. 
#The summarize() function will then summarize a data.frame by the functions after the first argument. 
#The package also provides n() to count the number of individuals. 
#Thus, the example below will count the number of ruffe in the original data.frame by each month.
byMon <- group_by(RuffeSLRH92,month)
( sumMon <- summarize(byMon,count=n()) )

#The following counts the number of ruffe by each month and sex.
byMonSex <- group_by(RuffeSLRH92,month,sex)
( sumMonSex <- summarize(byMonSex,count=n()))

#Multiple functions can be used to create multiple summaries at once.
#The following summarizes the number of fish and the mean and standard deviation of length by month.
( LenSumMon <- summarize(byMon,n=n(),mn=mean(length),sd=sd(length)) )
