# internal package environment for use with lines.xts
# Do we still need this env?
.xtsEnv <- new.env()

# Environment for our xts chart objects (xts_chob)
.plotxtsEnv <- new.env()

.onLoad <- function(libname, pkgname)
{
#  if(Sys.getenv("TZ") == "") {
#    packageStartupMessage("xts now requires a valid TZ environment variable to be set")
#    packageStartupMessage(" no TZ var is set, setting to TZ=GMT")
#    Sys.setenv(TZ="GMT")
#  } else {
#    packageStartupMessage("xts now requires a valid TZ environment variable to be set")
#    packageStartupMessage(" your current TZ:",paste(Sys.getenv("TZ")))
#  }
}

if(getRversion() < "2.11.0") {
    .POSIXct <- function(xx, tz = NULL)
    structure(xx, class = c("POSIXt", "POSIXct"), tzone = tz)
}

.onAttach <- function(libname, pkgname) {
  repo <- "https://github.com/joshuaulrich/xts"
  packageStartupMessage(
    "WARNING: this package was installed from R-Forge, but development has\n",
    "moved to GitHub. Please re-install the package using the GitHub repo at:\n",
    repo, ".")
}
