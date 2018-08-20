use strict;
use warnings;
use JSON;
use Data::Dumper;

my %h1 = (
  'name' => 'arick'
);
my $d = encode_json(\%h1);
print($d);
my $jd = decode_json($d);
print Dumper($jd);
    
