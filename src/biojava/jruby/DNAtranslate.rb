#! /usr/bin/jruby
#
# Sequence translation using BioJava3
#
# Usage:
#
#   ./DNAtranslate.rb file.fa [n]
#
# Example
#
#   ./DNAtranslate.rb ../../../test/data/test-dna.fa
#
# or
#
#   time /opt/jre1.8.0_144/bin/java -jar ~/opt/jars/jruby-complete-9.1.13.0.jar DNAtranslate.rb ../../../test/data/test-dna.fa
#
# Dependencies: ruby bioruby bigbio biolib
#
#   jruby DNAtranslate.rb ../../test/data/test-dna.fa

USAGE =<<EOM
  ruby #{__FILE__} inputfile(s)
EOM

$: << File.dirname(__FILE__)+'/lib'

if ARGV.size < 1
  print USAGE
  exit 1
end

include Java

require '../jython/lib/slf4j-api-1.7.25.jar'
require '../jython/lib/biojava-core-4.2.8.jar'

ARGV.each do | fn |
  raise "File #{fn} does not exist" if !File.exist?(fn)
  f = java.io.File.new(fn)
  dnas = org.biojava.nbio.core.sequence.io.FastaReaderHelper.readFastaDNASequence(f)

  for dna in dnas.values()
    ps = dna.getRNASequence().getProteinSequence()
    print ps,"\n"
  end
end
