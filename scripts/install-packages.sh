#! /bin/sh

R -q --no-save --no-restore --no-readline --slave <<EOF
source("http://www.bioconductor.org/biocLite.R")
biocLite("GeneR")    
EOF
