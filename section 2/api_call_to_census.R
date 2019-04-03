#API grab from census 
# http://proximityone.com/zipcode_data_analytics.htm#option3


#use the jsonlite package
install.packages("jsonlite")
library(jsonlite)
#create a variable for the long url
census.url <- "https://api.census.gov/data/2015/acs5?get=B01003_001E,B01001_011E,B01001_035E,B02001_002E,B02001_003E,B02001_004E,B02001_005E,B02001_006E,B02001_007E,B02001_008E,B03001_003E,B19013_001E,B19113_001E,B25001_001E,B25002_002E,B25003_002E,B25075_023E,B25075_024E,B25075_025E,B25002_003E,B25077_001E,B25064_001E&for=zip+code+tabulation+area:*"

#import the json data from the url as a matrix
census.API <- jsonlite::fromJSON(census.url, simplifyVector = TRUE)
summary(census.API)
nrow(census.API)
#convert to dataframe as it was imported as a matrix
census.df <- as.data.frame(census.API)

# unlist the first row of V1...Vn and use the headers 
colnames(census.df) <- as.character(unlist(census.df[1,]))
colnames(census.df)

census.df <- census.df[-1,]

#rename the column names
colnames(census.df) <- c("Total.population", "Male_25_to_29", "Female25to29", 
                         "White", "AfricanAmerican","AmericanIndianAlskan", "Asian", 
                         "PacificIslander","other.race", "MixRace", "Hispanic", "MedianHouseIncome", 
                         "MedianFamilyIncome", "total.housing.units", "occupied.housing.units",
                         "HouseholdMore200k", "OwnerOccupiedHouse", "House500k", "House750k", "House1m",
                         "VacantHouse", "MedianHouseValue", "ZIP")
View(census.df)

census.df$Total.population <- as.numeric(census.df$Total.population)
mean(census.df$Total.population)
describe(census.df$MedianHouseIncome)
census.df$MedianHouseIncome <- as.numeric(census.df$MedianHouseIncome)
census.householdincome.greter.fiftyK <- subset(census.df, "MedianHouseIncome" > 50000)

census.householdincome.greter.fiftyK <- filter(census.df["MedianHouseIncome"],MedianHouseIncome>=10000)
summary(census.householdincome.greter.fiftyK$MedianHouseIncome)

summary(census.householdincome.greter.fiftyK)

View(census.householdincome.greter.fiftyK)
View(census.householdincome.greter.fiftyK)
#census.df.new <- !is.na(census.df$MedianHouseIncome)
mean(census.df.new)
census.df$MedianHouseIncome <- as.numeric(census.df$MedianHouseIncome)

