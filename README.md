Twitter Sentiment Analysis

This Shiny R application has an interface with Twitters API and request the last 'N' tweets, given a date range. 

The app displays information on the sentiment of the tweet (based on the content of positive/negative words of the Tweet according to predefined positive/negative words). 

The project is hosted in: [Twitter_analysis](https://luislundquist.shinyapps.io/twitter_analysis/)

1- Request data through Twitter's API
2- Strip text data from stop words
3- Count positive/negative remaining words
4- Extract user devices and print them on a table
5- Plot graph

This has obvious caveats as negation "not good" should be negative but the word good itself is positive. Or words like Trump could be negative or positive depending on context.

The user interaction begins by typing a word to search within the tweets, specifying the amount of tweets and then setting a date range.

- **ui.R**: is the user interface configuration, it sets how the app is visualized and interacted with.
- **server.R** this file is the flow control of the application, receiving the inputs from ui.R and generating outputs to it.
- **global.R**: This is an auxiliary file where some functions are defined to be later called by global.R