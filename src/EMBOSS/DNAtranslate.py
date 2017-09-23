# Read a FASTA file a number of times (default once), translate
# using EMBOSS and load the result
#
# Usage:
#
#   python3 DNAtranslate.py dna.fa [n]
#
# Example:
#
#   time python3 DNAtranslate.py ../../test/data/test-dna.fa
#

import sys
import os
from Bio.Seq import Seq
from Bio import SeqIO

fn = sys.argv[1]
times = 1
if len(sys.argv) > 2:
  times = int(sys.argv[2])

# invoke EMBOSS transeq CLI
os.system("transeq "+fn+" out.pep")

for i in range(0, times):
  for seq_record in SeqIO.parse("out.pep", "fasta"):
    print(">",seq_record.id)
    seq = str(seq_record.seq)
    print(seq)
