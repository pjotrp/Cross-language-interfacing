#! /bin/sh

export R_LIBS=$HOME/R_libs
mkdir -p $R_LIBS

R -q --no-save --no-restore --no-readline --slave <<EOF
source("http://www.bioconductor.org/biocLite.R")
biocLite("GeneR")    
EOF


