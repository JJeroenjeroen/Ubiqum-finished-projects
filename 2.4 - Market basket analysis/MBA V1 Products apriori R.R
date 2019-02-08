### 04-02-2019
#Market basket analysis V1.2: Use apriori and visualize data

####################################
#model 1: finding meaningfull rules#
####################################

Product_basket_analysis1 <- apriori(Task_4_full, parameter = list(support = (0.001),
                                            confidence = 0.001,
                                            minlen = 2))



Product_basket_analysis1 <- apriori(Task_4_full, parameter = list(support = (180/9832),
                                       confidence = 0.001,
                                       maxlen = 2))


#summary and toplists by category#
##################################

summary(Product_basket_analysis1)
inspect(sort(Product_basket_analysis1, by = "support")[1:15])
inspect(sort(Product_basket_analysis1, by = "confidence")[1:10])
inspect(sort(Product_basket_analysis1, by = "lift")[1:10])


arulesViz::ruleExplorer(Product_basket_analysis1)

plot(Product_basket_analysis1, method = "graph")
###############################
#model 2: raise support to 400#
###############################

Product_basket_analysis2 <- apriori(Task_4_full, parameter = list(support = (130/9832),
                                       confidence = 0.001,
                                       minlen = 3))
summary(Product_basket_analysis2)
inspect(sort(Product_basket_analysis2, by = "lift")[1:10])


arulesViz::inspectDT(Product_basket_analysis2)
arulesViz::ruleExplorer(Product_basket_analysis2)



###############################
#model 2: raise support to 600#
###############################

Product_basket_analysis3 <- apriori(Task_4_full, parameter = list(support = (80/9832),
                                       confidence = 0.001,
                                       minlen = 3))
summary(Product_basket_analysis3)
inspect(sort(Product_basket_analysis3, by = "lift")[1:10])




###############################
#model 2: raise support to 800#
###############################

Product_basket_analysis4 <- apriori(Task_4_full, parameter = list(support = (30/9832),
                                       confidence = 0.001,
                                       minlen = 3))

#identify dupplicate rules#
###########################

Product_basket_analysis4 <- Product_basket_analysis4[!is.redundant(Product_basket_analysis4)]  


summary(Product_basket_analysis4)
inspect(sort(Product_basket_analysis4, by = "lift")[1:10])
