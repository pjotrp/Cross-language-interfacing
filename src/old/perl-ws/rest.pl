#!/usr/bin/env perl
use strict;
use warnings;

use LWP::UserAgent;
use HTTP::Request;

use Data::Dumper;

my ($post, $get) = (1,0);
my $verbose = 0;

my $base_url = 'http://127.0.0.1:9091/';
my $ua = LWP::UserAgent->new();

#Comment out when you want cmd line args
# my $dna = 'atgatgatg';
my $dna = $ARGV[0];

my $response;

if($get) {
  print STDERR "Using GET\n" if $verbose;
  use URI;
  my $url = URI->new( $base_url );  
  $url->query_form('dna' => $dna);
  $response = $ua->get($url);
}
elsif($post) {
  print STDERR "Using POST\n" if $verbose;
  $response = $ua->post( $base_url, ['dna' => $dna] );
}
else {
  die 'Do not know what transport you desire';
}

die "$base_url error: ". $response->status_line unless $response->is_success;
print $response->content, "\n";


