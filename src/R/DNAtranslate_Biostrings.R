# Sequence translation with R
#
# Usage:
#
#   env BATCH_VARS="file.fa [n]" R -q --no-save --no-restore --no-readline --slave < DNAttranslate_Biostrings.R
#
# Example:
#
#   time  env BATCH_VARS="../../test/data/test-dna.fa" R -q --no-save --no-restore --no-readline --slave < DNAtranslate_Biostrings.R
#
# Docker
#
#   time docker run -v /tmp:/tmp xxxx bash -c "source /etc/profile ; cd /book-evolutionary-genomics ; env BATCH_VARS="test/data/test-dna.fa" R -q --no-save --no-restore --no-readline --slave < src/R/DNAtranslate_Biostrings.R"

fasta = '../../test/data/test-dna.fa'

fasta = Sys.getenv('BATCH_VARS')
times = 1

library(GeneR)
library(Biostrings)

ff = readDNAStringSet(fasta) # note we read all in RAM

for (i in 1:times) {
  for (n in 1:length(ff)) {
    ntseq = toString(ff[n])
    aaseq = strTranslate(ntseq)
    cat(">(",n,")\n",aaseq,"\n",sep="")
  }
}
