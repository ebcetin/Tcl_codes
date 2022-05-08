#align two pdbs
set sel0 [atomselect 0 all]	 
set sel1 [atomselect 1 all]	 
set M [measure fit $sel0 $sel1]	 
$sel0 move $M