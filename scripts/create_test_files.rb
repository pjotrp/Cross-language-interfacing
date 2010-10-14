#! /usr/bin/ruby
#
# Create several files for testing translation
#
# Usage:
#
#   ./create_test_files.rb

require 'bio'
include Bio

targetdir = '/tmp'
basedir = File.dirname(__FILE__)+'/..'
inputfn = basedir + '/test/data/test-dna.fa'

recs = []
Bio::FlatFile.auto(inputfn).each do | item |
  seq = Sequence::NA.new(item.data)
  rec = Bio::FastaFormat.new('> '+item.definition+"\n"+seq.to_s)
  recs.push rec
end


# Create files of 50, 100, 200, 500, 1000, 5000, 15000 and 24652 recs
[50, 100, 200, 500, 1000, 5000, 15000, 24652].each do | maxsize |
  targetfn = targetdir + "/test-dna-#{maxsize}.fa"
  print "\nWriting #{targetfn}..."
  count = 0
  File.open(targetfn,"w") do | f |
    recs.each do | rec |
      f.print rec
      count += 1
      break if count > maxsize
    end
  end
end
