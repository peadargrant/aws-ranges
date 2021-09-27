#!/usr/bin/env perl

use warnings;
use strict;
use JSON qw(  );

my $in_filename = $ARGV[0];
my @required_regions = ('us-east','eu-west');
my $required_service = 'EC2';

my $json_text = do {
   open(my $json_fh, "<:encoding(UTF-8)", $in_filename)
      or die("Can't open \$in_filename\": $!\n");
   local $/;
   <$json_fh>
};

my $json = JSON->new;
my $data = $json->decode($json_text);

my $prefixes = $data->{'prefixes'};

foreach my $required_region(@required_regions) {
    foreach my $prefix (@$prefixes) {
	my $ip_prefix = $prefix->{'ip_prefix'};
	my $region = $prefix->{'region'};
	my $service = $prefix->{'service'};
	
	if ( $region !~ m/^\Q$required_region-/ ) {
	    next;
	}
	
	if ( $service !~ m/^\Q$required_service/ ) {
	    next;
	}
	
	print "$ip_prefix\n";
    }
	
}
