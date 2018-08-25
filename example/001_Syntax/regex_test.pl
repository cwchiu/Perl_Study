use 5.024; # 標記使用 perl 5.24

# 避免常見錯誤
use strict;
use warnings;

use Test::More tests => 100;

sub replaceRule {
    chomp(my $date = `date`);
    $^I = '.bak';
    
    # 代用規則
    while(<>){
        s/^Author:.*//;
        s/^Phone:.*\n//;
        s/^Date:.*/Date: $date/;
        print;
    }
}

subtest 'Regexp', sub {
    subtest 'match', sub {
        $_ = 'Gideon';
        ok(/\w+/, 'match with $_');
        
        
        ok('1234' =~ m|\d+|);
        ok('1234' =~ m/\d+/);
        ok('1234' =~ m!\d+!);
        ok('1234' =~ m{\d+});
        
        ok( 'Hello' =~ m/hello/i, 'ignore case' );
        ok( "hello\nworld" =~ m/h.*world/s, 'multiple line' );
        ok( !("hello\nworld" =~ m/h.*world/), 'multiple line' );
        
        ok( '123-xxx-123-yyy-123-zzz' =~ m/(\d{3})\-\w+\-\1\-\w+\-\1\-\w+/);

        ok( 'Yes' =~ /yes/i, '/i: ignore case');
        ok( !("hello\nworld" =~ m/he.*ld/));
        ok( ("hello\nworld" =~ m/he.*ld/s));
        
        my $what = 'yes';
        ok( 'Yes' =~ m|^$what$|i, 'Regexp 安插變數');
        
    };
    
    subtest 'group', sub {
        ok('hello 1234.' =~ '(\d+)');
        ok($1 eq '1234');
        
        ok('123-456' =~ '(\d+)\-(\d+)');
        ok( $1 eq '123');
        ok( $2 eq '456');
        
        my ($p1, $p2) = '123-456' =~ '(\d+)\-(\d+)';
        ok( $p1 eq '123' && $p2 eq '456');
        
        my %h1 = ( 'abc-123,def-456' =~ /(\w+)\-(\d+)/g );
        ok( $h1{abc} eq '123' && $h1{def} eq '456' );
        
        ok('www.google.com' =~ m!(?:\w+)\.(\w+)\.(?:\w+)!, '?: 不列入 group');
        ok( $1 eq 'google' );
    };
    
    
    subtest 'Replace', sub {
        my $s1 = 'hello xxx';
        ok( $s1 =~ s/xxx/arick/, '取代成功返回 true' );
        ok( $s1 eq 'hello arick', '取代成功, 變數內容修改' );
        
        my $s2 = 'hello xxx';
        ok( !($s2 =~ s/yyy/arick/ ), '取代失敗返回 false' );
        ok( $s2 eq 'hello xxx', '取代失敗不修改變數內容');
        
        my $s3 = '1. xxx, 2. xxx';
        ok( $s3 =~ s/xxx/arick/ );
        ok( $s3 eq '1. arick, 2. xxx');
        
        my $s4 = '1. xxx, 2. xxx';
        ok( $s4 =~ s/xxx/arick/g, 'global mode' );
        ok( $s4 eq '1. arick, 2. arick');
        
        my $s5 = '123-456';
        ok($s5 =~ s/(\d+)\-(\d+)/$2.$1/);
        ok($s5 eq '456.123');

    };
    
    
};

