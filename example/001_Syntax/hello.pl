use 5.010;

# 避免常見錯誤
use strict;
use warnings;

print "hello print\n";
say "hello say";

printf "oct=%lo. hex=%lx\n", 100, 255;

say "What's your name?";
my $name = <STDIN>; # 讀取 stdin, 存放在變數
chomp $name; # 去除1個行尾換行
say "Hello $name, how are you?";
printf "Hello %s", $name; 
use Term::ReadPassword::Win32 qw(read_password);
my $pw = read_password("Password: ");
say $pw;


print STDOUT "stdout test";
print STDERR "error test";

# 使用模組
use Math;
print(Math::sum(1,3,5,7,9));