use 5.024; # 標記使用 perl 5.24

use strict;
use warnings;

use Test::More tests => 100;
use Scalar::Util qw(looks_like_number);
use experimental 'smartmatch';

my $s1 = "arick";
my $i1 = 100;
subtest 'defined', sub {
    # ok( !defined( $not_defined ), "defined");
    ok( defined( $s1 ), "defined");
    ok( !defined( $a ) , "defined");
};

subtest 'number', sub {
    subtest 'looks_like_number', sub {
        ok( looks_like_number("100") , "looks_like_number" );
        ok( looks_like_number("-3.14") , "looks_like_number" );
        ok( !looks_like_number("0x64") , "looks_like_number" );
        ok( looks_like_number("0123") , "looks_like_number" );
    };      

    subtest 'compare', sub {
        ok( 100 == 100, '==');
        ok( 100 != 1, '!=');
        ok( 100 > 1, '>');
        ok( 100 >= 1, '>=');
        ok( 1 < 100, '<');
        ok( 1 <= 100, '<=');
    };
    
    subtest '數值運算', sub {
        ok( 3+4 == 7, "number add" );
        ok( "0123" + 1 == 124, "string add number");
        ok( '12' * '3' == 36);
        
        my $a = 10;
        my @b = qw|a b cc|;
        ok( $a + @b, 'scalar + 陣列長度');
        ok( $a + scalar @b, '使用 scalar 明確標示純量');
        # ok( '12good34' * '3' == 36, '非數值之後自動忽略'); # warning
        # ok( '3' * 3 == 9); # warngin
        # ok( 'a' * 3 == 'aaa'); # warning
    };
    
    my @a1 = (4,6,9,1,2);
    my @a2 = sort {$a <=> $b} @a1;
    ok( $a2[0] == 1);
    ok( $a2[1] == 2);
    ok( $a2[2] == 4);
    ok( $a2[3] == 6);
    ok( $a2[4] == 9);
};

subtest 'String', sub {
    my $s0 = 'xxx';
    my $s1 = 'hello $s0';
    
    ok( $s1 eq 'hello $s0', '單引號不解析變數');
    ok( "hello $s0" eq 'hello xxx', '雙引號解析變數');
    ok( "hello ${s0}1" eq 'hello xxx1', '雙引號解析變數,使用{}');
    ok( qq|hello $s0| eq 'hello xxx', 'qq自訂字串符號');
    
    subtest '字串合併', sub {
        ok( "hello" . " world" eq "hello world", 'string concat' );
        ok( "hello" . 3 eq "hello3", 'string concat' );
    };

    ok( length('arick') == 5 );
    
    subtest 'index', sub {
        ok( index('hello world', 'world') == 6, 'index');
        my $s = '12395123';
        my $p1 = index($s, '123');
        ok( $p1 == 0);
        my $p2 = index($s, '123', $p1+1);
        ok($p2 == 5);
        
        my $p3 = rindex($s, '123');
        ok($p3 == 5);
        my $p4 = rindex($s, '123', $p3-1);
        ok($p4 == 0);
    };
    
    subtest 'substr', sub {
       ok( substr('hello world', 6) eq 'world' );
       ok( substr('hello world', 6, 3) eq 'wor' );
       ok( substr('hello world', -1) eq 'd' );
       ok( substr('hello world', -5, 2) eq 'wo' );
       
       my $s = 'hello world';
       substr($s, 6) = 'arick';
       ok($s eq 'hello arick');
       
    };
    
    subtest 'case change', sub {
        ok( uc('hello') eq 'HELLO');
        ok( lc('Hello') eq 'hello');
        ok( ucfirst('hello') eq 'Hello');
        ok( lcfirst('HELLO') eq 'hELLO');
        
        ok( "\LHello World" eq 'hello world', '\L 之後全部轉小寫');
        ok( "\lHELLO WORLD" eq 'hELLO WORLD', '\l 首字小寫');
        
        ok( "\UHello World" eq 'HELLO WORLD', '\U 之後全部轉大寫');
        ok( "\uhello world" eq 'Hello world', '\u 首字大寫');
        
        ok( "\u\LHELLO WORLD" eq 'Hello world', '\u\L 首字大寫其餘小寫');
        ok( "\l\UHELLO WORLD" eq 'hELLO WORLD', '\l\U 首字小寫其餘大寫');
    };

    subtest '比較運算', sub {
        ok( 'arick' eq "arick", "eq");
        ok( "100" eq 100, "數值字串自動傳型成數值");
        ok( 'a' ne 'b', 'ne');
        ok( 'a' lt 'b', 'lt');
        ok( 'a' le 'b', 'le');
        ok( 'b' gt 'a', 'gt');
        ok( 'b' ge 'a', 'ge');
        # ok( $a eq '', 'undef 字串預設為空字串');
        # ok( $a == 0, 'undef 數值預設為0');
    };

    subtest 'sprintf', sub {
        ok( sprintf('100%%') eq '100%');
        ok( sprintf('>%s<', 'arick') eq '>arick<');
        ok( sprintf('>%10s<', 'arick') eq '>     arick<');
        ok( sprintf('>%-10s<', 'arick') eq '>arick     <');
        ok( sprintf('>%d<', 10) eq '>10<');
        ok( sprintf('>%6d<', 10) eq '>    10<');
        ok( sprintf('>%-6d<', 10) eq '>10    <');
        ok( sprintf('>%5.3f<', 3.1415926) eq '>3.142<');
        ok( sprintf('>%10.3f<', 3.1415926) eq '>     3.142<');
        ok( sprintf('>%x<', 10) eq '>a<', '16進位');
        ok( sprintf('>%X<', 254) eq '>FE<', '16進位');
        ok( sprintf('>%o<', 10) eq '>12<', '八進位');
    };
    
    subtest 'string repetition', sub {
        ok( 'Gideon' x 3 eq 'GideonGideonGideon');
        ok( 'Gideon' x (2+1) eq 'GideonGideonGideon');
        ok( 5 x (2+1) eq '555');
    };
    
    subtest 'sort', sub {
        my @a1 = ('arick', 'john', 'triton', 'edi');
        my @a2 = sort {$a cmp $b} @a1;
        ok( $a2[0] eq 'arick');
        ok( $a2[1] eq 'edi');
        ok( $a2[2] eq 'john');
        ok( $a2[3] eq 'triton');
    };
    
    subtest 'chomp', sub {
      my $s1 = "Gideon\n";
      ok( chomp($s1) == 1);  
      ok( $s1 eq 'Gideon');
      
      my $s2 = "Gideon\n\n";
      ok( chomp($s2) == 1);  
      ok( $s2 eq "Gideon\n");
      
      my $s3 = "Gideon";
      ok( chomp($s3) == 0);  
      ok( $s3 eq "Gideon");
      
      my @a1 = ("xyz\n", "abc\n");
      chomp(@a1);
      ok( ($a1[0] eq 'xyz') && ($a1[1] eq 'abc'), 'chomp 用於陣列, 會在每個元素套用一次');
    };
};

subtest 'Array', sub {
    my @arr1;
    $arr1[0] = 'a';
    $arr1[1] = 'b';
    subtest '陣列長度', sub {
        ok( $#arr1+1 == 2);
        ok( @arr1 + 0);
    };
    
    @arr1[ $#arr1 +1 ] = 'c';
    ok( $#arr1+1 == 3, '自動擴展後長度');
    
    ($arr1[3], $arr1[4], $arr1[5]) = ($arr1[0], $arr1[1], $arr1[2]);
    ok($#arr1 == 5);
    
    my @arr2 = (1,2,3);
    ok( $#arr2+1 == 3, '直接初始化');
    
    subtest '.. 運算子', sub { 
        my @arr3 = (1..10);
        ok( $#arr3+1 == 10, 'begin..end');
        
        my @arr4 = (1,2,3..10);
        ok( $#arr4+1 == 10);
        
        my @arr10 = (5..1);
        ok( @arr10 == 0, '大..小 不會產生');
        
        my @arr11 = (1.7..5.9);
        ok( @arr11 == 5, '小數點會無條件捨去');
        
        my @arr12_1 = (1,2,3);
        my @arr12_2 = (1..@arr12_1);
        ok(@arr12_2 == 3, '@arr_12_1 會先以純量得到陣列長度3,效果等同 (1..3)');
    };
    
    my @arr5_1 = (3...10);
    my @arr5 = (1,2, @arr5_1);
    ok( $#arr5+1 == 10, '陣列合併');
    
    my @arr6 = qw|1 2 3|;
    ok( $#arr6+1 == 3, 'qw 初始化陣列');
    
    my @arr7;
    $arr7[10] = 99;
    ok( $#arr7+1 == 11, '直接索引不存在位置賦值');
    ok( !defined($arr7[0]), '未賦值位置為 undef' );
    
    ok(grep( /^99$/, (90...1000) ), 'check element in array'); 
    
    # 5.10+
    ok( '99' ~~ @arr7, 'use ~~ check exists' );
    
    subtest 'push/pop', sub {
        push @arr7, 100;
        
        ok( $#arr7+1 == 12, 'push 後陣列長度');
        ok( $arr7[$#arr7] == 100, 'push : 添加到陣列最後');
        ok( $arr7[$#arr7] == $arr7[$#arr7], '$/@ 標記陣列變數效果相同');
        
        my $last = pop @arr7;
        ok( $#arr7+1 == 11, 'pop 後陣列長度');
        ok( $last == 100, '檢查 pop 的元素');
        
        my @new_arr = (1,2);
        push @arr7, @new_arr;
        ok( @arr7 == 13, 'push 一個陣列變數, 會將全部元素加入');
        ok( pop @arr7 == 2);
        ok( pop @arr7 == 1);
        
    };
    
    subtest 'shift/unshift', sub {
        my @arr8 = (10, 20);
        my $first = shift @arr8;
        ok( $#arr8+1 == 1, 'shift : 取出第一個元素後資料長度' );
        ok( $first == 10, '第一個元素內容檢查' );
        
        
        unshift @arr8, 100;
        ok( $#arr8+1 == 2, 'unshift : 插入一個元素到開頭後資料長度' );
        ok( $arr8[0] == 100, '第一個元素內容檢查' );
        
        unshift @arr8, (1,2);
        ok( @arr8 == 4, 'unshift 一個陣列變數, 會將全部元素加入');
        ok( shift @arr8 == 1);
        ok( shift @arr8 == 2);
    };
    
    subtest '切片', sub {
       my @arr9 = (0...10);
       my @arr9_1 = @arr9[2...5];
       ok( $#arr9_1 == 3 );
       ok( $arr9_1[0] == 2 && 
           $arr9_1[1] == 3 &&
           $arr9_1[2] == 4 &&
           $arr9_1[3] == 5 
       );
       
       my @arr10 = (1, 10, 2, 30, 4, 50, 6);
       my @arr10_1 = @arr10[1...3, 5];
       ok( $#arr10_1 == 3);
       ok( $arr10_1[0] == 10 && 
           $arr10_1[1] == 2 &&
           $arr10_1[2] == 30 &&
           $arr10_1[3] == 50 
       );
       
       ok( @arr10_1 + 0 == 4, '利用數值運算,得到陣列長度');
    };
    
    subtest 'sort', sub {
        my @arr11 = (3, 1, 99, 2, 7);
        my @arr11_1 = sort {$a <=> $b} @arr11;
        ok(
          $arr11_1[0] == 1 &&
          $arr11_1[1] == 2 &&
          $arr11_1[2] == 3 &&
          $arr11_1[3] == 7 &&
          $arr11_1[4] == 99, '數值比較排序'
        );
        ok(join( '|', @arr11_1) eq '1|2|3|7|99', 'join'); 
    };

    subtest 'reverse', sub {
        my @a1 = (1..3);
        my @a2 = reverse @a1;
        ok( join(',', @a2) eq '3,2,1');
    };
    
    
    subtest 'split', sub {
        my @arr12 = split(/\|/, '1|2|3|7|99');
        ok( $#arr12 == 4, 'split');
        ok( @arr12 + 0 == 5, 'split');
        
        my @arr2 = split /\s+/, 'thie is a book';
        ok( @arr2 == 4);
        
        $_ = 'this is a book';
        my @arr2_1 = split;
        ok( @arr2_1 == 4, '效果等同 /\s+/');
        
        my @arr3 = split( m!,!, '1,,2');
        ok( @arr3 == 3);
        
        my @arr4 = split( m!,!, ',,1');
        ok( @arr4 == 3);
        
        my @arr5 = split( m!,!, '1,,');
        ok( @arr5 == 1, '後面空白元素忽略');
        
        my @arr6 = split( m!,!, '1,,', -1);
        ok( @arr6 == 3, '使用 -1 保留空白元素');
    };
    
    subtest 'join', sub {
        ok( join(',', qw|this is a book|) eq 'this,is,a,book');
        ok( join(',', 'this', 'is', 'a', 'book') eq 'this,is,a,book');
        ok( join(',', qw||) eq '');
    };
    
    subtest 'map', sub {
        my @arr13 = map {$_ * 10} (1..3);
        ok( 
          $arr13[0] == 10 &&
          $arr13[1] == 20 &&
          $arr13[2] == 30, 'map test' 
        );
    };
    
    subtest 'grep', sub {
        my @arr14 = grep {$_ % 2 == 0} (1...4);
        ok( @arr14 +0 == 2);
        ok( $arr14[0] == 2 && $arr14[1] == 4);
    };
};

subtest 'Hash', sub {
    my %h1;
    $h1{name} = 'arick';
    $h1{hp} = 100;
    ok( $h1{name} eq 'arick' );
    ok( $h1{hp} == 100 );
    ok( exists($h1{name}), 'check exists' );
    
    my %h2 = qw|name arick hp 100|;
    ok( $h2{name} eq 'arick' );
    ok( $h2{hp} == 100 );    
    
    
    my %h3 = (
      'name' => 'arick',
      'hp' => 100
    );
    ok( $h3{name} eq 'arick' );
    ok( $h3{hp} == 100 );    

    my @check_keys;
    while ( my ($key, $value) = each(%h3)) {
        push @check_keys, $key;
        if( $key eq 'name'){
            ok($value eq 'arick');
        }elsif ($key eq 'hp'){
            ok($value == 100);
        }else {
            ok( 0 );
        }
    }
    ok( $#check_keys+1 == 2 );
    ok( 'name' ~~ @check_keys);
    ok( 'hp' ~~ @check_keys);

    my @values1 = values(%h3);
    ok( 'arick' ~~ ['cwchiu', 'arick','gideon']);
    ok( 100 ~~ @values1);

    my @keys1 = keys(%h3);
    ok( 'name' ~~ @keys1);
    ok( 'hp' ~~ @keys1);
    
    delete $h3{name};
    
    ok( !exists($h3{name}) );
    
};

sub ipsort {
  my ($a1, $a2, $a3, $a4) = $a =~ /(\d+)\.(\d+)\.(\d+)\.(\d+)/;
  my ($b1, $b2, $b3, $b4) = $b =~ /(\d+)\.(\d+)\.(\d+)\.(\d+)/;
  
  ($a1 <=> $b1) or ($a2 <=> $b2) or ($a3 <=> $b3) or ($a4 <=> $b4);
}

my @ips = (
  '140.21.135.218',
  '140.112.22.49',
  '140.213.21.4',
  '140.211.42.8',
);
my @ip_result = sort ipsort @ips;
print "$_\n" for @ip_result;
print (0 or -1 or 1 or 1);
print "\n";
# 列印陣列技巧
my @arr0 = qw|arick gideon joe cwc|;
printf "%10s\n" x @arr0, @arr0; # 產生斗量的格式化字串


