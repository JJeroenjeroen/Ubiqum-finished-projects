### 04-02-2019
#Market basket analysis V1.2: Setting the working directory for categories and importing data
###############################################################################################

rm(list = ls())
library(ggplot2)
library(arules)
library(arulesViz)

setwd("/Users/Jeroen/Desktop/Ubiqum/Ubiqum objective 2/Task 4")
Task_4 <- read.transactions("ElectronidexTransactions2017 categories.csv",
                            sep = (";"),
                            format = "basket")

##############
#look at data#
##############
summary(Task_4)

##############################
#generate item frequency plot#
##############################

items_freq = data.frame(Distinct_Items = c(1:14), 
                        Frequency = c(2369, 1927, 1584, 1270, 982, 692, 
                                      470, 245, 143, 71, 52, 18,
                                      5, 4))
ggplot(items_freq, aes(x = Distinct_Items, y = Frequency)) +
  theme_bw() + 
  geom_bar(stat="identity", color = "black", fill = "red") + 
  labs(y = "Frequency",
       x = "Distinct categories bought in transaction",
       title = "Frequency of transactions with distinct categories sold")


###########
#visualize#
###########

itemFrequencyPlot(Task_4 ,type = "absolute", topN = 10) 

