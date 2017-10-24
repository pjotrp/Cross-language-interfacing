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
#   jruby DNAtranslate_BioScala.rb ../../test/data/test-dna.fa

USAGE =<<EOM
  ruby #{__FILE__} inputfile(s)
EOM

$: << File.dirname(__FILE__)+'/lib'

require 'java'
include Java
# Dir["/some/path/*.jar"].each { |jar| require jar }
require '/home/wrk/jruby_jars/scala-library.jar'
# require '/home/wrk/jruby_jars/scala-compiler.jar'
require '/home/wrk/izip/git/opensource/bioscala/target/scala_2.7.7/bioscala_2.7.7-0.1.jar'
# include "bio.DNA"
# include_class "bio.DNA.Sequence"
include_class('scala.ScalaObject')
include_class('bio.DNA.Sequence') {'Seq'}

if ARGV.size < 1
  print USAGE
  exit 1
end
ARGV.each do | fn |
  raise "File #{fn} does not exist" if !File.exist?(fn)
  p fn

  # import bio._
  dna = Seq.new("agctaacga")
  # dna.translate.mkString should equal ("S*R")


  # Bio::FlatFile.auto(fn).each do | item |
  #   seq = Sequence::NA.new(item.data)
  #   aa = seq.translate
  #   print "> ",item.definition,"\n"
  #   print aa.seq,"\n"
  # end
end

