### Open the log file for reading and the output .dat file for writing
set file [open 5Ans_r13.log r]
set output [open dt_13.dat w]

### coordinates of the fixed atom
set x 3.998  
set y 47.932
set z -23.723


### Loop over all lines of the log file
set file [open 5Ans_r13.log r]

while { [gets $file line] != -1} {

### Determine if a line contains SMD output.If so,write the
### timestep followed by f(dot)n to the output file

	if {[lindex $line 0]== "SMD"} {
	
	puts $output "[lindex $line 1] [expr sqrt (([lindex $line 2]-$x)**2+([lindex $line 3]-$y)**2 +([lindex $line 4]-$z)**2)]"
	}
	
}

### Close the log file and the output .dat file
close $file
close $output