use XML::TreePP;

my $tpp = XML::TreePP->new(
    indent          => 2,
    utf8_flag       => 1,
    output_encoding => 'UTF-8'
);

my $tree = { rss => { channel => { item => [ {
    title   => "The Perl Directory",
    link    => "http://www.perl.org/",
}, {
    title   => "The Comprehensive Perl Archive Network",
    link    => "http://cpan.perl.org/",
} ] } } };
my $xml = $tpp->write( $tree );
print $xml;