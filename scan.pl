#!/usr/bin/perl

$ip_bajo = $ARGV[0];
$ip_alto = $ARGV[1];

while ($ip_bajo ne $ip_alto)
{
	$ping_result = `ping -c 1 -i 1 -s 1 $ip_bajo`;
	if ($ping_result !~ /0 packets received/)
	{
		$mac = `arp -a |grep $ip_bajo`;
		($hostname) = ($mac =~ /([^\s]*)/);
		($mac) = ($mac =~ /at\s([^\s]*)/);
		print "IP: $ip_bajo \t MAC: $mac \t Host: $hostname \n";
	}
	@ip_bajo_partes = split /\./, $ip_bajo;
	$ip_bajo_partes[3]++;
	if ($ip_bajo_partes[3] eq "255")
	{
		$ip_bajo_partes[3] = "1";
		$ip_bajo_partes[2]++;
	}
	if ($ip_bajo_partes[2] eq "255")
	{
		$ip_bajo_partes[2] = "1";
		$ip_bajo_partes[1]++;
	}
	if ($ip_bajo_partes[1] eq "255")
	{
		$ip_bajo_partes[1] = "1";
		$ip_bajo_partes[0]++;
	}
	if ($ip_bajo_partes[0] eq "255")
	{
		last;
	}
	$ip_bajo = join(".", @ip_bajo_partes);
}

exit;


