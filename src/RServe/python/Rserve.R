# Fire up the Rserve server
#
# Usage:
#
#  R -q --no-save --no-restore --no-readline --slave < Rserve.R

library(Rserve)
Rserve(args="--no-save")