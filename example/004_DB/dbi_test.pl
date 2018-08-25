use DBI;

# PostgreSQL
my $data_source = 'dbi:Pg:dbname=test';
my $dbh = DBI->connect( $data_source, $username, $password);
my $sth = $dbh->prepare('select * from users');
$sth->execute();
my $rows = $sth->fetchrow_array();
$sth->finish();
$dbh->disconnect();