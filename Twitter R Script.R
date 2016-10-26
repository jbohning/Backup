## Retrieving Tweets
## http://www.rdatamining.com/docs/twitter-analysis-with-r

##install.packages("twitteR")
library(twitteR)
##install.packages("ROAuth")
library(ROAuth)

##Twitter Authentication
setup_twitter_oauth(consumer_key="A7HkCdru2ABobiZVvT8puUf8u",
                    consumer_secret="JVbMVX9ldi7g0dqH5zOPRoSPziv22U2JLFT0pt4soci8ZDbBEp")
tweets<-userTimeline("RDataMining",n=3200)

##convert tweets to a data frame
tweets.df<-twListToDF(tweets)

##save tweets.df backup
backup<-tweets.df

##tweet #190
## tweets.df[190,c("id","created","screenName","replyToSN","favortieCount",
##                "favoriteCount","retweetCount","longitude","latitude","text")]

## print tweet #190 and make it text fit for slide width
## writeLines(strwrap(tweets.df$text[190],60))

##Text Cleaning
##install.packages("tm")
library(tm)

## build a corpus, and specific the source to be character vectors (FYI, Corpora
## are collections of documents containing (natural language) text.)
myCorpus<- Corpus(VectorSource(tweets.df$text))

## Convert to lower case
myCorpus<- tm_map(myCorpus,content_transformer(tolower))

## remove URLs
removeURL<- function(x) gsub("http[^[:space:]]*","",x)
myCorpus<- tm_map(myCorpus, content_transformer(removeURL))

## remove anything other than English letters or spaces
removeNumPunct<-function(x) gsub("[^[:alpha:][:space:]]*","",x)
myCorpus<-tm_map(myCorpus, content_transformer(removeNumPunct))

## remove stopwords
myStopwords<- c(setdiff(stopwords('english'),c("r","big")),"use","see","used",
                "via","amp")
myCorpus<-tm_map(myCorpus, removeWords, myStopwords)

## remove extra whitespace
myCorpus<- tm_map(myCorpus, stripWhitespace)

## keep a copy for stem completion later
myCorpusCopy<-myCorpus
myCorpus<- tm_map(myCorpus, stemDocument)
writeLines(strwrap(myCorpus[[190]]$content,60))

## r refer card data mine now provide link package cran package
stemCompletion2<-function(x,dictionary){
        x<-unlist(strsplit(as.character(x),""))
        x<-x[x!=""]
        x<-stemCompletion(x,dictionary=dictionary)
        x<-paste(x,sep="",collapse = "")
        PlainTextDocument(stripWhitespace(x))
}
myCorpus<-lapply(myCorpus,stemCompletion2,dictionary=myCorpusCopy)
myCorpus<- Corpus(VectorSource(myCorpus))
writeLines((strwrap(myCorpus[[190]]$content,60)))


## Country Word Frequency
wordFreq<-function(corpus,word){
        results<-lapply(corpus, function(x){
                grep(as.character(x),pattern=paste0("\\<",word))
        })
        sum(unlist(results))
}

## Build Term Document Matrix
## If you run into errors replace myCorpus with myCorpus copy in tdm
tdm<-TermDocumentMatrix(myCorpus, control=list(wordLengths=c(1,Inf)))
idx<-which(dimnames(tdm)$Terms %in% c("r","data","mining"))
as.matrix(tdm[idx,21:30])

## Top Frequent Terms
(freq.terms<-findFreqTerms(tdm,lowfreq=20))
term.freq<-rowSums(as.matrix(tdm))
term.freq<-subset(term.freq, term.freq>=20)
df<-data.frame(term=names(term.freq),freq=term.freq)

library(ggplot2)

ggplot(df,aes(x=term,y=freq)) + geom_bar(stat="identity")+ xlab("Terms") +
        ylab("Count") + coord_flip() + theme(axis.text=element_text(size=7))


## Word Cloud
m<- as.matrix(tdm)
##Calculate the frequency of words and sort it by frequency
word.freq<-sort(rowSums(m),decreasing = T)
#colors
pal<- brewer.pal(9,"BuGn")[-(1:4)]

## plot word cloud
#3 install.packages("wordcloud")
library(wordcloud)

wordcloud(words=names(word.freq),freq=word.freq,min.freq=3,random.order=F,
          colors=pal)
