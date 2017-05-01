.onAttach <- function(...){
  # Suggests quantmod to user of OHLC plot.xts
  assign(".QUANTMOD_MESSAGE", TRUE, .GlobalEnv)

  repo <- "https://github.com/joshuaulrich/xtsExtra"
  packageStartupMessage(
    "WARNING: this package was installed from R-Forge, but development has\n",
    "moved to GitHub. Please re-install the package using the GitHub repo at:\n",
    repo, ".")
}
