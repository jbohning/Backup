# Bloomberg Exploration
# Package details at: 
# https://cran.r-project.org/web/packages/Rblpapi/Rblpapi.pdf
# Examples from: 
# http://blog.revolutionanalytics.com/2015/06/connect-r-to-bloomberg.html

library(Rblpapi)

#Open Bloomberg Connection:
blpConnect()


#Grab Volume and last price:
bdp("SPY US Equity",c("PX_LAST","VOLUME"))

#Grab the top 20 holders and it returns: Amount Held; Country; Filing Date; 
#Holder Name; Institution Type; Latest Change; Metra Area; Percent Outstanding;
#Portfolio Name; Source
bds("GOOG US Equity","TOP_20_HOLDERS_PUBLIC_FILINGS")

#Grab a time series of last prices and volume (over last 31 days):
bdh("SPY US Equity", c("PX_LAST", "VOLUME"), start.date=Sys.Date()-31)

#GetBars: retreives bars for the security (times, open, high, low, close, 
#numEvents, volume & value)
getBars("ESA Index", startTime=ISOdatetime(2015,1,1,0,0,0))

#I'm not sure what this does
getTicks("ESA Index", "TRADE", Sys.time()-60*60)

#Field search: to look for the codes for a value/stat
fieldSearch("VWAP")
fieldSearch("RETURN")

#Get index members and their weights
bds("INDU INDEX","INDX_MWEIGHT")
#For a Specific Date (it does not average the dates if you enter more than one date)
bds("INDU INDEX","INDX_MWEIGHT",overrides = c("START_DT"="20150101", "END_DT"="20150101"))





