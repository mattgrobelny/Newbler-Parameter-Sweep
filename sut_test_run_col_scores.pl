#!/usr/bin/perl
#use strict; 
use warnings;
my $qsub = ('qsub -I -q classroom');
my $module_load= ('module load 454');
my $runAssembly= ('runAssembly');
my $current_dir= `pwd`;

chomp $current_dir;

my @paravals= (30,30,95);
my $folder_name_for_it="Project1_0";

open(my $fh, '>', "$current_dir/Project1_newbler_scores.txt");
print {$fh} "folder_name,readlength,overlap,id,numberOfContigs,numberOfBases,avgContigSize,N50ContigSize,largestContigSize\n";
close ($fh);
##########################################################
# Collect quality scores,  takes in a newblermetric files and outputs a 
# 5 metric array 
### numberOfContigs   = ######;
### numberOfBases     = #########;

### avgContigSize     = ####;
### N50ContigSize     = ####;
### largestContigSize = #####;

sub col_scores{

#initilize collection vals 
my $numberOfContigs =0;
my $numberOfBases   =0;    
my $avgContigSize   =0;    
my $N50ContigSize   =0;
my $largestContigSize =0;
my $file_name="454NewblerMetrics.txt";
	
#orient directory
chdir "$current_dir/$folder_name_for_it/assembly/";

#whole metrics file variable
my $whole_file=0;
#open 454NewblerMetrics.txt
open (my $FILE,'<', $file_name ) or die "Could not open file $file_name $! \n";

#import complete metrics files for processing
while (my $line = <$FILE>){
$whole_file=$whole_file . $line;
}
close ($FILE);

$whole_file=~ /numberOfContigs   = (.+)\;/ ;
$numberOfContigs  =$1;
$whole_file=~ /numberOfBases     = (.+)\;/ ;
$numberOfBases    =$1;
$whole_file=~ /avgContigSize     = (.+)\;/ ;
$avgContigSize    =$1;
$whole_file=~ /N50ContigSize     = (.+)\;/ ;
$N50ContigSize    =$1; 
$whole_file=~ /largestContigSize = (.+)\;/ ;
$largestContigSize=$1;  

chdir "$current_dir";

my @scores = ($numberOfContigs,$numberOfBases,$avgContigSize,$N50ContigSize,$largestContigSize);
return @scores;
}
####################################################################################################

print "testing sub  \n";
#my @scoresss=0;
#col_scores($folder_name_for_it);
@scoresss= col_scores($folder_name_for_it);
#print "here are the scores @scoresss \n";
 
#run Newbler with paramters --> ouputs @runAssembly_paras
#run_Assembly(@paravals);

#extract scores from newblermetrics file
push @paravals, col_scores($folder_name_for_it);

#split into comma seperated text 
my $Final_output=0;
$Final_output=join(",", @paravals);
print"@paravals\n";

#save masterlist data to file
open(my $fh, '>>', "$current_dir/Project1_newbler_scores.txt");

print {$fh} "$Final_output\n";

close ($fh);	 

print"DONEE with @paravals\n";




####################################################################################

	 
