library(tidyverse)
library(tidytext)
library(textdata)
library(plotly)
library(stringdist)

#Sentiment Analysis vs Ratings
review_words <- sentiment_data %>%
  unnest_tokens(word, Review)

load_sentiment <- get_sentiments("afinn")

review_sentiment <- review_words %>% 
  inner_join(load_sentiment,by="word")

sentiment_summary <- review_sentiment %>%
  group_by(`Airline Name`) %>%
  summarise(sentiment_score=mean(value, na.rm=TRUE)+5)
#Note: 5 added to match range of overall_rating

rating_summary <- sentiment_data %>% 
  group_by(`Airline Name`) %>%
  summarise(rating_score=mean(Overall_Rating,na.rm=TRUE))

final_summary <- sentiment_summary %>%
  left_join(rating_summary, by="Airline Name")

final_summary

airline_graph <- ggplot(final_summary,aes(x=rating_score,y=sentiment_score, color= rating_score))+
  geom_point()+
  scale_color_gradient(low="red", high="green")+
  ggtitle("Sentiment vs. Rating Average per Airline")+
  scale_x_continuous(limits = c(0, 10),breaks = 0:10)+
  scale_y_continuous(limits = c(0, 10),breaks = 0:10)+
  xlab("Average Rating")+
  ylab("Average Sentiment")+
  theme(plot.title=element_text(hjust=0.5))+
  theme(legend.position="none")

airline_graph


