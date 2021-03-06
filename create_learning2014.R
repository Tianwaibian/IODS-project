#Mealk Weldenegodguad
#date 13.11.017
#Preprocess a data set given in this link http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt for further and downstream analysis

#install.packages("dplyr")

library(dplyr)

# Read the full learning2014 data from link using the R "read.table" function and the separator is a tab ("\t") and the file includes a header i.e header=TRUE. 

# the data read to memory and put in the object Learn2014

Learn2014=read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Using head function checking the first six rows

head(Learn2014)

#The dimensions of the data can be checked using the code below

dim(Learn2014)

#The dimensions of the fulll Learn2014 is 183 rows and 60 column

#The structure of the data can be explored using the code below

str(Learn2014)

# The structure 'data.frame':	183 obs. of  60 variables:


#The column Attitude in Learn2014 is a sum of 10 questions and to scale the Attitude to the mean we should dived the Attitude value by 10 and store in "attitude" column

#Attitude  Da + Db + Dc + Dd + De + Df + Dg + Dh + Di + Dj

Learn2014$attitude <- Learn2014$Attitude / 10


# In order to Scale all combination variables to the original scales, select columns related to deep learning and scaling by taking the meand  and create column 'deep'  

# To scale deep learning variables to the original scales, select columns related to deep learning and scaling by taking the mean and create column 'deep' 

# deep=D03 + D11 + D19 + D27 + D07 + D14 + D22 + D30 + D06 + D15 + D23 + D31

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")

deep_columns <- select(Learn2014, one_of(deep_questions))

Learn2014$deep <- rowMeans(deep_columns)


# To scale surface learning variables to the original scales, select columns related to surface learning and scaling by taking the mean and create column 'surf'. 

#surf= SU02 + SU10 + SU18 + SU26 + SU05 + SU13 + SU21 + SU29 + SU08 + SU16 + SU24 + SU32

surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")

surface_columns <- select(Learn2014, one_of(surface_questions))
Learn2014$surf <- rowMeans(surface_columns)

# To scale strategic learning variables to the original scales, select columns related to strategic learning and scaling by taking the mean and create column 'stra'.

#stra=ST01 + ST09 + ST17 + ST25 + ST04 + ST12 + ST20 + ST28

strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

strategic_columns<- select(Learn2014, one_of(strategic_questions))
Learn2014$stra <- rowMeans(strategic_columns)


keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset

Learn2014_7_column <- select(Learn2014,one_of(keep_columns))

# Exclude observations where the exam points variable is zero.

Learn2014_7_column_exclude_0 <- filter(Learn2014_7_column, Points !=0)

dim(Learn2014_7_column_exclude_0)

# set the working diracroty using the R function "setwd"

##############################################################3
setwd("/home/melak/Open_data/IODS-project/data/")

# write the Preprocessed data i.e 166 by 7 to the file name learning2014.txt. the file is tab delmimted file 

write.table(Learn2014_7_column_exclude_0 ,"/home/melak/Open_data/IODS-project/data/learning2014.txt", sep="\t")

#############################################################

