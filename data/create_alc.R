# Zilan Wen
# date 20.11.2017
# description
# The R script is for the RStudio Exercise 3 --Logistic regression.The data set given in the link ¡®https://archive.ics.uci.edu/ml/datasets/Student+Performance¡¯ has been preprocess fpr further analysis.The data for this section is extracted from a survey conducted byPaulo Cortez on predicting student performance in secondary education. 
# ind out first where your working directory is set at this moment
getwd()
# change the path in the ¡®data¡¯ folder of my project
setwd('D:/github/IODS-project/data')
# Read both student-mat.csv and student-por.csv into R (from the data folder): the read.table() function
mat <- read.table('student-mat.csv', sep = ";", header = T)
por <- read.table('student-por.csv', sep = ";", header = T)
# explore the structure and dimensions of the data
str(mat)
# data.frame':	395 obs. of  33 variables:
dim(mat)
# [1] 395  33
str(por)
# 'data.frame':	649 obs. of  33 variables:
dim(por)
# [1] 649  33
# access the dplyr library
library(dplyr)
# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
# join the two datasets by the selected identifiers
mat_por <- inner_join(mat, por, by = join_by, suffix = c(".mat", ".por"))
# see the new column names
colnames(mat_por)
# Explore the structure and dimensions of the joined data
str(mat_por)
# 'data.frame':	382 obs. of  53 variables
dim(mat_por)
# [1] 382  53
# create a new data frame with only the joined columns
alc <- select(mat_por, one_of(join_by))
# columns that were not used for joining the data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]
# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'mat_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}
# glimpse at the new combined data
glimpse(alc)
# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)
# Glimpse at joined and modified data 'alc'. 
glimpse(alc)
# Save the joined and modified data set'alc' to the ¡®data¡¯ folder
write.table(alc, file = 'alc.txt', row.names = F, sep = ',')
