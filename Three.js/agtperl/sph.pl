# circs.pl
# Clean up a tsv file and get ready to generate threejs scene from it.
#
use strict;
use warnings;
use POSIX;
my $count=0;
my $printdate=0;
my $datesprite='';
my ($date,$twi,$two,$o2,$z1,$z2,$z3,$z4);

my $header = <>;
while(<>){
	$count++;
	next unless $count % 5;
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
		($date,$twi,$two,$o2,$z1,$z2,$z3,$z4) = 
			($1,floor($2),floor($3),$4,$5,$6,$7,$8);
		my $x = floor($count/5);
		my $ox = floor( $o2*10 ); # 13.9 => 139
		if ($z3) {
			# Temp in zone 3
			print "var sphere = new THREE.Mesh(sphereGeometry, sphereMaterialYellow);";
			print "sphere.position.set(".$x.", $z3, 15);";
			print "scene.add(sphere);\n";
			print "var sphere = new THREE.Mesh(sphereGeometryO2, sphereMaterialGreen);";
			print "sphere.position.set(".$x.", $ox, 15);";
			print "scene.add(sphere);\n";
			$printdate=1;

		} elsif ($z1) {
			print "var sphere = new THREE.Mesh(sphereGeometry, sphereMaterialBlue);";
			print "sphere.position.set(".$x.", $z1, 5);";
			print "scene.add(sphere);\n";
			print "var sphere = new THREE.Mesh(sphereGeometryO2, sphereMaterialGreen);";
			print "sphere.position.set(".$x.", $ox, 5);";
			print "scene.add(sphere);\n";
			if ($printdate) {
				    $datesprite = "var spritey = makeTextSprite( \"$date\",";
					$datesprite .= "{ fontsize: 24, borderColor: {r:250, g:80, b:85, a:1.0}, backgroundColor: {r:185, g:105, b:150, a:0.8} } );";
					$datesprite .= "spritey.position.set($x ,50,0);";
					$datesprite .= "scene.add( spritey );\n";
					print $datesprite;
					$printdate=0;
				}

		} elsif ($z4) {
			print "var sphere = new THREE.Mesh(sphereGeometry, sphereMaterialPurple);";
			print "sphere.position.set(".$x.", $z4, 20);";
			print "scene.add(sphere);\n";
			print "var sphere = new THREE.Mesh(sphereGeometryO2, sphereMaterialGreen);";
			print "sphere.position.set(".$x.", $ox, 20);";
			print "scene.add(sphere);\n";
			$printdate=1;
		} elsif ($z2) {
			print "var sphere = new THREE.Mesh(sphereGeometry, sphereMaterialRed);";
			print "sphere.position.set(".$x.", $z2, 10);";
			print "scene.add(sphere);\n";
			print "var sphere = new THREE.Mesh(sphereGeometryO2, sphereMaterialGreen);";
			print "sphere.position.set(".$x.", $ox, 10);";
			print "scene.add(sphere);\n";
			$printdate=1;
		}
		#print "Match on date: $date\ttwi: $twi\ttwo: $two\n";
		#print "\tO2: $o2\tz1: $z1\tz2: $z2\tz3: $z3\tz4: $z4\n";
	} else {
		print "No match\n";
	}
}
