

library(GeneR)
fasta = '../../test/data/test-dna.fa'
idx = indexFasta(fasta)
lines <-readLines( paste(fasta,'.ix',sep='') )
index <-read.table(paste(fasta,'.ix',sep='') )[,1]
n = 0
for (name in index) {
 readFasta (file=fasta, name = name)
 ntseq = getSeq(0)
 aaseq = strTranslate(ntseq)
 cat(">",name," (",n,")\n",aaseq,"\n",sep="")
 n = n+1
}
