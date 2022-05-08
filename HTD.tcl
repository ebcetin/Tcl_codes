### Measures Hydride Transfer Distance of DHF and DHFR ####
### freshly open VMD
### go to related folder with has all trajectories analyzed
### check if your trajectory names systemical as below
### enter the mutation names as asked  
puts "how many trajectories: "
gets stdin nt


for {set j 0} {$j < $nt} {incr j} {
puts "Enter mutation name (lowercase): "
gets stdin a

#molecule input e.g dhf-a26t.psf
mol load psf dhf-$a.psf
animate read dcd dhf-$a-s100-210ns.dcd waitfor all
	
	set nf [molinfo $j get numframes]
	set outfile [open htd_$a w]
		
		#wrapping
		
		pbc wrap -centersel "protein" -center com -compound fragment -all
		
		#aligning of protein
		for {set l 1} {$l < $nf} {incr l} {
	
			set sel1 [atomselect $j all frame $l]
			set sel2 [atomselect $j all frame $l+1]
			set transformation_matrix [measure fit $sel1 $sel2]
			set move_sel [atomselect $j "all"]
			$move_sel move $transformation_matrix
	
		}
		
		
		set a [atomselect $j "resname DHF and name C6"]
		set b [atomselect $j "resname NDPH and name NC4"]
		
		set n [$a get index]
		set m [$b get index]
		
		#hydride transfer distance measured and written
		for {set i 0} {$i<$nf} {incr i} {
		set dist [measure bond "$n $m" molid $j frame $i] 
		puts $outfile [format "%8d %8f" $i $dist]
		}		
		
	
	close $outfile
	mol delete $j
}