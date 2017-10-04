#!/bin/bash
#script to run quast on all the assemblies
for i in ec_pe_l150_f60
do
folder=$i

if [ -d "$folder" ]
then
echo $folder
cd $folder/abyss
#Abyss for loop

for k in {101..127..2}
do
quast.py -o $i-$k-abyss-quast -T 2 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta $k/${folder}-$k-contigs.fa
done # end of k for loop
mv $i*-abyss-quast /cib/lisa/new_l100_paper1/quast
cd ../../ # change of abyss and folder dirs
fi # end of if check for folder
done

