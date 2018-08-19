use strict;
use warnings;
use Test::More tests => 100;

open FOUT, ">test.txt";
print FOUT "#1\n";
print FOUT "#2\n";
close FOUT;

open FAPPEND, '>>test.txt';
print FAPPEND "#3\n";
close FAPPEND;

open FIN, '<test.txt';
while (<FIN>){
  print $_    
}
close FIN;

ok((-e 'test.txt'), 'check file exists');
ok((-f 'test.txt'), 'check file');
ok((-B 'c:\\windows\\notepad.exe'), 'binary file');

open FFAIL, 'not found file' or warn 'file not found';

# chdir "/tmp";
# chmod 0444, 'log.txt';
# chown 
# link "log.txt", "log.bak";
# mkdir '/tmp/a', 0777;
# rename 'a.txt', 'a.txt.bak';
# rmdir a.txt;
# stat 'a.txt';
# unlink 'a.txt';
# utime
# localtime

my @filelist = glob "*.pl";
print $#filelist;
for (@filelist) {
  print ">$_<\n";    
}

for (<*.pl>) {
  print ">$_<\n";    
}