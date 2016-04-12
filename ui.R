shinyUI(
    navbarPage("Twitter Sentiment",id="nav",
        tabPanel("Applications",tags$head(includeCSS("styles.css")),
                tabsetPanel(type="tabs",
                    tabPanel("Visualization",
                        fluidRow(
                            column(4,
                                wellPanel(
                                    h4("Sentiment Analysis"),
                                    helpText("Type the word(s) you wish to analyse."),
                                    textInput("text",label="Text input",value="Tacos"),
                                    sliderInput("tweets","# of Tweets",min=1,max=100,value=50),
                                    dateRangeInput('dateRange',
                                                   label = paste('Date range:'),
                                                   start = Sys.Date()-1,end=Sys.Date(),
                                                   min=Sys.Date() - 3650, max = Sys.Date(),
                                                   separator = " - ", format = "dd/mm/yy",
                                                   startview = 'year', language = 'en', weekstart = 1
                                    ),
                                    actionButton("go","Search Tweets",width='130px'),
                                    hr(),
                                    wellPanel(
                                        HTML('<small><p align="justify"',
                                            markdownToHTML(fragment.only=TRUE, text=c("`Text Input`: Type the words you wish to analyse on Twitter, use + to separate query terms.
                                                                        \n`# of Tweets`: Amount of tweets to return, subject to availability of the searched terms.
                                                                        \n `Date range`: Date of requested tweets.
                                                                        \n `Search Tweets`: Starts the process.
                                                                        \n `Positive` = positive sentiment; `Negative` = negative sentiment"
                                                                                    )
                                                                                ),
                                                            "</small></p>"),
                                    hr(),
                                        HTML('<table border ="0" width="80%">
                                            <tr><td><font color= "#999999">Code by <b>Luis E Castro</b></td>
                                            <td><a href="mailto:luis.quiros@gmail.com"><img src="gmail.gif"></a>&nbsp;</td>
                                            <td><a href=https://twitter.com/luis_lundquist><img src="twitter.png"></a>&nbsp;</td> 
                                            <td><a href=https://linkedin.com/in/luisquiros><img src="linkedin.gif"></a>&nbsp;</td>
                                            <td><a href=https://github.com/luisecastro><img src="github.png"></a>&nbsp;</td></tr></table>
                                            ')
                                            )
                                        )
                                    ),
                            column(4,
                                h6("The word(s) you typed"),
                                wellPanel(span(textOutput("textual"),style="color:#999999")),
                                h6("Sentiment Analysis plot"),
                                wellPanel(span(plotOutput('plot'))
                                          
                                          )
                                ),
                            column(4,
                                   h6("Device used for Tweet"),
                                   span(dataTableOutput('table')))
                            ))
                )
            )



                             
            )
        )
