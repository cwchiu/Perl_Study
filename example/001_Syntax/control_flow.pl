use strict;
use warnings;

use Test::More tests => 100;

subtest 'if', sub {
    my $r1 = -1;
    if( $r1 < 0){
      $r1 = 1;    
    }
    ok( $r1 == 1, "control flow: if");

    if( $r1 < 0){
      $r1 = 1;    
    }else{
      $r1 = 0;
    }
    ok( $r1 == 0, "control flow: if...else");

    if( $r1 < 0){
        $r1 = 1;    
    }elsif($r1 == 0){
        $r1 = 99;
    }else{
      $r1 = 0;
    }

    ok( $r1 == 99, "control flow: if...elsif...else");

    my $a = 100 unless( $r1 != 99);
    ok( $a == 100, 'unless');
};
    
subtest 'for', sub {
    my $ret = '';
    $ret = $ret . $_ for (1...9);
    ok( $ret eq '123456789' );
    
    my $ret2 = '';
    for(my $i=1; $i<=9; $i += 1){
        $ret2 = $ret2 . $i;
    }
    ok( $ret2 eq '123456789');
    
    my $ret3 = '';
    for my $v (1...9) {
        $ret3 = $ret3 . $v;
    }
    ok( $ret3 eq '123456789');

    subtest 'foreach', sub {
        my $ret3 = '';
        foreach my $v (1..9) {
            $ret3 = $ret3 . $v;
        }
        ok( $ret3 eq '123456789');
        
        my $ret4 = '';
        foreach (1..3){
            $ret4 .= $_ ;
        }
        ok($ret4 eq '123');
        
        my $ret5 = '';
        my @a1 = (1..3);
        foreach (@a1){
            $ret5 .= $_;
        }
        ok( $ret5 eq '123');
    };
    
    subtest 'last', sub {
        my $ret4 = 0;
        for (1...10) {
           last if ($_ == 3);
           $ret4 += $_;
        }
        ok($ret4 == 3, 'last');
    };
    
    subtest 'redo', sub {
        my $ret5 = 0;
        my $redo_c = 0;
        my $for_c = 0;
        for (1...10) {
            ++$redo_c;
            $ret5 += $_;        
            redo if($ret5 < 10);        
            ++$for_c;
        }
        ok( $redo_c == 19 );
        ok( $for_c == 10 );
        ok( $ret5 == 64 );
    };
    
    subtest 'next', sub {
        my $ret = 0;
        for (1...10) {
            next if ($_ %2 ==0);
            $ret += $_;
        }
        ok( $ret == (1+3+5+7+9));
    };
};

subtest 'while', sub {
    my $n =3;
    my $ret = '';
    while($n>0) {
      $ret = $ret . $n;
      $n -= 1;    
    }
    ok($ret == '321');
};

subtest 'until', sub {
    my $m = 0;
    my $ret = '';
    until($m > 3){
        $ret = $ret . $m;
        $m += 1;
    }
    ok( $ret == '0123');
};

# print foreach (1...9);
