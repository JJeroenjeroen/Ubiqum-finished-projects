#####################################################
# Date:      29-03-2019                             #
# Author:    Jeroen Meij                            #
# File:      Customer Sentiment Analysis            #
# Version:   1.0                                    #    
#####################################################
rm(list = ls())
set.seed(124)

#libraries
library(readr)
library(plotly)
library(caret)
library(dplyr)
library(DMwR)

#set working directory
setwd("C:/Users/Jeroen/Desktop/Ubiqum/Big Data/Excel files")

#add dataframe for samsung modelling/predictions
samsung_matrix <- read.csv("galaxy_smallmatrix_labeled_8d.csv")

#Make sure the galaxy is mentioned in the web page
samsung_matrix <- samsung_matrix %>% filter(samsunggalaxy > 0)

#select the vars that actually say something about the galaxy
samsung_matrix <- samsung_matrix %>% select(samsungcampos, samsungcamneg, samsungcamunc,  
                                          samsungdispos, samsungdisneg, samsungdisunc, 
                                          samsungperpos, samsungperneg, samsungperunc, 
                                          galaxysentiment)


#split the matrix in a df for the y variable and for the x variables
samsung_sentiment <- samsung_matrix[ncol(samsung_matrix)]
samsung_xvars <- samsung_matrix[-ncol(samsung_matrix)]

#add sums of review words
samsung_xvars$rowsums <- rowSums((samsung_xvars))
summary(samsung_xvars$rowsums)

#add dataframe back together
samsung_matrix <- bind_cols(samsung_xvars, samsung_sentiment)

#filter for a minimum of 7 sentiment finds
samsung_matrix <- samsung_matrix %>% filter(rowsums > 2)
samsung_matrix$rowsums <- NULL

#split the matrix in a df for the y variable and for the x variables
samsung_sentiment <- samsung_matrix[ncol(samsung_matrix)]
samsung_xvars <- samsung_matrix[-ncol(samsung_matrix)]

#bind rows back together
samsung_matrix <- bind_cols(samsung_xvars, samsung_sentiment)

#replace the 6 factoris into 3
samsung_matrix$galaxysentiment <-  recode(samsung_matrix$galaxysentiment,
                                         "0" =  1, "1" = 2,
                                         "2" = 2, "3" = 2,
                                         "4" = 2, "5" = 3)
#make the factor an actual factor
samsung_matrix$galaxysentiment <- as.factor(samsung_matrix$galaxysentiment)

