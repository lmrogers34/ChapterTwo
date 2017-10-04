#!/bin/bash
#script to run quast on all the assemblies
for i in ec_pe_l150_f40
do
echo "starting on $i"
cd $i #change into the read folder which holds all the assemblies
#Velvet assessment
cd velvet
for j in {101..127..2}
do
if [ -d "$j" ]
then
quast.py -o $i-$j-velvet -t 12 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta $j/contigs.fa
fi
done
mv *-velvet /cib/lisa/new_l100_paper1/quast
cd ../ #move out of velvet dir
cd ../ #move out of the read dir
done
