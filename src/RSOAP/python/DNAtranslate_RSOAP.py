#! /usr/bin/python
#
# Read a FASTA file a number of times (default once), translate
# using R/Bioconductor GeneR over RSOAP and print to STDOUT
#
# Usage:
#
#   python DNAtranslate.py dna.fa [n]
#
# Example:
#
#   ./DNAtranslate_RSOAP.py ../../../test/data/test-dna.fa
#
# Dependencies R, RSOAP, GENR, 

verbose=False

import sys
import time
from Bio.Seq import Seq
from Bio import SeqIO
from Bio.Alphabet import generic_dna

import subprocess

fn = sys.argv[1]
times = 1
if len(sys.argv) > 2:
  times = int(sys.argv[2])

# Start the RSOAPManager
subprocess.Popen([r"RSOAPManager"], stdout=subprocess.PIPE)

time.sleep(2.5)

from SOAPpy import *
RSOAPServer=SOAPProxy('http://localhost:9081')
RSessionURL=RSOAPServer.newServer() 
RSession=SOAPProxy(RSessionURL)
RSession.call('library','GeneR')

if verbose:
  print >> sys.stderr, 'Biopython translate ',fn, ':', times
for i in range(0, times):
  if verbose:
    print >> sys.stderr, i+1
  for seq_record in SeqIO.parse(fn, "fasta", generic_dna):
    print ">",seq_record.id
    ntseq = str(seq_record.seq)
    print RSession.call('strTranslate',ntseq)

# Kill the RServer
subprocess.Popen([r"RSOAPManager", "--quit"], stdout=subprocess.PIPE)
