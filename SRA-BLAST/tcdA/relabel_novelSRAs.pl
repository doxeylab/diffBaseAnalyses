$threshold = 99.5;

open FILE,$ARGV[0];

while (<FILE>)
{	chomp;
	@tempsplit = split;
	$ID{$tempsplit[0]} = $tempsplit[2];
	$group{$tempsplit[0]} = $tempsplit[1];
}

close FILE;
open FILE,$ARGV[1];

while (<FILE>)
{	chomp;
	if (substr($_,0,1) eq ">")
	{	$seqname = $_;
		substr($seqname,0,1) = "";

		if (exists $ID{$seqname})
		{	if ($ID{$seqname} > $threshold)
			{	
				print ">",$seqname,".",$group{$seqname},"\n";
				
			}
			else
			{	print ">",$seqname,".","?","\n";
			}
			$printseq = 1;
		}
		else
		{	$printseq = 0;
		}

	}
	else
	{	if ($printseq)
		{	print;
			print "\n";
		}
	}

}
