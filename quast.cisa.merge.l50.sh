#!/bin/bash
for i in ec_pe_l50_f[468]0
do
if [ -d $i ]
then
echo $i
if [ -f $i/${i}.denovo.merge.cisa.fa ]
then
echo "cisa merged for $i"
assembly=${i/.denovo.merge.cisa.fa/} #removes the start of the path so can have a folder with the read name.
quast.py -o $assembly-merged-quast -T 24 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta $i/${i}.denovo.merge.cisa.fa 
mv $assembly-merged-quast /cib/lisa/olc_sga/merge/merged_quast
fi # end of file check
fi # end of dir check
done

