#####################################################
# Date:      29-03-2019                             #
# Author:    Jeroen Meij                            #
# File:      Customer Sentiment Analysis            #
# Version:   1.0                                    #    
#####################################################
setwd("C:/Users/Jeroen/Desktop/Ubiqum/Big Data/Code/Iphone")
source(file = "2) Caret iphone.R")

#set working directory
setwd("C:/Users/Jeroen/Desktop/Ubiqum/Big Data/Excel files")

#add dataframe for iphone modelling/predictions
iphone_large_matrix <- read.csv("LargeMatrix.csv.csv")

iphone_large_matrix <- iphone_large_matrix %>% filter(iphone > 1)
#select the vars that actually say something about the iphone
iphone_large_matrix <- iphone_large_matrix %>% select(iphonecampos, iphonecamneg, iphonecamunc,  
                                          iphonedispos, iphonedisneg, iphonedisunc,
                                          iphoneperpos, iphoneperneg, iphoneperunc, 
                                          iosperpos, iosperneg)


#add sums of review words
iphone_large_matrix$rowsums <- rowSums((iphone_large_matrix))


#filter for a minimum of 7 sentiment finds
iphone_large_matrix <- iphone_large_matrix %>% filter(rowsums > 7)
iphone_large_matrix$rowsums <- NULL


predictions <- predict(knnFit, newdata = iphone_large_matrix)
summary(predictions)
prop.table(table(predictions))
