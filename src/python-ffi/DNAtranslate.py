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
from ctypes import *
import os


fn = sys.argv[1]
times = 1
if len(sys.argv) > 2:
  times = int(sys.argv[2])

emboss = cdll.LoadLibrary(os.path.join(os.path.dirname(os.path.abspath(__file__)),"emboss.so"))
trnTable = emboss.ajTrnNewI(1)

if verbose:
  sys.stderr.write('Biopython FFI translate ',fn, ':', times)
for i in range(0, times):
  if verbose:
    sys.stderr.write( i+1 )
  for seq_record in SeqIO.parse(fn, "fasta", generic_dna):
    print(">",seq_record.id)
    ajpseq   = emboss.ajSeqNewNameC(str(seq_record.seq).encode(), seq_record.id.encode())
    ajpseqt  = emboss.ajTrnSeqOrig(trnTable,ajpseq,1)
    seq = emboss.ajSeqGetSeqCopyC(ajpseqt)
    seq = str(c_char_p(seq).value,'utf-8')
    print(seq)
