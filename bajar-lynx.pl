#!/usr/bin/perl

$lista = $ARGV[0];

open (ARCHIVO, $lista);
while (<ARCHIVO>) {
	chop;
	$linea = $_;

	($protocolo, $archivo) = ($linea =~ /(.*):\/\/(.*)/);

	$directorio = "";
	@elemento = split /\//, $archivo;
	if ($archivo =~ m/\/$/) {
		$directorio = $archivo;
	} else {
		$i = 0;
		while ($i < $#elemento)
		{
			$directorio = $directorio."/".$elemento[$i];
			$i++;
		}
		($directorio) =($directorio =~ /\/(.*)/)
	}

	$comando = "mkdir -p ".$directorio." 2>/dev/null";
	print "$comando \n";
	system ($comando);

	$comando = "lynx -source ".$protocolo."://".$archivo." > ".$archivo;
	print "$comando \n";
	system ($comando);

}
close (ARCHIVO);

