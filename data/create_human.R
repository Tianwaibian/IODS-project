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
colnames(hd)[3] <- 'HDI'
colnames(hd)[4] <- 'Exp.lif'
colnames(hd)[5] <- 'Exp.edu'
colnames(hd)[6] <- 'Mean.edu'
colnames(hd)[7] <- 'GNI.per'
colnames(hd)[8] <- 'Rank(GNI-HDI)'
colnames(gii)[3] <- 'gii'
colnames(gii)[4] <- 'MMR'
colnames(gii)[5] <- 'ABR'
colnames(gii)[6] <- 'Percent.Rpp'
colnames(gii)[7] <- 'edu2F'
colnames(gii)[8] <- 'edu2M'
colnames(gii)[9] <- 'LabF'
colnames(gii)[10] <- 'LabM'

# Mutate the ¡°Gender inequality¡± data and create two new variables. 
library(dplyr)
Gii <- mutate(gii, Rfm_edu = edu2F / edu2M, Rfm_lab = LabF / LabM)

# Join together the two datasets using the variable Country as the identifier
human <- inner_join(hd, Gii, by = "Country")
# save the joined data "human" in data folder
setwd('D:/github/IODS-project/data')
write.table(human, file = 'human.txt', row.names = F, sep = ',')

