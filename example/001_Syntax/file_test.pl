use 5.024;
use strict;
use warnings;
use Test::More tests => 100;
use Cwd qw(getcwd cwd);

subtest 'file read/write', sub {
    my $filename = 'test.txt';
    # perl 5.6+, 可分開為
    # open FOUT, '>', filename;
    open FOUT, ">${filename}";
    print FOUT "#1\n";
    print FOUT "#2\n";
    close FOUT;

    ok((-e $filename), 'check file exists');
    ok((-f $filename), 'check file');
  
  
    open FAPPEND, ">>$filename";
    print FAPPEND "#3\n";
    close FAPPEND;

    open FIN, "<$filename";
    while (<FIN>){
      print $_    
    }
    close FIN;
    
    ok((-B 'c:\\windows\\notepad.exe'), 'binary file');
    
    open FIN, "<$filename";
    my @lines = <FIN>;
    ok(scalar @lines == 3);
    close FIN;
};

subtest 'handle file open warn', sub {
    my $open_ok = open FFAIL, "not found file";
    ok( !$open_ok);
    
    open FFAIL, 'not found file' or warn 'file not found';
    
    my $eval_ok = eval {
        my $ret = 1;
        open FFAIL, 'not found file' or $ret = 0;
        
        $ret;
    };
    ok( $eval_ok == 0, 'handle warn');   
};

subtest 'chdir', sub {
    my $folder = getcwd();    
    my $folder2 = cwd();
    ok( $folder eq $folder2);
    chdir "c:\\";
    ok(cwd() eq "c:/");
    chdir $folder;
};

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

sub readfiles() {
    my @filelist = glob "*.pl";
    print $#filelist;
    for (@filelist) {
      print ">$_<\n";    
    }

    for (<*.pl>) {
      print ">$_<\n";    
    }
}

sub main(){

}
    
main();