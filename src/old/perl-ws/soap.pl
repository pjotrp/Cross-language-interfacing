#!/usr/bin/env perl
use strict;
use warnings;
use SOAP::Lite;

#Comment out when going to/from cmd line args
# my $dna = 'atgatgatg';
my $dna = $ARGV[0];

my $endpoint= 'http://127.0.0.1:9090/translator?WSDL';
my $client = SOAP::Lite->service($endpoint);
my $pep = $client->translate(SOAP::Data->name(dna => $dna)->type('string'));
print $pep, "\n";