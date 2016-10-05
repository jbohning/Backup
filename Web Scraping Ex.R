## Web scraping example

con = url ("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode=readLines(con)

## Always close your connection after you use it
close(con)

## Only enter if you want to see A LOT of lines:
## htmlCode

## Use the XML package to make sense of the data
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html<-htmlTreeParse(url,useInternalNodes=T)

## Get the title of the page
xpathSApply(html,"//title",xmlValue)

## Get the number of times the papers have been cited by
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)



## Another possible method: GET from the httr package
## install.packages("httr")

library("httr")
html2=GET(url)
content2=content(html2,as="text")
parsedHtml=htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml,"//title",xmlValue)


## Accessing websites with passwords
pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd"))
pg2
names(pg2)


## Using handles: allows you to save the authentication
google=handle("http://google.com")
pg1=GET(handle=google,path="/")
pg2=GET(handle=google,path="search")

## More examples: http://cran.r-project.org/web/packages/httr/httr.pdf
## http://www.r-bloggers.com/?s=Web+Scraping
## http://cran.r-project.org/web/packages/httr/httr.pdf





