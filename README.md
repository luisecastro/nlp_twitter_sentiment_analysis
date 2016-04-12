Twitter Sentiment Analysis

This Shiny R application has an interface with Twitters API and request the last 'N' tweets, given a date range. 

The app displays information on the sentiment of the tweet (based on the content of positive/negative words of the Tweet according to predefined positive/negative words).

1- Request data through Twitter's API
2- Strip text data from stop words
3- Count positive/negative remaining words
4- Extract user devices and print them on a table
5- Plot graph

This has obvious caveats as negation "not good" should be negative but the word good itself is positive. Or words like Trump could be negative or positive depending on context.