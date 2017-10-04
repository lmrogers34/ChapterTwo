#!/bin/bash
#script to run quast on all the assemblies, all but l100s
for i in ec_pe_l150_f60
do
echo "starting on $i"
cd $i #change into the read folder which holds all the assemblies
#Velvet assessment
#Start of soapdenovo2
cd soapdenovo2
for m in *k{101..127..2}
do
if [ -d "$m" ]
then
quast.py -o $m-soap -t 12 -L --gene-finding -R /storage/lisa/ref/E.coli.O104\:H4.fasta $m/*.contig
fi
done
mv *-soap /cib/lisa/new_l100_paper1/quast
cd ../ #move out of soapdenovo2 dir
cd ../ #move out of the read dir
done
