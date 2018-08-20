use strict;
use warnings;

sub a {
  print "func a\n";    
}

sub b {
  my $func = shift;
  $func->();
}

b(\&a);