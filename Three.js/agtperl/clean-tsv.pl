# clean-tsv.pl
# Clean up a tsv file and get ready to generate threejs scene from it.
#
use POSIX;
use warnings;
use strict;

my $header = <>;
my $count=0;
#print "$header\n";
print "Time	O2	T1	T2	T3	T4\n";
# 'Time'  'O2'    'T1'    'T2'    'T3'    'T4'

my $time;

while(<>){
	next if ($count++ % 5);
	if (/^
		([^\t]+)	# time
		\t
		([^\t]+)	# water temp in
		\t
		([^\t]+)	# water temp out
		\t
		([^\t]+)	# oxygen
		\t
		(\d+)	# Zone 1 temp
		\t
		(\d+)
		\t
		(\d+)
		\t
		(\d+)
		$
		/x){
		my ($date,$twi,$two,$o2,$z1,$z2,$z3,$z4) = 
			($1,floor($2),floor($3),$4,$5,$6,$7,$8);
			#print "Match on date: $date\ttwi: $twi\ttwo: $two\n";
			#print "\tO2: $o2\tz1: $z1\tz2: $z2\tz3: $z3\tz4: $z4\n";
			#print "$date\t$twi\t$two\t";
		$time = $date;
		$time =~ s/:\d\d .*//;
		# time now in hh:mm format
		if ( $time =~ /(\d\d):(\d\d)/){
			my ($h,$m) = ($1,$2);
			my $mins = 60*$h + $m;
			#$time =~ s/://;
			print "$mins\t";
		} else {
			die('Bad Format');
		}
		$o2 *= 10;
		$o2 = floor( $o2 );
		print "$o2\t$z1\t$z2\t$z3\t$z4\n";
	} elsif (/^
		([^\t]+)	# time
		\t
		([^\t]+)	# water temp in
		\t
		([^\t]+)	# water temp out
		\t
		([^\t]+)	# oxygen
		\t
		/){
		print "Match on first 4\n";
	} elsif (/^
		([^\t]+)	# time
		\t
		/){
		print "Match on first\n";
	} else {
		print "No match\n";
	}
}
