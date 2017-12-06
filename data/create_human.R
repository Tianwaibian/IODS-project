# Author_name: Zilan Wen
# Date: 29.11.2017
# Discription
# RStudio Exercise 4 - Data wrangling

# Read the ¡°Human development¡± and ¡°Gender inequality¡± datas
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Explore the datasets

str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

#  rename the variables 

colnames(hd)
a <- c('HDI.Rank', 'Country', 'HDI', 'Life.Exp', 'Edu.Exp', 'Edu.mean', 'GNI', 'Rank(GNI-HDI)')
colnames(hd) <- a
colnames(gii)
b <- c('GII.Rank', 'Country', 'gii', 'Mat.Mor', 'Ado.Birth', 'Parli.F', 'Edu2.F', 'Edu2.M', 'Lab.F', 'Lab.M')
colnames(gii) <- b

# Mutate the ¡°Gender inequality¡± data and create two new variables. 
library(dplyr)
Gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M, Lab.FM = Lab.F / Lab.M)

# Join together the two datasets using the variable Country as the identifier
human <- inner_join(hd, Gii, by = "Country")
# 195 observations of 19 variables
# save the joined data "human" in data folder
setwd('D:/github/IODS-project/data')
write.table(human, file = 'human.txt', row.names = F, sep = ',')
glimpse(human)
# access the stringr package
install.packages('tidyr')
library(stringr)
# look at the structure of the GNI column in 'human'
str(human$GNI)
# remove the commas from GNI and print out a numeric version of it
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric
# columns to keep
names(human)
keep <- c( "Country", "Edu2.FM", "Lab.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
# select the 'keep' columns
human <- select(human, one_of(keep))
# print out a completeness indicator of the 'human' data
complete.cases(human)
# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))
# Remove all rows with missing values
human_ <- filter(human, complete.cases(human))
human_
# Remove the observations which relate to regions instead of countries
# look at the last 10 observations of human
tail(human_, n = 10)
# the last 7 row should be removed.
# define the last indice we want to keep
last <- nrow(human_) - 7
# choose everything until the last 7 observations
Human <- human_[1: last, ]
# add countries as rownames
rownames(Human) <- Human$Country
# remove the country name column from the data
names(Human)
Human <- Human[, c(2 : 9)]
# The data should now have 155 observations and 8 variables.
# Save the human data in your data folder including the row names
getwd()
write.table(Human, file = 'human.txt', row.names = T, sep = ',')
