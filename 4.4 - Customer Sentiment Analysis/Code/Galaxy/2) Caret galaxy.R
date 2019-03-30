#####################################################
# Date:      29-03-2019                             #
# Author:    Jeroen Meij                            #
# File:      Customer Sentiment Analysis            #
# Version:   1.0                                    #    
#####################################################
setwd("C:/Users/Jeroen/Desktop/Ubiqum/Big Data/Code/Galaxy")
source(file = "1) Setup Galaxy.R")




#make a data partition
#how big should the data partition be?
no_rows_partition <- 210

#create the data partition of the full trainingset  
set.seed(125)
train_partition <- createDataPartition(y = samsung_matrix[,"galaxysentiment"],
                                       p = (no_rows_partition/nrow(samsung_matrix)),
                                       list = FALSE)

#create trainset
samsung_train <- samsung_matrix[train_partition,]
samsung_train <- downSample(samsung_train[(c(1:ncol(samsung_train)-1))], 
                          samsung_train$galaxysentiment, list = FALSE, yname = "galaxysentiment")

#create testset
samsung_test <- samsung_matrix[-train_partition,]


#set coss validation parameters
control_method <-"repeatedcv"
control_folds <- 10
control_repeats <- 1
control_search <- "grid"
fitControl <- trainControl(method = control_method,
                           number = control_folds,
                           repeats = control_repeats,
                           search = control_search)

#set training parameters
train_method <- "rf"
train_metric <- "Kappa"
train_tuneLength <- 15

#train Random Forest Regression model 
set.seed(125)
knnFit <- train(galaxysentiment ~ .,
                data = samsung_train,
                method = train_method,
                metric = train_metric,
                tuneLength = train_tuneLength,
                trControl = fitControl)



#See the most important predictors
varImp(knnFit)
predictions <- predict(knnFit, newdata = samsung_test)
postResample(predictions, samsung_test$galaxysentiment)
confusionMatrix(predictions, samsung_test$galaxysentiment)

