#28-01. Ubiqum task 2. v3.0 --> Setting up and altering data for usage

#clear workspace
rm(list = ls())

#Load libraries used in this task
library(ggplot2)
library(readr)
library(caret)
library(randomForest)
library(C50)

#Retrieve data and set seed
setwd("/Users/Jeroen/Desktop/Ubiqum/Ubiqum objective 2/Task 2")
Task_2 <- read.csv("CompleteResponses.csv")
set.seed(123)


#factor and label the necessary variables 
Task_2$brand <- factor(Task_2$brand,
                       levels = c(0,1),
                       labels = c("Acer",
                                  "Sony"))


Task_2$zipcode <- factor(Task_2$zipcode,
                        levels = c(0:8),
                        labels = c("New England",
                                   "Mid-Atlantic",
                                   "East North Central",
                                   "West North Central",
                                   "South Atlantic",
                                   "East South Central",
                                   "West South Central",
                                   "Mountain",
                                   "Pacific"))

Task_2$car <- factor(Task_2$car,
                        levels = c(1:20),
                        labels = c("BMW",	
                                   "Buick",	
                                   "Cadillac",	
                                   "Chevrolet",	
                                   "Chrysler",	
                                   "Dodge",	
                                   "Ford",	
                                   "Honda",	
                                   "Hyundai",	
                                   "Jeep",	
                                   "Kia",	
                                   "Lincoln",	
                                   "Mazda",	
                                   "Mercedes Benz",	
                                   "Mitsubishi",	
                                   "Nissan",	
                                   "Ram",	
                                   "Subaru",	
                                   "Toyota",	
                                   "None of the above"))



Task_2$elevel <- ordered(Task_2$elevel,
                         levels = c(0:4), 
                         labels = c("Less than High School Degree",
                                    "High School Degree",
                                    "Some College",
                                    "4-Year College Degree",
                                    "Master's, Doctoral or Professional Degree"))



#divide the data and create a training and test set
Task_2_Train_rows <- createDataPartition(y = Task_2$brand,
                                         times = 1,
                                         p = .75,
                                         list = FALSE)

Task_2_Train_set <- Task_2[ Task_2_Train_rows, ]
Task_2_Test_set <- Task_2[ -Task_2_Train_rows, ]
