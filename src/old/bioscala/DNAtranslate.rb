#! /usr/bin/ruby
#
# Sequence translation using the BioRuby (pure Ruby)
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
#
# To use Ruby 1.9 (which is twice as fast as 1.8) use something like
#
#   ruby1.9.1 -I ~/opt/ruby/bioruby/lib/ DNAtranslate.rb ../../test/data/test-dna.fa
#
# JRuby
#
#   time jruby -I ~/izip/git/opensource/bioruby/lib/ DNAtranslate.rb ../../test/data/test-dna.fa >> /dev/null


USAGE =<<EOM
  ruby #{__FILE__} inputfile(s)
EOM

$: << File.dirname(__FILE__)+'/lib'

require 'bio'
include Bio

if ARGV.size < 1
  print USAGE
  exit 1
end
ARGV.each do | fn |
  raise "File #{fn} does not exist" if !File.exist?(fn)
  Bio::FlatFile.auto(fn).each do | item |
    seq = Sequence::NA.new(item.data)
    aa = seq.translate
    print "> ",item.definition,"\n"
    print aa.seq,"\n"
  end
end

