#####################################################
# Date:      24-03-2019                             #
# Author:    Jeroen Meij                            #
# File:      Wifi localization modeling             #
# Version:   final                                  #    
#####################################################



#This file will create the train various models and save the results in a RDS file  
#For more information, visit http://archive.ics.uci.edu/ml/datasets/UJIIndoorLoc
#########################################################################################

setwd("C:/Users/Jeroen/Desktop/Ubiqum/IoT Analytics/Task 3 - Techniques for Wifi Locationing/Code/Seperate building analysis/Location predictions/Building 1")
source(file = "1) Building 1 preprocess.R")

#set cross validation parameters
control_method <-"repeatedcv"
control_folds <- 10
control_repeats <- 1
control_search <- "grid"

fitControl <- trainControl(method = control_method,
                           number = control_folds,
                           repeats = control_repeats,
                           search = control_search)


train_tuneGrid <- expand.grid(.k=c(11:20))



#Choose parameters for training and testing the models
############################################################################

#which algorithms should be used?
algorithms <- c("knn")

#create an empty list that will contain the ¨predictions of the loop
all_predicted_values <- list()


############################################################################


#this for-loop will specify which algorithm the caret package will use
for (method in algorithms){
  
#set training parameters
  train_method = method
  
#the following for-loop will loop all datasets x & y's and make a trained  model for them
  for (i in 1:length(y_names)){
    set.seed(124)
    
#create a throwaway var of the trained values that will be used in this loop to predict the dependent variables
    throwaway_fit <- train(x = x_list_train[[y_names[i]]],
                           y = y_list_train[[y_names[i]]],
                           method = train_method,
                           tuneGrid = train_tuneGrid,
                           trControl = fitControl)
    
    
    
#create a throwaway predict that can be used in this loop and removed afterwards 
    throwaway_predict <- predict(throwaway_fit,
                                 newdata = x_list_test[[y_names[i]]])
    
    
#provide statistics of applied model on the testing set
    assign(paste(method,
                 "_outcome_",
                 y_names[i],
                 sep = ""),
           postResample(throwaway_predict
                        , y_list_test[[y_names[i]]]))
    
    
    
#generate predicted values
    throwaway_df <- data.frame(throwaway_predict)
    colnames(throwaway_df) <- paste(method, 
                                    "_predict_",
                                    y_names[i], 
                                    sep = "")
    
    
#store predictions of all loops in a list
    all_predicted_values <- list.append(all_predicted_values, 
                                        throwaway_df)
    
    
#remove throwaway parts of loop
    remove(throwaway_fit)
    remove(throwaway_predict)
    remove(throwaway_df)
  }
}
remove(Building_1_train, Building_1_test,
       fitControl, train_tuneGrid, 
       x_list_test, x_list_train, 
       y_list_train)






#store all predicted values in an RDS file
setwd("C:/Users/Jeroen/Desktop/Ubiqum/IoT Analytics/Task 3 - Techniques for Wifi Locationing/Excel datafiles/Results")
saveRDS(all_predicted_values,
        file = paste(Sys.Date(), "BUilding 1 location"))
