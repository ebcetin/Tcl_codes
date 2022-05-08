### Gathers force information from log file for SMD
### Open the log file for reading and the output .dat file for writing

set file [open 5Ans_r13.log r]
set output [open ft_13.dat w]

### Gather input from user

### components of the Force vector
set nx 0.0125
set ny -0.9896
set nz 0.1434

### Loop over all lines of the log file
set file [open 5Ans_r13.log r]
while { [gets $file line] != -1} {

### Determine if a line contains SMD output.If so,write the
### timestep followed by f(dot)n to the output file

	if {[lindex $line 0]== "SMD"} {
	puts $output "[lindex $line 1] [expr $nx*[lindex $line 5]+ $ny*[lindex $line 6]+ $nz*[lindex $line 7]]"
	}
}

### Close the log file and the output .dat file
close $file
close $output