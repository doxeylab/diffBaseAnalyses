open FILE,$ARGV[0];

while (<FILE>)
{
	if (substr($_,0,1) eq ">")
	{	if ($_ =~ /partial/)
		{	
			$show = 0;
		}
		else
		{	$show = 1;
			print;
		}	
	}
	else
	{
		if ($show == 1)
		{	print;
		}
	}
}

