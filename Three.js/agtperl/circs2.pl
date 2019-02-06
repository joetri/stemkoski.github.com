# circs.pl
# Clean up a tsv file and get ready to generate threejs scene from it.
#
use POSIX;
$count=0;

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
		my ($date,$twi,$two,$o2,$z1,$z2,$z3,$z4) = 
			($1,floor($2),floor($3),$4,$5,$6,$7,$8);
		my $x = floor($count/5);
		my $ox = floor( $o2*10 ); # 13.9 => 139
		if ($z3) {
			# Temp in zone 3
			print "var sphere = new THREE.Mesh(sphereGeometry, sphereMaterialYellow);";
			print "sphere.position.set(".$x.", $z3, 15);";
			print "scene.add(sphere);\n";
			print "var cube = new THREE.Mesh( cubeGeometrytest, cubeMaterialsYellow );\n";
			print "cube.position.set($x, $ox, 15);\n";
			print "scene.add( cube );\n";

		} elsif ($z1) {
			print "var sphere = new THREE.Mesh(sphereGeometry, sphereMaterialBlue);";
			print "sphere.position.set(".$x.", $z1, 5);";
			print "scene.add(sphere);\n";
		} elsif ($z4) {
			print "var sphere = new THREE.Mesh(sphereGeometry, sphereMaterialPurple);";
			print "sphere.position.set(".$x.", $z4, 20);";
			print "scene.add(sphere);\n";
		} elsif ($z2) {
			print "var sphere = new THREE.Mesh(sphereGeometry, sphereMaterialRed);";
			print "sphere.position.set(".$x.", $z2, 10);";
			print "scene.add(sphere);\n";
		}
		#print "Match on date: $date\ttwi: $twi\ttwo: $two\n";
		#print "\tO2: $o2\tz1: $z1\tz2: $z2\tz3: $z3\tz4: $z4\n";
	} else {
		print "No match\n";
	}
}
