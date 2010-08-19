as.Date.xtime <-
function(x, ...) {
  as.Date(as.character(structure(unclass(x), class=c("POSIXct","POSIXt"))))
}

