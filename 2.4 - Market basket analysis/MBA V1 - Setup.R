### 31-01-2019
#Market basket analysis V1.0.0: Setting the working directory for the full dataset and importing data#
######################################################################################################

rm(list = ls())


library(ggplot2)
library(arules)
library(arulesViz)

setwd("/Users/Jeroen/Desktop/Ubiqum/Ubiqum objective 2/Task 4")
Task_4_full <- read.transactions("ElectronidexTransactions2017.csv",
                                 sep = (","),
                                 format = "basket",
                                 skip = 1) 

##############
#look at data#
##############

summary(Task_4_full)

##############################
#generate item frequency plot#
##############################

items_freq = data.frame(Distinct_Items = c(1:30), 
                        Frequency = c(2163, 1647, 1294, 1021, 856, 
                                      646, 540, 439, 353, 247, 171,
                                      119, 77, 72, 56, 41, 26, 20, 
                                      10, 10, 10, 5, 3, 0, 1, 1, 3, 
                                      0, 1, 1))
ggplot(items_freq, aes(x = Distinct_Items, y = Frequency)) +
  theme_bw() + 
  geom_bar(stat="identity", color = "black", fill = "red") + 
  labs(y = "Frequency",
       x = "Distinct items bought in transaction",
       title = "Frequency of transactions with number of distinct items")


###########
#visualize#
###########

itemFrequencyPlot(Task_4_full ,type = "absolute", topN = 20) 
   