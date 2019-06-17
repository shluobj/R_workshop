library(corrplot)
library(coefplot)
library(rpivotTable)
library(Hmisc)
library(dplyr)
library(ggplot2)
library(modelr)
library(corrplot)
library(ggcorrplot)
library(maps)
library(blscrapeR)
library(ggplot2)
library(tmap)
library(maptools)


setwd('/Users/Jupiter/Desktop/NYC_Data_Science_Academy/github_copy/Section 8_Strategy/')
HDLo <- read.csv('HDLData1.csv')

# Get the most recent unemployment rate for each county on a national level.
df <- get_bls_county()

# Get map data
us_map <- county_map_data

#add leading 0 to FIPS to make it 5 digets
HDLo$county <- formatC(HDLo$county, width = 5, format = "d", flag = "0")

map_fips_latlong <- merge(HDLo, us_map, by.x = "county", by.y = "id", all.x=TRUE, all.y=FALSE, no.dups=TRUE)
map_fips_latlong <- map_fips_latlong[!duplicated(map_fips_latlong$county),]
map_fips_latlong <- data.frame(map_fips_latlong)

#Remove all NA rows
map_fips_latlong <- map_fips_latlong[complete.cases(map_fips_latlong), ]

#convert county to numeric
map_fips_latlong$county <- as.numeric(as.character(map_fips_latlong$county))
map_fips_latlong$Lcount <- as.numeric(as.character(map_fips_latlong$Lcount))

install.packages(c("choroplethr", "choroplethrMaps")) 
library(choroplethr)
library(choroplethrMaps)

#Lowes map by county
Lowes <- cbind.data.frame(map_fips_latlong$county, map_fips_latlong$Lcount)
Lowes <- Lowes[complete.cases(Lowes), ]
names(Lowes) <- c("region", "value")
county_choropleth(Lowes) +   scale_fill_brewer(palette="Blues") 

#HomeDepot map by county
HomeDepot <- cbind.data.frame(map_fips_latlong$county, map_fips_latlong$HDcount)
HomeDepot <- Lowes[complete.cases(Lowes), ]
names(HomeDepot) <- c("region", "value")
county_choropleth(HomeDepot) +   scale_fill_brewer(palette="Oranges") 






