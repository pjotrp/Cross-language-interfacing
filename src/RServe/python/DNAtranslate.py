# Read a FASTA file a number of times (default once), translate
# using R/Bioconductor GeneR and print to STDOUT
#
# Usage:
#
#   python3 DNAtranslate.py dna.fa [n]
#
# Example:
#
#   time python3 DNAtranslate.py ../../../test/data/test-dna.fa
#

verbose=False

import sys
import os
import time
from Bio.Seq import Seq
from Bio import SeqIO
from Bio.Alphabet import generic_dna

import subprocess
import pyRserve

fn = sys.argv[1]
times = 1
if len(sys.argv) > 2:
  times = int(sys.argv[2])

# Start the RServer
os.system("R -q --no-save --no-restore --no-readline --slave < Rserve.R")

time.sleep(0.5)
conn = pyRserve.connect()
conn.eval('library(GeneR)')

if verbose:
  sys.stderr.write( 'Biopython translate ',fn, ':', times )
for i in range(0, times):
  if verbose:
    sys.stderr.write(i+1)
  for seq_record in SeqIO.parse(fn, "fasta", generic_dna):
    print(">",seq_record.id)
    ntseq = str(seq_record.seq)
    print(conn.eval('strTranslate("'+ntseq+'")'))

# Kill the RServer
subprocess.Popen([r"pkill", "Rserve"], stdout=subprocess.PIPE)
