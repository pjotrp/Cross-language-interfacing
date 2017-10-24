# Read a FASTA file a number of times (default once), translate
# using R/Bioconductor GeneR and print to STDOUT
#
# Usage:
#
#   time python3 DNAtranslate_RPy2.py ../../../test/data/test-dna.fa [n]
#
# Docker
#
#   time docker run -v /tmp:/tmp  c0fef4d2b6d6 bash -c "source /etc/profile ; cd /book-evolutionary-genomics ; python3 src/RS/RPy2/DNAtranslate_RPy2.py test/data/test-dna.fa"

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
  sys.stderr.write('Biopython translate ',fn, ':', times)
for i in range(0, times):
  if verbose:
    sys.stderr.write(i+1)
  for seq_record in SeqIO.parse(fn, "fasta", generic_dna):
    print(">",seq_record.id)
    ntseq = str(seq_record.seq)
    print(strTranslate(ntseq)[0])
