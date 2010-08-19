as.xtime.POSIXt <-
function(x, ...) {
  tzone <- attr(x, "tzone")
  if(is.null(tzone))
    tzone <- Sys.getenv("TZ")
  if(inherits(x, "POSIXct"))
    tm <- structure(unclass(x), tzone=tzone, tclass="POSIXct", class="xtime")
  if(inherits(x, "POSIXlt"))
    tm <- structure(unclass(x), tzone=tzone, tclass="POSIXlt", class="xtime")
  tm
}

