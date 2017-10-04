#!/bin/bash
#script to run quast on all the assemblies
for i in ec_pe_l*0
do
folder=$i
echo "starting on $i"
cd $i #change into the read folder which holds all the assemblies
#Start of mira
cd mira
quast.py -o $i-mira -t 12 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta ${folder}_assembly/${folder}_d_results/${folder}_out.unpadded.fasta
mv *-mira /cib/lisa/new_l100_paper1/quast
cd ../ #move out of mira dir
cd ../ #move out of the read dir
done
