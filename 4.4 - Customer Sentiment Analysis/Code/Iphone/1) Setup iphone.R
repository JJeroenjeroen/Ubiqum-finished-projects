#####################################################
# Date:      25-03-2019                             #
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

#add dataframe for iphone modelling/predictions
iphone_matrix <- read.csv("iphone_smallmatrix_labeled_8d.csv")

#Make sure the iphone is mentioned in the web page
iphone_matrix <- iphone_matrix %>% filter(iphone > 0)

#select the vars that actually say something about the iphone
iphone_matrix <- iphone_matrix %>% select(iphonecampos, iphonecamneg, iphonecamunc,  
                                          iphonedispos, iphonedisneg, iphonedisunc,
                                          iphoneperpos, iphoneperneg, iphoneperunc, 
                                          iosperpos, iosperneg, iphonesentiment)


#split the matrix in a df for the y variable and for the x variables
iphone_sentiment <- iphone_matrix[ncol(iphone_matrix)]
iphone_xvars <- iphone_matrix[-ncol(iphone_matrix)]

#add sums of review words
iphone_xvars$rowsums <- rowSums((iphone_xvars))
summary(iphone_xvars$rowsums)

#add dataframe back together
iphone_matrix <- bind_cols(iphone_xvars, iphone_sentiment)

#filter for a minimum of 7 sentiment finds
iphone_matrix <- iphone_matrix %>% filter(rowsums > 7)
iphone_matrix$rowsums <- NULL

#split the matrix in a df for the y variable and for the x variables
iphone_sentiment <- iphone_matrix[ncol(iphone_matrix)]
iphone_xvars <- iphone_matrix[-ncol(iphone_matrix)]

#bind rows back together
iphone_matrix <- bind_cols(iphone_xvars, iphone_sentiment)

#replace the 6 factoris into 3
iphone_matrix$iphonesentiment <-  recode(iphone_matrix$iphonesentiment,
                                         "0" =  1, "1" = 2,
                                         "2" = 2, "3" = 2,
                                         "4" = 2, "5" = 3)
#make the factor an actual factor
iphone_matrix$iphonesentiment <- as.factor(iphone_matrix$iphonesentiment)

