#28-01. Ubiqum task 2. v3.0.0
#script for error prediction

#make variables integers
int_brand_prediction_rf <- as.integer(Brand_prediction_rf) -1
int_brand_prediction_c5 <- as.integer(Brand_prediction_c5) -1
int_brand_prediction_kNN <- as.integer(Brand_prediction_kNN) - 1
int_brand_actual <- as.integer(Task_2_Test_set$brand) - 1


#Generate error variables
rf_error = as.factor(abs(int_brand_prediction_rf - int_brand_actual))
c5_error = as.factor(abs(int_brand_prediction_c5 - int_brand_actual))
kNN_error = as.factor(abs(int_brand_prediction_kNN - int_brand_actual))

#generate testdatasets with error 
Task_2_Test_set<- cbind(Task_2_Test_set, rf_error)
Task_2_Test_set<- cbind(Task_2_Test_set, c5_error)
Task_2_Test_set<- cbind(Task_2_Test_set, kNN_error)

#make ggplot rf
ggplot(Task_2_Test_set, aes(x = age,  y = salary, color = rf_error)) +
  theme_bw() + 
  facet_wrap(~ brand) + 
  geom_point() +
  labs(y = "Salary", 
       x = "Age",
       title = "RF error values per brand, plotted on age and salary")

#make ggplot c5
#Scatterplot to inspect the age , salary & brand
ggplot(Task_2_Test_set, aes(x = age,  y = salary, color = c5_error)) +
  theme_bw() + 
  facet_wrap(~ brand) + 
  geom_point() +
  labs(y = "Salary", 
       x = "Age",
       title = "C5.0 error values per brand, plotted on age and salary") 


#make ggplot kNN
ggplot(Task_2_Test_set, aes(x = age,  y = salary, color = kNN_error)) +
  theme_bw() + 
  facet_wrap(~ brand) + 
  geom_point() +
  labs(y = "Salary", 
       x = "Age",
       title = "kNN error values per brand, plotted on age and salary")
