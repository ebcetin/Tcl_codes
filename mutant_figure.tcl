#Representation script

# Load molecule
mol load psf dhf-a26t.psf
animate read dcd dhf-a26t-s100-210ns.dcd waitfor all
	
set nf [molinfo 0 get numframes]
# wrap the system	
pbc wrap -centersel "protein" -center com -compound fragment -all

# align the molecule	
for {set l 1} {$l < $nf} {incr l} {
	
	set sel1 [atomselect 0 all frame $l]
	set sel2 [atomselect 0 all frame $l+1]
	set transformation_matrix [measure fit $sel1 $sel2]
	set move_sel [atomselect 0 "all"]
	$move_sel move $transformation_matrix
}

# Display settings	
light 0 on
light 1 on
light 2 off
light 3 off
#Display color
color Display Background white
# turn on orthographic view
display projection Orthographic
# turn off axes in corner
axes location Off
# minimize near clip
display nearclip set 0.010000
# reset view angle 
display resetview

# Change Color

#protein

mol modselect 0 0 (protein and resid 1 to 8 25 to 159)
mol modcolor  0 0 ColorID 6
mol modstyle  0 0 NewCartoon
mol addrep 0
#M20
mol modselect 1 0 (protein and resid 9 to 24)
mol modcolor  1 0 ColorID 23
mol modstyle  1 0 NewCartoon
mol addrep 0
#Mutant
mol modselect 2 0 (resid 26 and name CA)
mol modcolor  2 0 ColorID 27
mol modstyle  2 0 VDW
mol addrep 0
#Outliers
mol modselect 3 0 (protein and resid 59 60 96 144 and name CA)
mol modcolor  3 0 ColorID 29
mol modstyle  3 0 VDW
mol addrep 0


