# Read a FASTA file a number of times (default once), translate
# using Biolib with EMBOSS and print to STDOUT
#
# Usage:
#
#   python DNAtranslate_EMBOSS.py dna.fa [n]
#
# Example:
#
#   python DNAtranslate_EMBOSS.py ../../../test/data/test-dna.fa
#
# Dependencies: python biolib

verbose=False

import sys
from Bio.Seq import Seq
from Bio import SeqIO
from Bio.Alphabet import generic_dna
import biolib.emboss as emboss

fn = sys.argv[1]
times = 1
if len(sys.argv) > 2:
  times = int(sys.argv[2])

trnTable = emboss.ajTrnNewI(1)

if verbose:
  print >> sys.stderr, 'Biopython translate ',fn, ':', times
for i in range(0, times):
  if verbose:
    print >> sys.stderr, i+1
  # handle = open(fn, "rU")
  # for seq_record in SeqIO.parse(handle, "fasta"):
  for seq_record in SeqIO.parse(fn, "fasta", generic_dna):
    print ">",seq_record.id
    ntseq = str(seq_record.seq)
    ajpseq   = emboss.ajSeqNewNameC(ntseq,seq_record.id)
    ajpseqt  = emboss.ajTrnSeqOrig(trnTable,ajpseq,1)
    print emboss.ajSeqGetSeqCopyC(ajpseqt)


