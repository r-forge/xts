as.xtime.Date <-
function(x, ...) {
  tzone <- attr(x, "tzone")
  if(is.null(tzone))
    tzone <- Sys.getenv("TZ")
  tm <- structure(unclass(as.POSIXct(as.character(x))), tzone=tzone, tclass="Date", class="xtime")
  tm
}

as.xtime.dates <-
function(x, ...) {
    structure(as.numeric(as.POSIXct(strptime(as.character(x),"(%m/%d/%y %H:%M:%S)"))),
              tzone=Sys.getenv("TZ"), tclass=class(x), class="xtime")
}
