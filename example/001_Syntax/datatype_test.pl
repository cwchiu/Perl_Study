use Test::More tests => 100;
use Scalar::Util qw(looks_like_number);
use experimental 'smartmatch';

my $s1 = "arick";
my $i1 = 100;
subtest 'defined', sub {
    ok( !defined( $not_defined ), "defined");
    ok( defined( $s1 ), "defined");
    ok( !defined( $a ) , "defined");
};

subtest '字串合併', sub {
    ok( "hello" . " world" == "hello world", 'string concat' );
    ok( "hello" . 3 == "hello3", 'string concat' );
};

subtest 'looks_like_number', sub {
    ok( looks_like_number("100") , "looks_like_number" );
    ok( looks_like_number("-3.14") , "looks_like_number" );
    ok( looks_like_number("0x64") == false , "looks_like_number" );
    ok( looks_like_number("0123") , "looks_like_number" );
};      

subtest '數值運算', sub {
    ok( 3+4 == 7, "number add" );
    ok( "0123" + 1 == 124, "string add number");
    ok( '3' * 3 == 9);
    ok( 'a' * 3 == 'aaa');
};

subtest '比較運算', sub {
    ok( $s1 eq "arick", "比較字串");
    ok( "100" eq 100, "數值字串自動傳型成數值");
    ok( $a == '', 'undef 字串預設為空字串');
    ok( $a == 0, 'undef 數值預設為0');
};

subtest 'String', sub {
    my $s0 = 'xxx';
    my $s1 = 'hello $s0';
    my $s2 = "hello $s0"; 
    my $s3 = qq|hello $s0|;
    
    ok( $s1 == 'hello $s0', '單引號不解析變數');
    ok( $s2 == 'hello xxx', '雙引號解析變數');
    ok( $s3 == 'hello xxx', 'qq自訂字串符號');
};

subtest 'Array', sub {
    my @arr1;
    $arr1[0] = 'a';
    $arr1[1] = 'b';
    ok( $#arr1+1 == 2, '陣列長度');
    
    @arr1[ $#arr1 +1 ] = 'c';
    ok( $#arr1+1 == 3, '自動擴展後長度');
    
    (@arr1[3], @arr1[4], @arr1[5]) = (@arr1[0], @arr1[1], @arr1[2]);
    ok($#arr1 == 5);
    
    my @arr2 = (1,2,3);
    ok( $#arr2+1 == 3, '直接初始化');
    
    my @arr3 = (1...10);
    ok( $#arr3+1 == 10, 'begin...end');
    
    my @arr4 = (1,2,3...10);
    ok( $#arr4+1 == 10);
    
    my @arr5_1 = (3...10);
    my @arr5 = (1,2, @arr5_1);
    ok( $#arr5+1 == 10, '陣列合併');
    
    my @arr6 = qw|1 2 3|;
    ok( $#arr6+1 == 3, 'qw 初始化陣列');
    
    my $arr7;
    $arr7[10] = 99;
    ok( $#arr7+1 == 11, '直接索引不存在位置賦值');
    ok( !defined($arr7[0]), '未賦值位置為 undef' );
    
    ok(grep( /^99$/, @arr7 ), 'check element in array'); 
    
    # 5.10+
    ok( '99' ~~ @arr7, 'use ~~ check exists' );
    
    subtest 'push/pop', sub {
        push @arr7, 100;
        
        ok( $#arr7+1 == 12, 'push 後陣列長度');
        ok( $arr7[$#arr7] == 100, 'push : 添加到陣列最後');
        ok( @arr7[$#arr7] == $arr7[$#arr7], '$/@ 標記陣列變數效果相同');
        
        my $last = pop @arr7;
        ok( $#arr7+1 == 11, 'pop 後陣列長度');
        ok( $last == 100, '檢查 pop 的元素');
    };
    
    subtest 'shift/unshift', sub {
        my @arr8 = (10, 20);
        my $first = shift @arr8;
        ok( $#arr8+1 == 1, 'shift : 取出第一個元素後資料長度' );
        ok( $first == 10, '第一個元素內容檢查' );
        
        
        unshift @arr8, 100;
        ok( $#arr8+1 == 2, 'unshift : 插入一個元素到開頭後資料長度' );
        ok( @arr8[0] == 100, '第一個元素內容檢查' );
    };
    
    subtest '切片', sub {
       my @arr9 = (0...10);
       my @arr9_1 = @arr9[2...5];
       ok( $#arr9_1 == 3 );
       ok( @arr9_1[0] == 2 && 
           @arr9_1[1] == 3 &&
           @arr9_1[2] == 4 &&
           @arr9_1[3] == 5 
       );
       
       my @arr10 = (1, 10, 2, 30, 4, 50, 6);
       my @arr10_1 = @arr10[1...3, 5];
       ok( $#arr10_1 == 3);
       ok( @arr10_1[0] == 10 && 
           @arr10_1[1] == 2 &&
           @arr10_1[2] == 30 &&
           @arr10_1[3] == 50 
       );
       
       ok( @arr10_1 + 0 == 4, '利用數值運算,得到陣列長度');
    };
    
    my @arr11 = (3, 1, 99, 2, 7);
    my @arr11_1 = sort {$a <=> $b} @arr11;
    ok(
      @arr11_1[0] == 1 &&
      @arr11_1[1] == 2 &&
      @arr11_1[2] == 3 &&
      @arr11_1[3] == 7 &&
      @arr11_1[4] == 99, '數值比較排序'
    );
    
    ok(join( '|', @arr11_1) == '1|2|3|7|99', 'join'); 
    
    my @arr12 = split(/\|/, '1|2|3|7|99');
    ok( $#arr12 == 4, 'split');
    ok( @arr12 + 0 == 5, 'split');
    
    @arr13 = map {$_ * 10} (1..3);
    ok( 
      @arr13[0] == 10 &&
      @arr13[1] == 20 &&
      @arr13[2] == 30, 'map test' 
    );
    
    @arr14 = grep {$_ % 2 == 0} (1...4);
    ok( @arr14 +0 == 2, 'grep');
    ok( @arr14[0] == 2 && @arr14[1] == 4, 'grep');
};

subtest 'Hash', sub {
    my %h1;
    $h1{name} = 'arick';
    $h1{hp} = 100;
    ok( %h1{name} == 'arick' );
    ok( %h1{hp} == 100 );
    ok( exists($h1{name}), 'check exists' );
    
    my %h2 = qw|name arick hp 100|;
    ok( %h2{name} == 'arick' );
    ok( %h2{hp} == 100 );    
    
    my %h3 = (
      'name' => 'arick',
      'hp' => 100
    );
    ok( %h3{name} eq 'arick' );
    ok( %h3{hp} == 100 );    

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
    ok( 'arick' ~~ @values1);
    ok( 100 ~~ @values1);

    my @keys1 = keys(%h3);
    ok( 'name' ~~ @keys1);
    ok( 'hp' ~~ @keys1);
    
    delete $h3{name};
    
    ok( !exists($h3{name}) );
};