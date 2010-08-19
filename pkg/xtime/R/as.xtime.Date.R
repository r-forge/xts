as.xtime.Date <-
function(x, ...) {
  tzone <- attr(x, "tzone")
  if(is.null(tzone))
    tzone <- Sys.getenv("TZ")
  tm <- structure(unclass(as.POSIXct(as.character(x))), tzone=tzone, tclass="Date", class="xtime")
  tm
}

