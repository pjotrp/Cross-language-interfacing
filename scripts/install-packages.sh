#! /bin/sh
#
# This script installs some user land R packages, not yet in Debian

export R_LIBS=$HOME/R_libs
mkdir -p $R_LIBS

R -q --no-save --no-restore --no-readline --slave <<EOF
source("http://www.bioconductor.org/biocLite.R")
biocLite("GeneR")    
biocLite("Biostrings")    
EOF


