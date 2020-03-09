open FILE,$ARGV[0];
$k = $ARGV[1];

$count = 1;
while (<FILE>)
{
	if (substr($_,0,1) eq ">")
	{	print (">$k.$count\n");
		$count++;
	}
	else
	{	print;
	}
}
