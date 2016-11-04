# Retrieving Tweets

library(twitteR)
library(ROAuth)
library(RCurl)
library(stringr)
library(tm)
library(ggmap)
library(dplyr)
library(plyr)
library(wordcloud)
library(devtools)
library(httr)

#Twitter Authentication (only need to do the first time, then restart and
#reinstall libraries)
devtools::install_version("httr", version="0.6.0", 
                          repos="http://cran.us.r-project.org")

my_key="A7HkCdru2ABobiZVvT8puUf8u"
my_secret="JVbMVX9ldi7g0dqH5zOPRoSPziv22U2JLFT0pt4soci8ZDbBEp"
my_access_token="781156166818598912-GZwnEKYYgk7v5TVvuQjeP2KDcVsp2yi"
my_access_secret="9Q286sKD5cfgrpTVF9QRvTJl7o9SIITQGo1DI4Tqh5Z9j"

#necessary file for Windows
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")


setup_twitter_oauth(my_key, my_secret, my_access_token, my_access_secret)


tweets<-userTimeline("RDataMining",n=3200)

##convert tweets to a data frame
tweets.df<-twListToDF(tweets)
