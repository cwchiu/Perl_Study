use 5.024; # 標記使用 perl 5.24

# 避免常見錯誤
use strict;
use warnings;
use Test::More tests => 100;

subtest 'bitwise op', sub {
    ok( (10 & 12) == 8, 'AND');
    ok( (10 | 12) == 14, 'OR');
    ok( (10 ^ 12) == 6, 'XOR');
    
    ok( (6 << 2) == 24, 'left shift');
    ok( (25 >> 2) == 6, 'right shift');
    ok( (~10 & 0xFF) == 0xF5, '補數'); 
};
