# NEWBLER PARAMETERS SWEEP v1.0 
This script is designed to iterate throught several variables which are necessary to run runAssembly, a program used to assemble 454 reads.

For this version the script iterates throught:
- read length
- minimum overlap lenght
- minimum idenity %

NEWBLER PARAMETERS SWEEP v1.0 
	

Requires: 
	- GS denovo Assembler (Newbler)
	- .sff file
	- vectortrimfiles.fasta
	
To run this program you need to write parameters values in this order: 
	
	-readlength_minimum -readlength_maximum -readlength_step -min_minoverlap -max_minoverlap -step_minoverlap -min_min_id -max_min_id -step_min_id -Projectname(will also be foldername) 
	
EXAMPLE:

	perl runAssembly_PS 15 50 5 15 50 5 95 99 1 Project1
	
Some parameters where hard coded in the version... sorry if you dont see the parameter you want to iterate throught...\n
