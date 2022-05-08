#searches rmsd below a threshold and gets the index 
#of that atoms

set sel1 [atomselect 0 "backbone"]
for {set index 0 } {$index < 1051} {incr index} {
set sel2 [atomselect 1 "backbone" frame $index]
set c [measure rmsd $sel1 $sel2]
if {$c < 2}{ puts $c $index} 
}