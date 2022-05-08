## measures distance between two atoms for different trajectories

puts "how many trajectories: "
gets stdin nt


for {set j 0} {$j < $nt} {incr j} {
puts "Enter mutation name (lowercase): "
gets stdin a

#molecule input e.g dhf-a26t.psf
mol load psf dhf-$a.psf
animate read dcd dhf-$a-s100-210ns.dcd waitfor all
	
	set nf [molinfo $j get numframes]
	set outfile [open Phe31_DHF_$a w]
	set outfile2 [open ILE14_NDPH_$a w]
	set outfile3 [open Ile14_Tyr100_$a w]	
	
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
		
		# Phe31 CZ-DHF C11 Distance
		set a [atomselect $j "resid 161 and name C11"]
		set b [atomselect $j "resid 31 and name CZ"]
		
		# Ile14 -O NADPH N Distance
		set c [atomselect $j "resid 164 and name NN7"]
		set d [atomselect $j "resid 14 and name O"]
		
		# Tyr 100 - O Ile 14 CD Distance
		set e [atomselect $j "resid 100 and name OH"]
		set f [atomselect $j "resid 14 and name CD"]
		
		
		set n [$a get index]
		set m [$b get index]
		
		set p [$c get index]
		set r [$d get index]
		
		set s [$e get index]
		set t [$f get index]
		
		#distances measured and written
		for {set i 0} {$i<$nf} {incr i} {
		set dist [measure bond "$n $m" molid $j frame $i] 
		puts $outfile [format "%8d %8f" $i $dist]
		}		
		
		close $outfile
		
		for {set i 0} {$i<$nf} {incr i} {
		set dist2 [measure bond "$p $r" molid $j frame $i] 
		puts $outfile2 [format "%8d %8f" $i $dist2]
		}
		
		close $outfile2
		
		for {set i 0} {$i<$nf} {incr i} {
		set dist3 [measure bond "$s $t" molid $j frame $i] 
		puts $outfile3 [format "%8d %8f" $i $dist3]
		}
		
		close $outfile3
	
	mol delete $j
}
