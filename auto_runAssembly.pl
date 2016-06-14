#!/usr/bin/perl
#use strict;
use warnings;

for($i=1; $i<=6;$i=$i+1){
  my $MID_file="mid_MID";
  my $MID_file_sff= '../'."$MID_file" . $i ."sff";
  system("perl runAssembly_PS.pl 15 45 5 15 50 5 95 99 1 $MID_file ../bothtrimfiles.fasta $MID_file_sff TRUE TRUE\n");
}
