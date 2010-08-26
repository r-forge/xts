as.POSIXlt.xtime <-
function(x, tz="", ...) {
  as.POSIXlt(structure(unclass(x), class=c("POSIXct","POSIXt")), tz="")
}

