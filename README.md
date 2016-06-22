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

## Basics of the program:

1. This program takes the minimum, maximum and step value for each parameter:

	`-read length
	-minimum overlap length
	-minimum identity %`

2. Then it will run parameters iterations from max values to minimum values by passing parameter combos into the runAssembly program (part of the Newbler package) until it fails to produce an assembly (usually happens at lower read length values).

3. The program outputs a comma separated text file containing the folder name, parameters used and the scores for that assembly:

	`Folder_name,Readlength,Overlap,Id,numberOfContigs,numberOfBases,avgContigSize,N50ContigSize,largestContigSize
	Project1_0,45,50,99,24,36197,1508,1809,8402
	Project1_1,45,50,98,25,36844,1473,2208,8090
	...`

**INPUT-->** *Parameters : Readlength, Overlap, Id*

**OUTPUT-->** *Scores for each assembly: numberOfContigs, numberOfBases, avgContigSize, N50ContigSize, largestContigSize*

4. The script will preform basic data analysis if the last two parameters passed in are: "TRUE TRUE"(look at example below). First "TRUE" prints graphs, Second "TRUE" prints recommend assembly parameters based on each score.

Data analysis consists:
- 14 boxplot graphs (comparing each input parameter against each score)
- Analysis report, outputs a textual report of best parameter combinations for each score.

#Script Usage

### Basic Run

Run Newbler Parameter Sweep using built in DEFAULTS (see below), this provides the broadest range of parameter combinations.
To run this script using default parameters, you will however need to pass in these three required parameter:
	-projectName (Title of project will also be file name)
	-vectorTrimfiles (adapter and vector sequences for trimming)
	-sff_file (.sff file (demultiplexed) from sequencing)

#### Basic Run Command line Example:

	perl runAssembly_PS.pl -projectName Project2 -vectorTrimfiles ./bothtrimfiles.fasta -sff_file ./mid_MID1.sff

## Optional Options
Use these parameters to tweak the range of parameter iteration and the step values or turn on data analysis options

#### Control iteration range for the read length parameter:

	-readlength_Min  (Minimum read length cutoff- lowest value)	[Min accepted value: 15 || DEFAULT: 15]
	-readlength_Max  (Minimum read length cutoff- highest value)[Max accepted value: 45 || DEFAULT: 45]
	-readlength_Step (Minimum read length cutoff- step value)		[Accepted value range: 1 to 10 || DEFAULT: 5]

##### Control iteration range for the minimum overlap parameter:

	-minoverlap_Min  (Minimum overlap length cutoff- lowest value)	[Min accepted value: 15 || DEFAULT: 15]
	-minoverlap_Max  (Minimum overlap length cutoff- highest value)	[Max accepted value: 50 || DEFAULT: 50]
	-minoverlap_Step (Minimum overlap length cutoff- step value)		[Accepted value range: 1 to 10 || DEFAULT: 5]

##### Control iteration range for the minimum overlap parameter:

	-min_id_Min      (Identity percentage cutoff- lowest value)		[Min accepted value: 50 || DEFAULT: 95]
	-min_id_Max      (Identity percentage cutoff- highest value)	[Max accepted value: 45 || DEFAULT: 99]
	-min_id_Step     (Identity percentage cutoff- step value)			[Accepted value range: 1 to 10 || DEFAULT: 1]

#### Data Analysis Options
Use these parameters to run data analysis on assembly scores output:

	-printGraphs	(TRUE or FALSE - prints 14 graphs) [DEFAULT: TRUE]
	-printrecommendedParameters (TRUE or FALSE - outputs report with recommended parameter combinations)[DEFAULT: TRUE]


## Command Line Examples

#### Custom Run Using all Parameters:

	perl runAssembly_PS.pl -readlength_Min 20 -readlength_Max 30 -readlength_Step 1 -minoverlap_Min 20 -minoverlap_Max 30 -minoverlap_Step 1 -min_id_Min 95 -min_id_Max 99 -min_id_Step 1 -printGraphs  TRUE -printrecommendedParameters TRUE -projectName Project1 -vectorTrimfiles project1_vector_trim.fasta -sff_file mid1_Project1.sff

#### Recommend running in background:
Depending on the range of parameter combinations I recommend using 'nohup'  and '&' to redirect output to nohup.txt and run in background.

	nohup perl runAssembly_PS.pl -readlength_Min 20 -readlength_Max 30 -readlength_Step 1 -minoverlap_Min 20 -minoverlap_Max 30 -minoverlap_Step 1 -min_id_Min 95 -min_id_Max 99 -min_id_Step 1 -printGraphs  TRUE -printrecommendedParameters TRUE -projectName Project1 -vectorTrimfiles project1_vector_trim.fasta -sff_file mid1_Project1.sff &

*or using the DEFAULT run:*

	nohup perl runAssembly_PS.pl -projectName Project2 -vectorTrimfiles ./bothtrimfiles.fasta -sff_file ./mid_MID1.sff &

*Some parameters where hard coded in the version... sorry if you do not see the parameter you want to iterate through...*

##### Goals for the Project:
- [x] Iterate across several key variables in runAssembly
- [x] Output scores report for each assembly and the corresponding parameter combination
- [x] Perform analysis on scores report (print graphs)
- [x] Suggest recommended assembly parameters for specific .sff file based on scores
- [x] Improve parameter parsing and add default parameters
