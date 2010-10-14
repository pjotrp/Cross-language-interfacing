#! /usr/bin/ruby
#
# Sequence translation using the bigbio FastaReader and EMBOSS 
# translation (Biolib).
#
# Usage:
#
#   ./DNAtranslate.rb file.fa [n]
#
# Example
#
#   ./DNAtranslate.rb ../../../test/data/test-dna.fa
#
# Dependencies: ruby bioruby bigbio biolib

USAGE =<<EOM
  ruby #{__FILE__} inputfile(s)
EOM

$: << File.dirname(__FILE__)+'/lib'

require 'biolib/emboss'
require 'bigbio'

if ARGV.size < 1
  print USAGE
  exit 1
end
ARGV.each do | fn |
  raise "File #{fn} does not exist" if !File.exist?(fn)
  nt = FastaReader.new(fn)
  trnTable = Biolib::Emboss.ajTrnNewI(1);

  frame = 1
  nt.each { | rec |
      ajpseq   = Biolib::Emboss.ajSeqNewNameC(rec.seq,rec.id)
      ajpseqt  = Biolib::Emboss.ajTrnSeqOrig(trnTable,ajpseq,frame)
      aa       = Biolib::Emboss.ajSeqGetSeqCopyC(ajpseqt)
      print "> ",rec.id," ",frame.to_s,"\n"
      print aa,"\n"
  }
end

