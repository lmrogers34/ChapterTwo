#!/bin/bash
#script to run quast on all the assemblies
for i in ec_pe_l150_f20
do
echo "starting on $i"
cd $i #change into the read folder which holds all the assemblies
#Velvet assessment
cd velvet_ref
for j in *
do
if [ -d "$j" ]
then
quast.py -o $i-$j-velvet_ref -T 1 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta $j/contigs.fa
fi
done
mv *-velvet_ref /cib/lisa/new_l100_paper1/quast
cd ../ #move out of velvet dir
cd ../ #move out of the read dir
done
