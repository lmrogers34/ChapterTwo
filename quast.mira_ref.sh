#!/bin/bash
#script to run quast on all the assemblies
for i in ec_pe_l*0
do
folder=$i
echo "starting on $i"
cd $i #change into the read folder which holds all the assemblies
#Start of mira_ref
cd mira_ref
quast.py -o $i-mira_ref -T 12 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta ${folder}_assembly/${folder}_d_results/${folder}_out_E*.unpadded.fasta
mv *-mira_ref /cib/lisa/new_l100_paper1/quast
cd ../ #move out of mira_ref dir
cd ../ #move out of the read dir
doneji
