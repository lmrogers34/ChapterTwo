#!/bin/bash
#for i in ec_*
for i in ec_*_denovo_merge3
do
if [ -d $i ]
then
echo $i
if [ -f $i/${i}.denovo.merge3.cisa.fa ]
then
echo "cisa merged for $i"
assembly=${i/.denovo.merge3.cisa.fa/} #removes the start of the path so can have a folder with the read name.
quast.py -o $assembly-merged-quast -T 24 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta $i/${i}.denovo.merge3.cisa.fa 
mv $assembly-merged-quast /cib/lisa/new_l100_paper1/merged_quast
fi # end of file check
fi # end of dir check
done

