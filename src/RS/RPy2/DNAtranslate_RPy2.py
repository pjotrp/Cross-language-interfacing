# Read a FASTA file a number of times (default once), translate
# using R/Bioconductor GeneR and print to STDOUT
#
# Usage:
#
#   python DNAtranslate_RPy2.py dna.fa [n]
#

verbose=False

import sys
from Bio.Seq import Seq
from Bio import SeqIO
from Bio.Alphabet import generic_dna
import rpy2.robjects as robjects
from rpy2.robjects.packages import importr

fn = sys.argv[1]
times = 1
if len(sys.argv) > 2:
  times = int(sys.argv[2])

importr('GeneR')
strTranslate=robjects.r['strTranslate']

if verbose:
  print >> sys.stderr, 'Biopython translate ',fn, ':', times
for i in range(0, times):
  if verbose:
    print >> sys.stderr, i+1
  for seq_record in SeqIO.parse(fn, "fasta", generic_dna):
    print ">",seq_record.id
    ntseq = str(seq_record.seq)
    print strTranslate(ntseq)[0]


