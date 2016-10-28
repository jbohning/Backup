## World Cloud Example
## http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know

library("tm") ## for text mining
library("SnowballC") ## for text stemming (gets words to their roots: ex changes
## "moving" or "movement" to "move")
library("wordcloud") ## word-cloud generator
library("RColorBrewer") ## for color palettes

## Read the text file
filePath<- "http://www.sthda.com/sthda/RDoc/example-files/martin-luther-king-i-have-a-dream-speech.txt"
text<- readLines(filePath)
##PDFs on the desktop


## Load the data as a corpus
docs<-Corpus(VectorSource(text))

## you can use inspect(docs) to see the content of the document


##Text Transformation
toSpace<-content_transformer(function (x,pattern) gsub(pattern,"",x))
docs<-tm_map(docs,toSpace,"/")
docs<- tm_map(docs,toSpace,"@")
docs<- tm_map(docs,toSpace,"\\|")

##Convert the text to lower case
docs<-tm_map(docs,content_transformer(tolower))

## Remove numbers
docs<-tm_map(docs, removeNumbers)

##Remove english common stopwords
docs<-tm_map(docs,removeWords,stopwords("en"))

## Remove your own stop words
## docs<-tm_map(docs,removeWords,c("InsertWord1Here", "InsertWord2Here"))


## Remove punctuation
docs<-tm_map(docs,removePunctuation)

docs<-tm_map(docs,stripWhitespace)

##Text stemming
## docs<-tm_map(docs,StemDocument)




## Build a term-document matrix (a document matrix is a table containing the 
## frequency of the words)
dtm<-TermDocumentMatrix(docs)
m<-as.matrix(dtm)
v<-sort(rowSums(m),decreasing=TRUE)
d<-data.frame(word=names(v),freq=v)
head(d,10)


## Find frequent terms and their associations
findFreqTerms(dtm,lowfreq=4)

##You can analyze the association between frequent terms using findAssocs().
## The followed code below indntifies which words are associated with "freedom"
findAssocs(dtm, terms="freedom", corlimit=0.3)


##The frequency of table of words
head(d,10)

##Plot word frequencies (top 20)
barplot(d[1:20,]$freq, las=2, names.arg=d[1:20,]$word,col="lightblue",
        main="Most frequent words", ylab="Word frequencies")





