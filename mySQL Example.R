## Install RMySQL
## Website: http://dev.mysql.com/doc/refman/5.7/en/osx-installation.html

##install.packages("RMySQL")
library("RMySQL")

## website referred to in lecture: http://genome.ucsc.edu/goldenPath/help/mysql.html

ucscDb <- dbConnect(MySQL(),user = "genome", 
                    host = "genome-mysql.cse.ucsc.edu")
result<-dbGetQuery(ucscDb,"show databases;");dbDisconnect(ucscDb);
hg19 <- dbConnect(MySQL(),user="genome", db="hg19",
                  host="genome-mysql.cse.ucsc.edu")
allTables[1:5]
dbListFields(hg19,"affyU133Plus2")
dbGetQuery(hg19,"select count(*)from affyU133Plus2")

affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)

## Check for top ten records
affyMisSmall<-fetch(query,n=10);dbClearResult(query)
dim(affyMisSmall)

## ALWAYS CLOSE THE CONNECTION AT THE END
dbDisconnect(hg19)