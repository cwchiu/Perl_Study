use 5.024; # 標記使用 perl 5.24
use strict;
use warnings;
# use Test::More tests => 100;

use Net::SMTP;

my $smtp = Net::SMTP->new('127.0.0.1:25', Timeout => 60, 
    Hello => 'example.com',
    Debug => 1
);
my $to = 'arick@example.com';
$smtp->mail('gideon@example.com');
$smtp->to($to);
$smtp->data();
$smtp->datasend("To: $to\n");
$smtp->datasend("\n");
$smtp->datasend("A simple test message\n");
$smtp->dataend();
$smtp->quit();