use strict;
use warnings;
use JSON;
use Data::Dumper;

my %h1 = (
  'name' => 'arick',
  'is_hero' => \1,
  'magic' => \0
);
my $d = encode_json(\%h1);
print($d);
my $jd = decode_json($d);
print Dumper($jd);
    
