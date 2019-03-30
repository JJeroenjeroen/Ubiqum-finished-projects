#####################################################
# Date:      29-03-2019                             #
# Author:    Jeroen Meij                            #
# File:      Customer Sentiment Analysis            #
# Version:   1.0                                    #    
#####################################################
setwd("C:/Users/Jeroen/Desktop/Ubiqum/Big Data/Code/Galaxy")
source(file = "2) Caret galaxy.R")

#set working directory to get big matrix
setwd("C:/Users/Jeroen/Desktop/Ubiqum/Big Data/Excel files")

#add dataframe for samsung modelling/predictions
samsung_big_matrix <- read.csv("LargeMatrix.csv.csv")


samsung_big_matrix <- samsung_big_matrix %>% filter(samsunggalaxy > 1)
#select the vars that actually say something about the galaxy
samsung_big_matrix <- samsung_big_matrix %>% select(samsungcampos, samsungcamneg, samsungcamunc,  
                                            samsungdispos, samsungdisneg, samsungdisunc, 
                                            samsungperpos, samsungperneg, samsungperunc)


#add sums of review words
samsung_big_matrix$rowsums <- rowSums((samsung_big_matrix))

#filter for a minimum of 2 sentiment finds
samsung_big_matrix <- samsung_big_matrix %>% filter(rowsums > 2)
samsung_big_matrix$rowsums <- NULL

predictions <- predict(knnFit, newdata = samsung_big_matrix)
summary(predictions)

prop.table(table(predictions))
