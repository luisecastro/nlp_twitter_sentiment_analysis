#Include needed libraries
library(shiny)
library(markdown)
library(twitteR)
library(ROAuth)
library(dplyr)

load("id.RData")
load("ps.RData")
load("ng.RData")
load("stop.RData")

#Twitter authentication
setup_twitter_oauth(consumer_key=id$ck,
                    consumer_secret=id$cs,
                    access_token=id$at,
                    access_secret=id$as)

#Functions needed
final <- function(text,num,from,to){
    tweets <- twListToDF(searchTwitter(searchString=text,n=num,lang="en",since=from,until=to,
                                       locale=NULL,geocode=NULL,sinceID=NULL,maxID=NULL,
                                       resultType=NULL,retryOnRateLimit=5))
    
    results <- data.frame(matrix(unlist(lapply(tweets$text,wrapper)),ncol=3,byrow=T))
    results[,3] <- as.integer(as.character(results[,3]))
    results$win <- ifelse(results[,3]>0,1,ifelse(results[,3]<0,-1,0))
    colnames(results) <- c("positive","negative","result","win") 
    results$result <- as.integer(as.character(results$result))
    results$cumsum <- cumsum(results$win)
    cbind(tweets,results)
}

sources <- function(x){
    resources <- function(y) substring(y,gregexpr(">",y)[[1]][1]+1,
                                       gregexpr("<",y)[[1]][2]-1)
    tgram(unlist(lapply(x,resources)))
}

pre <- function(x,ic,ws,pc,tl,num){
    if(ic) x <- iconv(x,"latin1","ASCII")
    if(!ic) x <- iconv(x,"latin1","UTF-8")
    if(pc) x <- gsub("(?!')[[:punct:]]+","",x,perl=TRUE)
    if(num) x <- gsub("[[:digit:]]+","",x,perl=TRUE)
    x <- gsub("^'+| '+|'+ |'+$","",x,perl=TRUE)
    if(tl) x <- tolower(x)
    x <- gsub(" +"," ",x,perl=TRUE)
    x <- gsub("\r|\n","",x)
    if(ws) x <- gsub("^ +| +$","",x,perl=TRUE)
    x 
}

pos <- function(x){
    x <- x[!is.na(x)]
    x <- x[nchar(x)>0]
    x[x!=" "]
}

tgram <- function(x){
    x <- sort(table(x),decreasing=TRUE,method="quick")
    data.frame(ngrams=names(x),count=as.numeric(x))
}

ngram <- function(x){
    len <- length(x)
    return(data.frame(ngram=x[1:(len-1)],count=x[2:len]))
}

wrapper <- function(x){
    x <- strsplit(x," ")[[1]] %>% pre(T,T,T,T,T) %>% pos()
    x <-  x[!(x %in% stopWords)]
    pos_words <- x[(x %in% ps)]
    neg_words <- x[(x %in% ng)]
    pLen <- length(pos_words)
    nLen <- length(neg_words)
    c(ifelse(pLen>0,paste(pos_words,collapse=" "),"NONE"),
      ifelse(nLen>0,paste(neg_words,collapse=" "),"NONE"),
      length(pos_words)-length(neg_words))
}