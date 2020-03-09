$alignmentLengthThreshold = 0.90 * 2366;  #length of full-length tcdB seq

open FILE,$ARGV[0];

while (<FILE>)
{	@tempsplit = split;
	$tempsplit[1] = substr($tempsplit[1],0,1);
	if (exists $bestmatch{$tempsplit[0]})
	{	if ($tempsplit[2] > $bestmatch{$tempsplit[0]})
		{	$bestmatch{$tempsplit[0]} = $tempsplit[2];
			$bestmatchprotein{$tempsplit[0]} = $tempsplit[1];
			$alignmentLength{$tempsplit[0]} = $tempsplit[3];
		}
	}
	else
	{	$bestmatch{$tempsplit[0]} = $tempsplit[2];
		$bestmatchprotein{$tempsplit[0]} = $tempsplit[1];
                $alignmentLength{$tempsplit[0]} = $tempsplit[3];

	}
}

foreach (keys %bestmatch)
{
	if ($alignmentLength{$_} > $alignmentLengthThreshold)
	{
		print $_," ",$bestmatchprotein{$_}," ",$bestmatch{$_}," ",$alignmentLength{$_}," COMPLETE\n";
	}
	else
	{
                print $_," ",$bestmatchprotein{$_}," ",$bestmatch{$_}," ",$alignmentLength{$_}," PARTIAL\n"; 
	}

}

