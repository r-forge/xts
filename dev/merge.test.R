library(xts)
library(quantmod)
dyn.load('merge.so')

load('m.rda')

`merge.xts` <- function(x,y,...,all=TRUE, fill=NA, suffixes=NULL) {
  # merge is currently optimized for the 2 case
  # scenario, but will handle k-merges via the overflow
  # ... arg.
  
  # still need an implementation with do_merge_xts
  # that can handle:
  #  suffixes=
  #
  if(length(all) == 1)
    all <- rep(all,2)

  dots <- list(...)
  if(length(all) != length(dots)+1)
    all <- rep(all,length.out=length(dots)+1)


  if(length(suffixes) != length(dots))
    suffixes <- NULL

  if(length(dots) > 3) {
    x <- .Call('do_merge_xts', x, y, all, fill[1])
#    cnames <- c( paste(suffixes[1],colnames(dots[[1]]),sep="."),
#                 paste(suffixes[2],colnames(dots[[2]]),sep=".") )
    for(i in 3:length(dots)) {
#      cnames <- c( cnames, paste(suffixes[i],colnames(dots[[i]]),sep=".") )
      x <- .Call('do_merge_xts', x, dots[[i]], all, fill[1])
    }
    # colnames is _horribly_ slow.  this has to be moved to C
#    colnames(x) <- cnames
    return(x)
  } else {
#    cnames <- c( paste(suffixes[1],colnames(dots[[1]]),sep="."),
#                 paste(suffixes[2],colnames(dots[[2]]),sep=".") )
    x <- .Call('do_merge_xts', x, y, all, fill[1])
    
#    colnames(x) <- cnames
    return(x)
  }
}

merge.xts0 <- function(x,y,...,all=TRUE, fill=NA) {
  dots <- list(...)
  if(length(all) != length(dots)+1)
    all <- rep(all,length.out=length(dots)+1)


  if(length(dots) > 0) {
    x <- .Call('do_merge_xts',x,y,all[1],fill[1])
    for(i in 1:length(dots)) {
      x <- .Call('do_merge_xts',x,dots[[i]],all[i+1],fill[1])
    }
    return(x)
  } else .Call('do_merge_xts',x,y,all[[1]],fill[1])
}

x1 <- xts(matrix(as.numeric(1:10),nc=2), as.Date('2008-01-01')+1:5)
x2 <- xts(matrix(as.numeric(1:10),nc=2), as.Date('2008-01-04')+1:5)
x3 <- xts(matrix(as.numeric(1:10),nc=1), as.Date('2008-01-04')+1:10)

colnames(x1) <- c("Aa", "Bb")
colnames(x2) <- c("Cc", "Dd")

s1 <- xts(matrix(letters[2:11],nc=1), as.Date('2008-01-01')+1:10)
s2 <- xts(matrix(letters[1:10],nc=2), as.Date('2008-01-01')+1:5)

merge(x1,x2, fill=0, suffixes=c("X","Y"))

int1 <- .xts(1:1e6, 1:1e6, 'POSIXct')
int2 <- .xts(1:1e6, 1:1e6, 'POSIXct')

system.time(merge(int1, int2))

rm(int2,int1)
x1
x2

(mx <- merge(merge(x1,x2),x3))
(mx <- merge(merge(x1,x2),x3,all=FALSE))

str(mx)

(mx <- merge(x1,x2,x3,x3,x2,all=TRUE) )
#getSymbols("QQQQ;DIA")

#(mx <- merge(QQQQ,DIA)[1:10])

#str(mx)
#mjxts2(x1,x2)

#merge(x1,x3)

#merge(x2,x3)

gc()
giantxts <- .xts(1:1e6,1:1e6, 'POSIXct')
#system.time(isOrdered(giantxts))
gc()
system.time(.Call('do_merge_xts', giantxts, giantxts, TRUE, NA))
gc();
system.time(merge(giantxts, giantxts)) # a new 2 million obs
dim(merge(giantxts, giantxts)) # a new 2 million obs
gc();
system.time(merge(giantxts, giantxts, giantxts)) # 3 million obs
gc(); rm(giantxts); gc()
giantxts <- .xts(as.numeric(1:3e6),as.numeric(1:3e6), 'POSIXct')
system.time(merge(giantxts, giantxts)) # a new 6 million obs
system.time(merge(merge(giantxts, giantxts), giantxts))
gc()
#zz <- as.zoo(giantxts)
#rm(giantxts)
#system.time(merge(zz,zz))
#mjxts2(x1,x2)
