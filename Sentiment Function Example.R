## Sentiment Function
## filePath<-"C:\\Users\\jxs056\\Desktop\\volkswagen emissions call.txt"

sentiment<- function(filePath){
        
        text<- readLines(filePath)
        SentenceBreakdown <-get_sentences(text)  
        SentimentValue<-get_sentiment(SentenceBreakdown)
      
        plot(SentimentValue,main="Trajectory",xlab="Setence Number",
             ylab="Emotional Valence")
        sum(SentimentValue)
}
##problems: it thinks that "i'm not sad" is a bad sentence. Example Below
sampletext<-"I haven't been sad in a long time. I am extremely happy today. It's a good day. But suddenly I'm only a little bit happy. Then I'm not happy at all. In fact, I am now the least happy person on the planet. There is no happiness left in me. Wait, it's returned! I don't feel so bad after all!"
sampleSB<-get_sentences(sampletext)
get_sentiment(sampleSB)


##volksfilepath<-"C:\\Users\\jxs056\\Desktop\\volkswagen emissions call.txt"
##applefilepath<-"C:\\Users\\jxs056\\Desktop\\apple call.txt"

## barplot(sort(colSums(prop.table(get_nrc_sentiment(volksSB)))),horiz=TRUE,cex.names=0.7,las=1,main="Emotions",xlab="Percentage")
## barplot(sort(colSums(prop.table(get_nrc_sentiment(appleSB)))),horiz=TRUE,cex.names=0.7,las=1,main="Emotions",xlab="Percentage")