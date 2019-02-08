#28-01. Ubiqum task 2. v2.0.5 --> predicting model with k-Nearest Neighbors

#remove variables for knn
Task_2_kNN = Task_2[c(-3, -4, -5, -6)]

#create new training and testing set
set.seed(123)
Task_2_kNN_Train_rows <- createDataPartition(y = Task_2_kNN$brand, p = .75, list = FALSE)
Task_2_kNN_Train_set <- Task_2_kNN[ Task_2_kNN_Train_rows, ]
Task_2_kNN_Test_set <- Task_2_kNN[ -Task_2_kNN_Train_rows, ]

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
train_preProc <- c("center", "scale")
train_method = "knn"
train_metric <- "Accuracy"
train_tuneLength = 10
train_tuneGrid <- expand.grid(.k=c(60:70))

#train Random Forest Regression model 
set.seed(123)
KNNFit1 <- train(brand ~ .,
                 data = Task_2_kNN_Train_set,
                 preProc = train_preProc,
                 method = train_method,
                 metric = train_metric,
                 tuneGrid = train_tuneGrid,
                 trControl = fitControl)

print(KNNFit1)
plot(KNNFit1)


#predict brand outcomes on the testing data
Brand_prediction_kNN <- predict(KNNFit1, newdata = Task_2_kNN_Test_set)
str(Brand_prediction_kNN)

#Provide model accuracy and Kappa
postResample(Brand_prediction_kNN, Task_2_kNN_Test_set$brand)

#See the most important variables
varImp(KNNFit1)

#show values in confusion matrix
confusionMatrix(data = Brand_prediction_kNN, Task_2_kNN_Test_set$brand)

