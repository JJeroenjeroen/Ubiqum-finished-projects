#28-01. Ubiqum task 2. v3.0.0
#predicting model with Random Forest


#set cross validation parameters
control_method <-"repeatedcv"
control_folds <- 10
control_repeats <- 1
control_search <- "grid"

fitControl <- trainControl(method = control_method,
                           number = control_folds,
                           repeats = control_repeats,
                           search = control_search)


#set training parameters
train_method = "rf"
train_metric <- "Accuracy"
train_tuneLength = 20
train_tuneGrid <- expand.grid(.mtry=c(1:20))

#train Random Forest Regression model 
set.seed(123)
rfFit1 <- train(brand ~ .,
                data = Task_2_Train_set,
                method = train_method,
                metric = train_metric,
                tuneGrid = train_tuneGrid,
                trControl = fitControl)

print(rfFit1)
ggplot(rfFit1) +
  theme_bw() + 
  geom_point(color = "red") + 
  labs(title="Mtry vs Accuracy",
       x="Number of variables randomly sampled as candidates at each split",
       y = "Accuracy") 


#predict brand outcomes on the testing data
Brand_prediction_rf <- predict(rfFit1, newdata = Task_2_Test_set)
postResample(Brand_prediction_rf, Task_2_Test_set$brand)

#See the most important predictors
varImp(rfFit1)

#show values in confusion matrix
confusionMatrix(data = Brand_prediction_rf, Task_2_Test_set$brand)

