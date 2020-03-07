open FILE,$ARGV[0];

while (<FILE>)
{	@tempsplit = split;
	$tempsplit[1] = substr($tempsplit[1],0,1);
	if (exists $bestmatch{$tempsplit[0]})
	{	if ($tempsplit[2] > $bestmatch{$tempsplit[0]})
		{	$bestmatch{$tempsplit[0]} = $tempsplit[2];
			$bestmatchprotein{$tempsplit[0]} = $tempsplit[1];
		}
	}
	else
	{	$bestmatch{$tempsplit[0]} = $tempsplit[2];
		$bestmatchprotein{$tempsplit[0]} = $tempsplit[1];
	}
}

foreach (keys %bestmatch)
{
	print $_," ",$bestmatchprotein{$_}," ",$bestmatch{$_},"\n";

}

