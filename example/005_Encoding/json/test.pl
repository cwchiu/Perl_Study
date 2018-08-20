use strict;
use warnings;
use JSON;
use Data::Dumper;

my %h1 = (
  'name' => 'arick',
  'is_hero' => \1,
  'magic' => \0
);
my $d = encode_json(\%h1);
print($d);
my %jd = %{ decode_json($d) };
print Dumper(%jd);
# my %jjd = %$jd;
# print %jjd{name};
print $jd{name};

my $json_str1 = <<'TXT';
{
 "gauges":[{
   "name": "MySQL:Global:MySQLMemUtil",
   "instance_id":"MyHost:3306",
   "label": "MySQL Total CPU utilization percentage",
   "value": 20.12
 }],

 "counters":[{
   "name": "MySQL:Global:MySQLMemUtil",
   "instance_id":"MyHost:3306",
   "label": "MySQL Total CPU utilization percentage",
   "value": 6000
 }],
 "strings":[{
   "name": "MySQL:Global:MySQLMemUtil",
   "instance_id":"MyHost:3306",
   "label": "MySQL Total CPU utilization percentage",
   "value": "x"
 }],
 "attributes":[{
   "name": "MySQL:Global:MySQLMemUtil",
   "instance_id":"MyHost:3306",
   "label": "MySQL Total CPU utilization percentage",
   "value": "x"
 }]
}    
TXT

my %jd2 = %{ decode_json($json_str1) };
# print Dumper(%jd2);
# print Dumper(%jd2{counters});
# print ref(%jd2{counters});
my @counters = @{%jd2{counters}};
for (@counters){
  my %item = %{$_};
  print '*' . %item{name} . '*';    
}