# R-Sentiment-Analysis
## Description
R Project that aims to gather some general insights around airlines and perform a basic sentiment analysis of airline reviews.

## Contents and Insights
### Data Exploration
-Loading and Cleaning Data.
-Distribution of Ratings
An interesting insight from this graph is that the inter-quartile range for a "Yes" recommendation is much larger than "No", with some reviewers even giving the airline the lowest possible score but still recommending it.
![alt text](<Distribution of Ratings.png>)

-Average Rating of Different Seat Types
Business class has the highest average rating at 4.4, with both Economy and Premium Economy having the lowest average rating at 3.
![alt text](<Average Rating of Different Seat Types.png>)

-Correlation between Ratings (only fully completed entries)
All rating metrics have a positive correlation meaning all the metrics have a postive linear relationship, although the strength of those relationships varies between rating metrics.
![alt text](<Correlation between Ratings.png>)

-Data Preparation for Sentiment Analysis

### Sentiment Analysis
Afinn lexicon was used to provide sentiment scores to the reviews. The mean of the sentiment scores were compared to the mean of the overall rating of each airline. This relationship is illustrated in the graph below
![alt text](<Sentiment vs. Rating Average.png>)

## Data Source
Airline Reviews was sourced from Kaggle (https://www.kaggle.com/datasets/juhibhojani/airline-reviews) under Database Contents License (https://opendatacommons.org/licenses/dbcl/1-0/)

## Author
Mikayla Hinrichsen
