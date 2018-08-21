use XML::TreePP;

my $tpl = XML::TreePP->new(
    indent => 2,
    utf8_flag => 1,
    output_encoding => 'UTF-8'
);

print $tpl->write({
    R => {
        Q => 'inventory',
        A => [1,2,3],
        B => { C => 'Gideon'}
    }
});