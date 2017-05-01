if(getRversion() < "2.11.0") {
    .POSIXct <- function(xx, tz = NULL)
    structure(xx, class = c("POSIXt", "POSIXct"), tzone = tz) 
}

.onAttach <- function(libname, pkgname) {
  repo <- "https://github.com/joshuaulrich/xtime"
  packageStartupMessage(
    "WARNING: this package was installed from R-Forge, but development has\n",
    "moved to GitHub. Please re-install the package using the GitHub repo at:\n",
    repo, ".")
}
