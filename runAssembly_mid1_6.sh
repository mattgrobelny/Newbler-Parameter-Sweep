#!/bin/bash

for i in {1..6}; do ./nohup perl runAssembly_PS.pl 15 45 5 15 50 5 95 99 1 Mid_$i ../bothtrimfiles.fasta ../mid_MID$i.sff &; done
