# installing and loading packages
require(strucchange)
require(wtss.R)

# create a connection using a serverUrl
server = WTSS("http://www.dpi.inpe.br/tws/wtss")

# get the list of coverages provided by the service
coverages = listCoverages(server)

# get the description of the third coverage
cv = describeCoverage(server, coverages[2])

# Get a time series
spatio_temporal = timeSeries(server, names(cv), attributes=cv[[names(cv)]]$attributes$name[1], latitude=-10.408, longitude=-53.495, start="2000-02-18", end="2016-01-01")

# time series in a ts object with part of the original values
time_series_ts1 = ts(coredata(spatio_temporal[[names(cv)]]$attributes[,1]), freq=365.25/(as.numeric(difftime(index(spatio_temporal[[names(cv)]]$attributes[2]),index(spatio_temporal[[names(cv)]]$attributes[1]),units = "days"))), start=decimal_date(ymd(index(spatio_temporal[[names(cv)]]$attributes[1]))))

# analysis using strucchange
fs.nile <- Fstats(time_series_ts1 ~ 1)

# plot fs.nile
plot(fs.nile)

# breakpoints
bk <- breakpoints(fs.nile)

# plot breakpoints
lines(bk)
