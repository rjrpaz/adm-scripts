#!/usr/bin/perl
use Authen::Smb;

my $user = "username";
my $password = "password";
my $bdc = "pdc_server_name";
my $pdc = "bdc_server_name";
my $ntdomain = "domain";

my $authResult = Authen::Smb::authen($user, $password, $pdc, $bdc, $ntdomain);

if ( $authResult == Authen::Smb::NO_ERROR ) {
	print "User successfully authenticated.\n";
} else {
	print "User not authenticated with error level $authResult\n";
}

