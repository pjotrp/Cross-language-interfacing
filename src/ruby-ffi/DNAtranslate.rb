#! /usr/bin/env ruby
#
# Sequence translation using the BioRuby (pure Ruby)
#
# Usage:
#
#   ./DNAtranslate.rb file.fa [n]
#
# Example
#
#   time ./DNAtranslate.rb ../../test/data/test-dna.fa
#
# Dependencies: ruby bioruby bigbio biolib
#
# To use JRuby use something like
#
#   time /opt/jre1.8.0_144/bin/java -jar ~/opt/jars/jruby-complete-9.1.13.0.jar DNAtranslate.rb ../../test/data/test-dna.fa
#
# To use Ruby 1.9 (which is twice as fast as 1.8) use something like
#
#   ruby1.9.1 -I ~/opt/ruby/bioruby/lib/ DNAtranslate.rb ../../test/data/test-dna.fa

USAGE =<<EOM
  ruby #{__FILE__} inputfile(s)
EOM

$: << File.dirname(__FILE__)+'/lib'

require 'ffi'
require 'bio'
include Bio

module Emboss
  extend FFI::Library
  ffi_lib "./emboss.so"
  attach_function :ajTrnNewI, [:int], :pointer
  attach_function :ajSeqNewNameC, [:pointer, :pointer], :pointer
  attach_function :ajTrnSeqOrig, [:pointer, :pointer, :int], :pointer
  attach_function :ajSeqGetSeqCopyC, [:pointer], :string
end

if ARGV.size < 1
  print USAGE
  exit 1
end

trnTable = Emboss.ajTrnNewI(1)


ARGV.each do | fn |
  raise "File #{fn} does not exist" if !File.exist?(fn)
  Bio::FlatFile.auto(fn).each do | item |
    seq = Sequence::NA.new(item.data)
    ajpseq   = Emboss.ajSeqNewNameC("atgtcaatggtaagaaatgtatcaaatcagagcgaaaaattggaaattttgt", "Test sequence")
    ajpseqt  = Emboss.ajTrnSeqOrig(trnTable,ajpseq,1)
    aa = Emboss.ajSeqGetSeqCopyC(ajpseqt)
    print "> ",item.definition,"\n"
    print aa,"\n"
  end
end



