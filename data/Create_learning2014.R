#'created at 22:00 14.11.2017
#'
#'@author:Zilan Wen
#'
#'The script for Rtudio Exercise 2
#'Data wrangling
setwd('D:/github/IODS-project/data')
data_url <- "http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt" 
lrn14 <- read.table(data_url, sep = '\t', header = TRUE)
#' look at the structure of data
str(lrn14)
#' look at the dimensions of the data
dim(lrn14)
#'the data frame of lrn14 has 183 observations anf 60 variables. All data is 'int' format except gender.
library(dplyr)
#'questions related to deep,surface and strategic learning
deep_questions <- c('D03', 'D11', 'D19', 'D27', 'D07', 'D14', 'D22', 'D30', 'D06', 'D15', 'D23', 'D31')
surface_questions <- c('SU02', 'SU10', 'SU18', 'SU26', 'SU05', 'SU13', 'SU21', 'SU29', 'SU08', 'SU16', 'SU24', 'SU32')
strategic_questions <-c('ST01', 'ST09', 'ST17', 'ST25', 'ST04', 'ST12', 'ST20', 'ST28')
#'select the columns related to deeping learning and create column 'deep' by averageing
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)
#'select the columns related to surface learning  and create column 'surf' by averageings
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)
#'select the columns related to strategic learning  and create column 'stra' by averageings
strategic_columns <-  select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)
#'choose a handful of columns to keep 
keep_columns <- c('gender', 'Age', 'Attitude', 'deep', 'stra', 'surf', 'Points')
#'select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))
#'Modify column names
colnames(learning2014)
colnames(learning2014)[2] <- "age"
colnames(learning2014)[3] <- "attitude"
colnames(learning2014)[7] <- "points"
#��Scale all combination variables to the original scales 
learning2014$attitude <- learning2014$attitude/10
#'select rowa where points is greater than zero
learning2014 <- filter(learning2014, points > 0)
str(learning2014)
#'save datafile
write.table(learning2014,file='learning2014.txt',row.names=F,sep = '\t')

# Data Analysis
