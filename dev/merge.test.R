library(xts)
library(quantmod)
dyn.load('merge.so')

load('m.rda')

merge.xts <- function(x,y,...,all=TRUE) {
  dots <- list(...)
  if(length(all) != length(dots)+1)
    all <- rep(all,length.out=length(dots)+1)


  if(length(dots) > 0) {
    x <- .Call('do_merge_xts',x,y,all[1])
    for(i in 1:length(dots)) {
      x <- .Call('do_merge_xts',x,dots[[i]],all[i+1])
    }
    return(x)
  } else .Call('do_merge_xts',x,y,all[[1]])
}

x1 <- xts(matrix(as.numeric(1:10),nc=2), as.Date('2008-01-01')+1:5)
x2 <- xts(matrix(as.numeric(1:10),nc=2), as.Date('2008-01-04')+1:5)
x3 <- xts(matrix(as.numeric(1:10),nc=1), as.Date('2008-01-04')+1:10)

x1
x2

(mx <- merge(merge(x1,x2),x3))

str(mx)

(mx <- merge(x1,x2,x3,x3,x2,all=TRUE) )
#getSymbols("QQQQ;DIA")

#(mx <- merge(QQQQ,DIA)[1:10])

#str(mx)
#mjxts2(x1,x2)

#merge(x1,x3)

#merge(x2,x3)

#gc()
giantxts <- .xts(as.numeric(1:1e6),as.numeric(1:1e6), 'POSIXct')
#system.time(isOrdered(giantxts))
#gc()
system.time(.Call('do_merge_xts', giantxts, giantxts, TRUE))
system.time(merge(giantxts, giantxts)) # a new 2 million obs
system.time(merge(giantxts, giantxts, giantxts)) # 3 million obs
giantxts <- .xts(as.numeric(1:3e6),as.numeric(1:3e6), 'POSIXct')
system.time(merge(giantxts, giantxts)) # a new 6 million obs
system.time(merge(merge(giantxts, giantxts), giantxts))
#gc()
#zz <- as.zoo(giantxts)
#rm(giantxts)
#system.time(merge(zz,zz))
#mjxts2(x1,x2)
