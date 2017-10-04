#!/bin/bash
#for i in ec_*
for i in ec_pe_l250_f80
do
if [ -d $i ]
then
echo $i
if [ -f $i/${i}.denovo.merge.cisa.fa ]
then
echo "cisa merged for $i"
assembly=${i/.denovo.merge.cisa.fa/} #removes the start of the path so can have a folder with the read name.
quast.py -o $assembly-merged-quast -T 24 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta $i/${i}.denovo.merge.cisa.fa 
mv $assembly-merged-quast /cib/lisa/new_l100_paper1/merged_quast
fi # end of file check
fi # end of dir check
done

for i in ec_pe_l50_f100_merge6
do
if [ -d $i ]
then
echo $i
if [ -f $i/${i}.denovo.merge.cisa.fa ]
then
echo "cisa merged for $i"
assembly=${i/.denovo.merge.cisa.fa/} #removes the start of the path so can have a folder with the read name.
quast.py -o $assembly-merged-quast -T 24 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta $i/${i}.denovo.merge.cisa.fa 
mv $assembly-merged-quast /cib/lisa/new_l100_paper1/merged_quast
fi # end of file check
fi # end of dir check
done


for i in ec_pe_l75_f80
do
if [ -d $i ]
then
echo $i
if [ -f $i/${i}.denovo.merge.cisa.fa ]
then
echo "cisa merged for $i"
assembly=${i/.denovo.merge.cisa.fa/} #removes the start of the path so can have a folder with the read name.
quast.py -o $assembly-merged-quast -T 24 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta $i/${i}.denovo.merge.cisa.fa 
mv $assembly-merged-quast /cib/lisa/new_l100_paper1/merged_quast
fi # end of file check
fi # end of dir check
done

for i in ec_pe_l75_f100
do
if [ -d $i ]
then
echo $i
if [ -f $i/${i}.denovo.merge.cisa.fa ]
then
echo "cisa merged for $i"
assembly=${i/.denovo.merge.cisa.fa/} #removes the start of the path so can have a folder with the read name.
quast.py -o $assembly-merged-quast -T 24 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta $i/${i}.denovo.merge.cisa.fa 
mv $assembly-merged-quast /cib/lisa/new_l100_paper1/merged_quast
fi # end of file check
fi # end of dir check
done
