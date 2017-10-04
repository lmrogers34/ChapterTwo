#!/bin/bash
#script to run quast on all the assemblies
for i in ec_pe_l75*0
do
echo "starting on $i"
cd $i #change into the read folder which holds all the assemblies
#Start of Spades
cd spades
for j in spades*
do
if [ -d "$j" ]
then
quast.py -o $i-$j-contig -T 24 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta $j/contigs.fasta
mv *-spades* /cib/lisa/new_l100_paper1/redo_spades/quast
fi
done
cd ../ #move out of spades di
#End of spades
cd ../ #move out of the read dir
done
