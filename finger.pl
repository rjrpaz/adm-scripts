#!/usr/bin/perl

require "/usr/lib/perl5/site_perl/i486-linux/sys/socket.ph";

chop($hostname = `/bin/hostname`);
$input = shift (@ARGV);

($username, $remote_host) = split (/@/, $input, 2);

unless ($remote_host) {
	$remote_host = $hostname;
}

$service = "finger";

$socket_template = "S n a4 x8";

$tcp = (getprotobyname("tcp"))[2];

if ($service !~ /^\d+$/) {
	$service = (getservbyname ($service, "tcp"))[2];
}

$current_address = (gethostbyname ($hostname))[4];
$remote_address = (gethostbyname ($remote_host))[4];

@ip_numbers = unpack ("C4", $current_address);
$ip_address = join (".", @ip_numbers);

unless ($remote_address) {
	die "Unknown host: ", $remote_host, "\n";
}

$current_port = pack ($socket_template, &AF_INET, 0, $current_address);
$remote_port = pack ($socket_template, &AF_INET, $service, $remote_address);

socket (FINGER, &AF_INET, &SOCK_STREAM, $tcp) || die "Cannot create socket.\n";
		
bind (FINGER, $current_port) || die "Cannot bind to port.\n";
connect (FINGER, $remote_port) || die "Cannot connect to remote port.\n";

$current_handle = select (FINGER);
$| = 1;
select ($current_handle);

print FINGER $username, "\n";

while (<FINGER>) {
	print;
}

close (FINGER);
exit (0);