use strict;
use warnings;

my %DB;
dbmopen( %DB, 'test.db', 0666) or die 'file not open';
if (!exists($DB{name})){
    # write
    $DB{name} = 'arick';
}else{
    # read
    print($DB{name});
}
dbmclose(%DB);
