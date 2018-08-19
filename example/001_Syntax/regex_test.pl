use Test::More tests => 100;

subtest 'Regexp', sub {
    ok('1234' =~ m|\d+|);
    ok('1234' =~ m/\d+/);
    ok('1234' =~ m!\d+!);
    ok('1234' =~ m{\d+});
    
    ok('hello 1234.' =~ '(\d+)');
    ok($1 eq '1234');
    
    ok('123-456' =~ '(\d+)\-(\d+)');
    ok( $1 eq '123');
    ok( $2 eq '456');
    
    ok( 'Hello' =~ m/hello/i, 'ignore case' );
    ok( "hello\nworld" =~ m/h.*world/s, 'multiple line' );
    ok( !("hello\nworld" =~ m/h.*world/), 'multiple line' );
    
    subtest 'Replace', sub {
        my $s1 = 'hello xxx';
        ok( $s1 =~ s/xxx/arick/ );
        ok( $s1 eq 'hello arick' );
        
        my $s2 = 'hello xxx';
        ok( !($s2 =~ s/yyy/arick/ ) );
        ok( $s2 eq 'hello xxx');
        
        my $s3 = '1. xxx, 2. xxx';
        ok( $s3 =~ s/xxx/arick/ );
        ok( $s3 eq '1. arick, 2. xxx');
        
        my $s4 = '1. xxx, 2. xxx';
        ok( $s4 =~ s/xxx/arick/g, 'global mode' );
        ok( $s4 eq '1. arick, 2. arick');
    };
    
    my $s5 = '123-456';
    ok($s5 =~ s/(\d+)\-(\d+)/$2.$1/);
    ok($s5 eq '456.123');
    
    ok( '123-xxx-123-yyy-123-zzz' =~ m/(\d{3})\-\w+\-\1\-\w+\-\1\-\w+/);
};

