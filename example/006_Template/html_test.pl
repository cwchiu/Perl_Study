use Text::Template;

my $tpl = Text::Template->new(
  TYPE => 'FILE',
  SOURCE => 'html.tpl'
);

my $hash = {
  title => 'Hello Html Template'  
};

print $tpl->fill_in(HASH => $hash);
