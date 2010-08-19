as.POSIXlt.xtime <-
function(x, ...) {
  as.POSIXlt(structure(unclass(x), class=c("POSIXct","POSIXt")))
}

