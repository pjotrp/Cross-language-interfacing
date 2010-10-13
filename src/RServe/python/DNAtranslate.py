# Read a FASTA file a number of times (default once), translate
# using R/Bioconductor GeneR and print to STDOUT
#
# Usage:
#
#   python DNAtranslate.py dna.fa [n]
#
# Example:
#
#   python DNAtranslate.py ../../../test/data/test-dna.fa
#

verbose=False

import sys
from Bio.Seq import Seq
from Bio import SeqIO
from Bio.Alphabet import generic_dna

import pyRserve

fn = sys.argv[1]
times = 1
if len(sys.argv) > 2:
  times = int(sys.argv[2])

conn = pyRserve.rconnect()
conn('library(GeneR)')

if verbose:
  print >> sys.stderr, 'Biopython translate ',fn, ':', times
for i in range(0, times):
  if verbose:
    print >> sys.stderr, i+1
  for seq_record in SeqIO.parse(fn, "fasta", generic_dna):
    print ">",seq_record.id
    ntseq = str(seq_record.seq)
    print conn('strTranslate("'+ntseq+'")')

