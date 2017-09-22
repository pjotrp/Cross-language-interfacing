# Read a FASTA file a number of times (default once), translate
# an print to STDOUT
#
# Usage:
#
#   python3 DNAtranslate.py dna.fa [n]
#
# Example
#
#   time python3 DNAtranslate.py ../../test/data/test-dna.fa
#
# Dependencies: python biopython

verbose=False

import sys
from Bio.Seq import Seq
from Bio import SeqIO
from Bio.Alphabet import generic_dna

fn = sys.argv[1]
times = 1
if len(sys.argv) > 2:
  times = int(sys.argv[2])

if verbose:
  sys.stderr.write('Biopython translate ',fn, ':', times)
for i in range(0, times):
  if verbose:
    sys.stderr.write( i+1 )
  for seq_record in SeqIO.parse(fn, "fasta", generic_dna):
    print(">",seq_record.id)
    print(seq_record.seq.translate())
