#!/usr/bin/perl -w
use Net::SMTP::SSL;

&send_mail('user@midomain.org', 'Test 1', 'Test 1');

exit(0);

sub send_mail {
	my $to = $_[0];
	my $subject = $_[1];
	my $body = $_[2];

	my $from = 'sender@midomain.org';
	my $password = 'server_password';

	my $smtp = Net::SMTP::SSL->new('smtp.gmail.com', Port => 587);

	if (not $smtp) {
		die "Could not connect to server\n";
	}

	$smtp->auth($from, $password) || die "Authentication failed!\n";

	$smtp->mail($from . "\n");
	my @recepients = split(/,/, $to);
	foreach my $recp (@recepients) {
		$smtp->to($recp . "\n");
	}
	$smtp->data();
	$smtp->datasend("From: " . $from . "\n");
	$smtp->datasend("To: " . $to . "\n");
	$smtp->datasend("Subject: " . $subject . "\n");
	$smtp->datasend("\n");
	$smtp->datasend($body . "\n");
	$smtp->dataend();
	$smtp->quit;
}

