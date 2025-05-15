library(tidyverse)
library(magrittr)
library(ggpol)
library(corrplot)

#Data Import and Cleaning
#Import Dataset in the R Studio Environment

#Imported using the environment in R studio:
#> Airline_review <- read_csv("Your Path Here", 
#                             +     col_types = cols(Review_Title = col_skip(), 
#                                                    +         Aircraft = col_skip(), `Date Flown` = col_skip(), 
#                                                    +         Recommended = col_factor(levels = c("yes", 
#                                                                                                  +             "no"))))
#                                                                                             +   "no"))))

Airline_review <- Airline_review %>%
  mutate (
    `Review Date`=str_remove_all(`Review Date`,"(st|nd|rd|th)"),
    `Review Date`=dmy(`Review Date`)
  )

Airline_review$Overall_Rating %<>% as.integer

#Data Exploration and Visualization
#Just some basic graphs and stuff for the heck of it (:

#Boxplot of Overall Rating depending on if Reviewer recommends Airline
recommender_boxplot <- ggplot(Airline_review, aes(x=Recommended, y=Overall_Rating,fill=Recommended))+
  geom_boxjitter(jitter.color = 'grey',
  errorbar.draw = T,
  errorbar.length = 0.2)+
  ggtitle("Distribution of Ratings")+
  ylab("Overall Rating")+
  theme(plot.title=element_text(hjust=0.5))

recommender_boxplot

#Overall Rating by Seat Type
seat_mean <- Airline_review %>%
  filter(!is.na(Overall_Rating)) %>%
  filter(!is.na(`Seat Type`)) %>%
  group_by(`Seat Type`) %>%
  summarise(mean=mean(Overall_Rating),n=n())

seat_mean

seat_bargraph <- ggplot(seat_mean, aes(x=`Seat Type`,y=mean, fill=`Seat Type`))+
  geom_bar(stat="identity")+
  scale_fill_brewer(palette = "Set3")+
  scale_y_continuous(limits = c(0, 10),breaks = 0:10)+
  ggtitle("Average Rating of Different Seat Types")+
  ylab("Average")+
  theme(plot.title=element_text(hjust=0.5))

seat_bargraph

#Correlation matrix and Basic Linear Regression
corr_columns <- Airline_review %>%
  select("Overall_Rating","Seat Comfort":"Value For Money")

corr_columns 

corr <- cor(corr_columns, use="pairwise.complete.obs", method="kendall")

corr_plot <- corrplot(corr,method="shade", main="Correlation between Ratings", mar=c(1,2,2,2))


#Dataset for Sentiment Analysis
sentiment_data <- Airline_review %>%
  select("Airline Name","Overall_Rating","Review")


