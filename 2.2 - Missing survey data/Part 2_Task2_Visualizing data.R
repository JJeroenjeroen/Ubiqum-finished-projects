#28-01. Ubiqum task 2. v3.0.0
#script for initial visualization and data exploration

#relative percentages of brand preference
prop.table(table(Task_2$brand))

###########
#Barcharts#
###########

#Bar chart to see overall brand preference 
ggplot(Task_2, aes(x = brand, fill = brand)) +
  theme_bw() + 
  geom_bar() +
  labs(y = "Respondents", 
       title = "Preferred brand")
           

#barchart with educational level added 
ggplot(Task_2, aes(x = elevel, fill = brand)) +
  theme_bw() + 
  geom_bar() +
  labs(y = "Respondents", 
       title = "Preferred brand per educational level")

############
#Histograms#
############

#Histogram to inspect the distibution of age
ggplot(Task_2, aes(x = age, fill = brand)) +
  theme_bw() + 
  geom_histogram(binwidth = 5) +
  labs(y = "Respondents", 
       x = "Age (binwith = 5)",
       title = "Age distribution and brand preference")


#Histogram to inspect the distibution of salary
ggplot(Task_2, aes(x = salary, fill = brand)) +
  theme_bw() + 
  geom_histogram(binwidth = 5000) +
  labs(y = "Respondents", 
       x = "Salary (binwith = 5000)",
       title = "Salary distribution and brand preference ")


###############
#Density plots#
###############

#Density plot to inspect the salary by brand and educational level
ggplot(Task_2, aes(x = salary,  fill = brand)) +
  theme_bw() + 
  geom_density(alpha = 0.5) +
  labs(y = "Density", 
       x = "Salary",
       title = "Salary distribution and brand preference")



#Density plot to inspect the age by brand and educational level
ggplot(Task_2, aes(x = age,  fill = brand)) +
  theme_bw() + 
  geom_density(alpha = 0.5) +
  labs(y = "Density", 
       x = "Age",
       title = "Age distribution and brand preference")


##########
#Boxplots#
##########

#Boxplot to inspect the salary & brand
ggplot(Task_2, aes(x = brand,  y = salary, fill = brand)) +
  theme_bw() + 
  geom_boxplot() +
  labs(y = "Salary", 
       x = "Brand",
       title = "Salary distribution per brand preference")


#Boxplot to inspect the Age & brand
ggplot(Task_2, aes(x = brand,  y = age, fill = brand)) +
  theme_bw() + 
  geom_boxplot() +
  labs(y = "Age", 
       x = "Brand",
       title = "Age distribution per brand preference")


#Boxplot to inspect the Age & brand
ggplot(Task_2, aes(x = age,  y = salary, color = brand)) +
  theme_bw() + 
  geom_point() +
  labs(y = "Salary", 
       x = "Age",
       title = "Age and salary by brand preference")


#############
#Scatterplot#
#############

#Scatterplot to inspect the age , salary & brand
ggplot(Task_2, aes(x = age,  y = salary, color = brand)) +
  theme_bw() + 
  geom_point(position = "jitter") +
  labs(y = "Salary", 
       x = "Age",
       title = "Age and salary by brand preference")

