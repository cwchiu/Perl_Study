use 5.024; # 標記使用 perl 5.24

# 避免常見錯誤
use strict;
use warnings;
use Test::More tests => 100;
use POSIX qw(strftime);

sub now(){
    my $t = time;
    print "Now Timestamp: $t\n";

    my $d = localtime;
    print("Now String: $d\n");

    my @d = localtime;
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = @d;
    for (@d) {
        print "$_\n";
    }
}

sub main(){
    now();
    
    
}

subtest 'localtime', sub {
    my $t = 1535206078;
    my @dt = localtime($t);
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = @dt;
    ok( $mon == 7);
    ok( $mday == 25);
    ok( $year+1900 == 2018);
    ok( $hour == 22);
    ok( $min == 7);
    ok( $sec == 58);
    
};

main();
