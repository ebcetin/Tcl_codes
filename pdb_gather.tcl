#good for systematic pdb write

puts "how many trajectories: "
gets stdin nt


for {set j 0} {$j < $nt} {incr j} {
puts "Enter mutation name (lowercase): "
gets stdin a

#molecule input e.g dhf-a26t.psf
mol load psf dhf-$a.psf
animate read dcd dhf-$a-s100-210ns.dcd waitfor all
	
	set b [atomselect top "segname P1 O1 and O2" frame last] # segment names 
	$b writepdb $a-lf.pdb
	mol delete $j
}