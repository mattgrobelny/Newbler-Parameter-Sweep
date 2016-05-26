# NEWBLER PARAMETERS SWEEP v1.0
This script is designed to iterate through several variables which are necessary to run runAssembly, a program used to assemble 454 pyrosequencing reads.

#### Requires:
- GS denovo Assembler (Newbler)
- .sff file
- vectortrimfiles.fasta

### Internal NEWBLER runAssembly Defaults
- ss 1  --> seed step parameter

- sl 10 --> seed length parameter 6 to 15

- sc 10 --> seed count parameter

- force --> will overwrite files of the same name

- cpu 0 --> use all cpus

- nobig --> do not output big files (ace, bam ...)

### For this version the script iterates through:
- read length
- minimum overlap length
- minimum identity %

## Basics of the program:

--> This program takes the minimum, maximum and step value for each parameter:
- read length
- minimum overlap length
- minimum identity %

--> Then it will run parameters iterations from max values to minimum values by passing parameter combos into the runAssembly program (part of the Newbler package) until it fails to produce an assembly (usually happens at lower read length values).

--> The program outputs a comma separated text file containing the folder name, parameters used and the scores for that assembly:

	Folder_name,Readlength,Overlap,Id,numberOfContigs,numberOfBases,avgContigSize,N50ContigSize,largestContigSize
	Project1_0,45,50,99,24,36197,1508,1809,8402
	Project1_1,45,50,98,25,36844,1473,2208,8090
	...

*Parameters : Readlength, Overlap, Id*

*Scores for each assembly: numberOfContigs, numberOfBases, avgContigSize, N50ContigSize, largestContigSize*

### To run this program you need to write parameters values in this order:

	-readlength_minimum -readlength_maximum -readlength_step -min_minoverlap -max_minoverlap -step_minoverlap -min_min_id -max_min_id -step_min_id -Projectname(will also be foldername) -vectortrimfiles -sff_file

### Example:
	perl runAssembly_PS 15 50 5 15 50 5 95 99 1 Project1 ../bothtrimfiles.fasta ../mid_MID1.sff

### Recommend running in background:
	nohup perl runAssembly_PS 15 50 5 15 50 5 95 99 1 Project1 ../bothtrimfiles.fasta ../mid_MID1.sff &

*Some parameters where hard coded in the version... sorry if you do not see the parameter you want to iterate through...*

## Goals for the Project:
- [x] Iterate across several variables in runAssembly
- [x] Output scores report for each assembly and the corresponding parameter combination
- [ ] Perform analysis on scores report (print graphs)
- [ ] Suggest recommended assembly parameters for specific .sff file based on scores
