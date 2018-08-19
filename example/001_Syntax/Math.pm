use strict;
use warnings;

package Math;
    
sub sum {
  my $t = 0;  
  for(@_){
      $t += $_;
  }
  
  return $t;
}

1; # 回傳一個值
