#!/bin/bash
for i in ec_pe_l101*0
do
if [ -d $i ]
then
echo $i
cd $i/sga

for j in *-contigs.fa
do 
echo $j
assembly=${j/-contigs.fa/}
quast.py -o $assembly-sga-quast -T 6 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta $j
mv $assembly-sga-quast /cib/lisa/olc_sga/sga_quast
done

cd ../../
fi
done

