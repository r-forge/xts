as.POSIXct.xtime <-
function(x, ...) {
  structure(unclass(x), class=c("POSIXct","POSIXt"))
}

