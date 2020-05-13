#!/usr/bin/perl --
$pi=3.1415926535897;
my $startfreq=5000;
$freqmult=2**(1/18);
my @freq;
my @phase;
my $amplitude=6;
my $lasti=0;
sub line2freq
{
	my ($line)=@_;
	my @amp; # amplitude;
	$linelen=length($line);
	my $i;
	for ($i=0;$i<$linelen;$i++)
	{
		$onechar=substr($line,$i,1);
		if ($onechar eq " ") 
		{
			$phase[$i]=0;
			if ($amp[$i]>0)
			{
				$amp[$i]=0-$amp[$i];
			}
			#print "0";
		} else {
			$amp[$i]=$amplitude; #ord($onechar);
			#print "1";
		}
	}
	#print "\n";

	$inc=(2*$pi)/44100;
	for ($i=0;$i<100;$i++)
	{
		$tot=0;
		for ($j=0;$j<$linelen;$j++)
		{
			$phase[$j]+=$inc*$freq[$j];
			my $currsig=0;
			if ($amp[$j] >=0)
			{
				$currsig=$amp[$j]*sin($phase[$j]);
			} else {
				$currsig=-$amp[$j]*sin($phase[$j]);
				if (int($currsig)==0)
				{
					$amp[$j]=0;
				} else {
					$amp[$j]*=.9;
				}
			}
			$tot+=int($currsig);
		}
		if ($tot<0)
		{
			$tot=(0xffff-abs($tot))+1;
		}
		print chr($tot %256).chr(($tot/256)%256);
	}
}
my $num_args = $#ARGV + 1;
# Parse command line
for (my $argnum=0;$argnum < $num_args; $argnum++)
{
	$arg=$ARGV[$argnum];
	
	if ($arg =~ /--startfreq=/ )
	{	
		$arg=~ s/--startfreq=//;
		$startfreq=$arg;
		next;
	}
	if ($arg =~ /--freqmult=/ )
	{	
		$arg=~ s/--freqmult=//;
		$freqmult=$arg;
		next;
	}
}
$currfreq=$startfreq;
for ($i=0;$i<80;$i++)
{
	$phase[$i]=0;
	$freq[$i]=$currfreq;
	$currfreq*=$freqmult;
}

while (defined($line = <STDIN>)) 
{
	my $cline=$line;
	chomp $cline;
	line2freq($cline);
}
