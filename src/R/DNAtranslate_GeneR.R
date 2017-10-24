# Sequence translation with R
#
# Usage:
#
#   env BATCH_VARS="file.fa [n]" R -q --no-save --no-restore --no-readline --slave < DNAtranslate_GeneR.R
#
# Example:
#
#   time  env BATCH_VARS="../../test/data/test-dna.fa 2" R -q --no-save --no-restore --no-readline --slave < DNAtranslate_GeneR.R
#
# Docker
#
#   time docker run -v /tmp:/tmp  c0fef4d2b6d6 bash -c "source /etc/profile ; cd /book-evolutionary-genomics ; env BATCH_VARS="test/data/test-dna.fa" R -q --no-save --no-restore --no-readline --slave < src/R/DNAtranslate_GeneR.R"

fasta = '../../test/data/test-dna.fa'

fasta = Sys.getenv('BATCH_VARS')
times = 1

library(GeneR)
idx = indexFasta(fasta)
lines <-readLines( paste(fasta,'.ix',sep='') )
index <-read.table(paste(fasta,'.ix',sep='') )[,1]
n = 0
for (i in 1:times) {
  for (name in index) {
   readFasta (file=fasta, name = name)
   ntseq = getSeq(0)
   aaseq = strTranslate(ntseq)
   cat(">",name," (",n,")\n",aaseq,"\n",sep="")
   n = n+1
  }
}
