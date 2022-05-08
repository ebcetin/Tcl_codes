set filename "r98p-dipole.txt"
set fileId [open $filename "w"]


set n [molinfo top get numframes]
set a [atomselect top "resid 56 57 58 and protein" ]

for {set i 0} {$i < $n} {incr i} {

	$a frame $i
	set b [measure dipole $a -debye -masscenter]
	puts $fileId $b
	
}

close $fileId