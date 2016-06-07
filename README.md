# NEWBLER PARAMETERS SWEEP v1.0

**Problem:** Running GS denovo Assembler (Newbler) on a .sff requires selection of several key parameter: minimum read length, minimum overlap length and minimum percent identity. For a given .sff file knowing the optimal values for these parameters is usually unclear.

**Goal:** The goal of this script is to test out a range of values for Newblers key parameters and collect resulting scores for each assembly (number of Contigs, number of bases, avg contig size, N50 Contig size, largest Contig size).

**Solution/What the script does:** This script is designed to iterate through several variables which are necessary to run runAssembly, a program used to assemble 454 pyrosequencing reads.

**Who should use this script:** If you have 454 pyrosequencing data and want to find out how your assembly changes when you systematically tweak the values for; minimum read length, minimum overlap length and minimum percent identity, then this script is for you!

#### Requires:
- GS denovo Assembler (Newbler)
- .sff file
- vectortrimfiles.fasta

#### Internal NEWBLER runAssembly Defaults
- ss 1  --> seed step parameter

- sl 10 --> seed length parameter

- sc 10 --> seed count parameter

- force --> will overwrite files of the same name

- cpu 0 --> use all cpus

- nobig --> do not output big files (ace, bam ...)

#### For this version the script uses:
- read length
- minimum overlap length
- minimum identity %

#### Basics of the program:

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

**INPUT-->** *Parameters : Readlength, Overlap, Id*

**OUTPUT-->** *Scores for each assembly: numberOfContigs, numberOfBases, avgContigSize, N50ContigSize, largestContigSize*

--> The script will preform basic data analysis for you if the last two parameters passed in a "TRUE TRUE"(look at example below). First "TRUE" prints graphs, Second "TRUE" prints recommend assembly parameters based on each score.

Data analysis consists:
- 14 boxplot graphs (comparing each input parameter against each score)
- Analysis report, outputs a textual report of best parameter combinations for each score.

#### To run this program you need to write parameters values in this order:

	-readlength_minimum -readlength_maximum -readlength_step -min_minoverlap -max_minoverlap -step_minoverlap -min_min_id -max_min_id -step_min_id -Projectname(will also be foldername) -vectortrimfiles -sff_file -PrintGraphs (TRUE or FALSE) -PrintRecommendedParameters (TRUE or FALSE)

##### Example:
	perl runAssembly_PS 15 45 5 15 50 5 95 99 1 Project1 ../bothtrimfiles.fasta ../mid_MID1.sff TRUE TRUE

##### Recommend running in background:
	nohup perl runAssembly_PS 15 45 5 15 50 5 95 99 1 Project1 ../bothtrimfiles.fasta ../mid_MID1.sff TRUE TRUE &

*Some parameters where hard coded in the version... sorry if you do not see the parameter you want to iterate through...*

##### Goals for the Project:
- [x] Iterate across several key variables in runAssembly
- [x] Output scores report for each assembly and the corresponding parameter combination
- [x] Perform analysis on scores report (print graphs)
- [x] Suggest recommended assembly parameters for specific .sff file based on scores
