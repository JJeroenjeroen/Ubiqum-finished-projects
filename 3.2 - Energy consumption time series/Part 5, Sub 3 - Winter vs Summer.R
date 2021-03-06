#####################################################
# Date:      26-02-2019                             #
# Author:    Jeroen Meij                            #
# File:      Analysis of Smart Home electronic data #
# Version:   1.0                                    #    
#####################################################


#plot winter vs summer
###################################################


#make dataset displaying seasonal summary statistics of different sub-meters
df_quarterly_subm <- Full_dataset %>% 
  group_by(Quarter) %>% 
  summarise(Kitchen = mean(Sub_metering_1),
            Laundry_room = mean(Sub_metering_2),
            Heating = mean(Sub_metering_3))


#make a long dataset so its bettter usable in ggplot
df_quarterly_subm <- df_quarterly_subm %>% gather(Submeters, kWh, Kitchen:Heating)

#remove spring and fall 
df_quarterly_subm <- df_quarterly_subm %>% filter(Quarter == "Summer" | Quarter == "Winter")


#make a barplot displaying summer/winter differences per sub-meter
ggplot(df_quarterly_subm, aes(Submeters, kWh, fill = Quarter)) +
  geom_bar(stat="identity", width=.5, position = "dodge") + 
  
#generate lines that display the x-axis and that give the max for the y-axis  
  geom_hline(yintercept = 0, size = 1, colour="#333333") +
  geom_hline(yintercept = 8.5, size = 1, colour="white") +
  
#add label providing the percentage change in the kitchen  
  geom_label(aes(x = "Kitchen", y = 2, label = "-38%"), 
             hjust = -0.1, 
             vjust = 0,
             lineheight = 0.8,
             colour = "#555555", 
             fill = "white", 
             label.size = NA, 
             family="Helvetica", 
             size = 5) +
  
#add arrow for kitchen
  geom_curve(aes(x = "Kitchen", y = 3,
                 xend = "Kitchen", yend = 1.5), 
             colour = "#555555",
             position = "dodge",
             size = 0.8, 
             curvature = 0,
             arrow = arrow(length = unit(0.03, "npc")) ) +
  

#add label providing the percentage change in the laundry room  
  geom_label(aes(x = "Laundry_room", y = 2.5, label = "-35%"), 
             hjust = -0.1, 
             vjust = 0,
             lineheight = 0.8,
             colour = "#555555", 
             fill = "white", 
             label.size = NA, 
             family="Helvetica", 
             size = 5) +
  
  
#add arrow for laundry room  
  geom_curve(aes(x = "Laundry_room", y = 3.5,
                 xend = "Laundry_room", yend = 2), 
             colour = "#555555",
             position = "dodge",
             size = 0.8, 
             curvature = 0,
             arrow = arrow(length = unit(0.03, "npc")) ) +
  
  
  
#add label providing the percentage change for the heating-airco
  geom_label(aes(x = "Heating", y = 8.2, label = "-35%"), 
             hjust = -0.1, 
             vjust = 0,
             lineheight = 0.8,
             colour = "#555555", 
             fill = "white", 
             label.size = NA, 
             family="Helvetica", 
             size = 5) +
  
#add arrow for heating-airco
  geom_curve(aes(x = "Heating", y = 9.2,
                 xend = "Heating", yend = 7.7), 
             colour = "#555555",
             position = "dodge",
             size = 0.8, 
             curvature = 0,
             arrow = arrow(length = unit(0.03, "npc")) ) +
  
#add style  
  bbc_style() +
  theme(legend.position = "right",
        plot.subtitle=element_text(face="italic", color="deepskyblue4", size = 20),
        axis.text.x = element_text(hjust = 1, angle = 25, size = 17)) +

#manually color the bars    
  scale_fill_manual(values = c("#1380A1", "#FAAB18")) +

#add titles  
  labs(title="Winter vs. Summer",
       subtitle = "Differences in average daily kWh per subgroup") +
  
#scale x/y-axis  
  scale_x_discrete(labels = c("Heating", "Kitchen", "Laundry Room")) + 
  scale_y_continuous(breaks = c(0, 2.5, 5, 7.5, 8.5),
                     labels = c("0", "2.5", "5.0", "7.5", "kWh"))
