## Need to create an account with the API (not Twitter directly)
## https://apps.twitter.com/
## My user name is "blindfuzzyghost"
## https://dev.twitter.com/docs/api/1.1/get/search/tweets

library(httr)

## You'll get the tokens and keys form the twitter app website
myapp = oauth_app("twitter",
                  key="yourConsumerKeyHere",secret="yourConsumerSecretHere")
sig = sign_oauth1.0(myapp,
                    token = "yourTokenHere",
                    token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

json1=content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]