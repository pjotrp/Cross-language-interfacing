# Pure BioJava invocation from JPython

import org.biojava.nbio.core.sequence.io.FastaReaderHelper as help
import java.io.File as file
import sys

loc = file(sys.argv[1])
dnas = help.readFastaDNASequence(loc)

for dna in dnas.values():
  ps = dna.getRNASequence().getProteinSequence()
  print ps
