open FILE,$ARGV[0];
$p = $ARGV[1];

while (<FILE>)
{	if (substr($_,0,1) eq ">")
	{	if ($_ =~ /$p/)
		{	
			$show = 0;
		}
		else
		{	print;
			$show = 1;
		}
	}
	else
	{	if ($show)
		{	print;
		}
	}
}

