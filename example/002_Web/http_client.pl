use 5.024; 
use strict;
use warnings;

sub download(){
    use File::fetch;
    my $url = 'http://httpbin.org/image/jpeg';
    my $local_folder = '.';
    my $ff = File::Fetch->new(uri => $url);
    my $where = $ff->fetch(to=>$local_folder) or die $ff->error;
    printf(
        "uri: %s\nscheme:%s\nhost:%s\npath:%s\nfile:%s\n",
        $ff->uri,
        $ff->scheme,
        $ff->host,
        $ff->path,
        $ff->file
    );
}

sub httpGet(){
    use LWP::UserAgent;
    use HTTP::Headers;

    my $url="http://httpbin.org/get?n=gideon";
    my $agent_name='myagent';
    my $ua=LWP::UserAgent->new($agent_name);

    my $request=HTTP::Request->new(GET=>$url);

    $request->header(Accept=>'application/json');

    my $response=$ua->request($request);
    print $response->as_string, "\n";

}
    
sub httpHead(){    
    use LWP::Simple qw!head!;
    use URI::URL;
    my $host="http://httpbin.org/get?n=gideon";
    my $url=URI::URL->new($host);
    my @headers=head($url);
    if(@headers){
        print "Host: $host\n";
        print "Server: @{[pop @headers]}\n\n";
    }else{
        print "Unable to retrive @{[$url->as_string]}\n\n";
    }
}
    
sub mirror(){
    use LWP::UserAgent;

    my $ua = LWP::UserAgent->new();

    my $response = $ua->mirror(
        "http://httpbin.org/image/png",
        "a.png"
    );
    if ($response->status_line =~ /Not Modified/) {
        print "File is still up-to-date\n";
        exit(0);
    }
    die unless $response->is_success();

}
    
sub main(){
    # download();
    # httpGet();
    # httpHead();
    mirror();
}

main();