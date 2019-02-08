### 04-02-2019
#Market basket analysis V1.2: Use apriori and visualize data

####################################
#model 1: finding meaningfull rules#
####################################

Category_Basket_analysis_1 <- apriori(Task_4, parameter = list(support = (150/9832),
                                       confidence = 0.001,
                                       minlen = 3))

###########################
#identify dupplicate rules#
###########################

table(is.redundant(Category_Basket_analysis_1))
Category_Basket_analysis_1 <- Category_Basket_analysis_1[!is.redundant(Category_Basket_analysis_1)]   

##################################
#summary and toplists by category#
##################################

summary(Category_Basket_analysis_1)
inspect(sort(Category_Basket_analysis_1, by = "support")[1:15])
inspect(sort(Category_Basket_analysis_1, by = "confidence")[1:10])
inspect(sort(Category_Basket_analysis_1, by = "lift")[1:10])
   
ruleExplorer(Category_Basket_analysis_1)


plot(Category_Basket_analysis_1)
   
###############################
#model 2: raise support to 400#
###############################

Category_Basket_analysis_2 <- apriori(Task_4, parameter = list(support = (400/9832),
                                       confidence = 0.001,
                                       minlen = 2))
table(is.redundant(Category_Basket_analysis_2))
summary(Category_Basket_analysis_2)
inspect(sort(Category_Basket_analysis_2, by = "lift")[1:10])

#model 2: raise support to 600

Category_Basket_analysis_2 <- apriori(Task_4, parameter = list(support = (600/9832),
                                       confidence = 0.001,
                                       minlen = 2))
table(is.redundant(Category_Basket_analysis_2))
summary(Category_Basket_analysis_2)
inspect(sort(Category_Basket_analysis_2, by = "lift")[1:13])

#model 2: raise support to 800

Category_Basket_analysis_2 <- apriori(Task_4, parameter = list(support = (800/9832),
                                       confidence = 0.001,
                                       minlen = 2))
table(is.redundant(Category_Basket_analysis_2))
summary(Category_Basket_analysis_2)
inspect(sort(Category_Basket_analysis_2, by = "lift")[1:13])

