# Read a FASTA file a number of times (default once), translate
# an print to STDOUT
#
# Usage:
#
#   perl DNAtranslate.pl dna.fa [n]
#
# Example
#
#   perl DNAtranslate.pl ../../test/data/test-dna.fa
#
# Dependencies: perl bioperl

use Bio::SeqIO;

my $infile = $ARGV[0];

$in  = Bio::SeqIO->new(-file => $infile , '-format' => 'Fasta');

while ( my $seq = $in->next_seq() ) {
 print(">",$seq->id()." ".$seq->desc()."\n");
 # print($seq->seq(),"\n");
 print($seq->translate()->seq(),"\n");
}

