#!/bin/bash
for i in ec_pe_l250*0
do
if [ -d $i ]
then
echo $i
cd $i/sga/sais

for j in *-contigs.fa
do 
echo $j
assembly=${j/-contigs.fa/}
quast.py -o $assembly-sga-sais-quast -T 6 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta $j
mv $assembly-sga-sais-quast /cib/lisa/olc_sga/sga_quast
done

cd ../../../
fi
done

