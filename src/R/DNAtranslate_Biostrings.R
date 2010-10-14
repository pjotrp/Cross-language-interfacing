# Sequence translation with R
#
# Usage:
#
#   env BATCH_VARS="file.fa [n]" R -q --no-save --no-restore --no-readline --slave < translate.R
#
# Example:
#
#   time  env BATCH_VARS="../../test/data/test-dna.fa 2" R -q --no-save --no-restore --no-readline --slave < DNAtranslate_Biostrings.R 

fasta = '../../test/data/test-dna.fa'

args<-strsplit(Sys.getenv('BATCH_VARS'),' ')
fasta = args$BATCH_VARS[1]
times = as.integer(args$BATCH_VARS[2])

cat("File=",fasta)

if (is.na(times)) { times = 1 }

library(GeneR)
library(Biostrings)

for (i in 1:times) {
  myseq1 <- readFASTA(fasta, strip.descs=T) 
  myseq2 <- lapply(myseq1, function(x) x$seq)
  n = 0
  for (ntseq in myseq2) {
    aaseq = strTranslate(ntseq)
    cat(">(",n,")\n",aaseq,"\n",sep="")
    n = n+1
  }
}
