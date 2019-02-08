#28-01. Ubiqum task 2. v3.0.0 --> predicting model with c5.0 Decision Tree

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
train_method <- "C5.0"
train_metric <- "Accuracy"
train_tuneLength <- 10
train_tuneGrid <- expand.grid(.mtry=c(10:50))


#train Random Forest Regression model 
set.seed(123)
C50Fit1 <- train(brand ~ .,
                 data = Task_2_Train_set,
                 method = train_method,
                 metric = train_metric,
                 tuneLength = train_tuneLength,
                 trControl = fitControl)


print(C50Fit1)
plot(C50Fit1)


#predict brand outcomes on the testing data
Brand_prediction_c5 <- predict(C50Fit1, newdata = Task_2_Test_set)
str(Brand_prediction_c5)

#Provide model accuracy and Kappa
postResample(Brand_prediction_c5, Task_2_Test_set$brand)


#show values in confusion matrix
confusionMatrix(data = Brand_prediction_c5, Task_2_Test_set$brand)

#See the most important predictors
varImp(C50Fit1)



