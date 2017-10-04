#!/bin/bash
# recreated on 04-04-15
for i in /home/lrogers/work/deNovo-stats/Reads/Simulated/Paired/new_reads/ec_pe_l150_f20*1.fq
do
read1=$i #paired reads, only diff is _1 or _2
read2=${read1/_1/_2} #names the second read
first=${read1/_1.fq/} #removes the trailing _1.fq
folder=${first/\/home\/lrogers\/work\/deNovo-stats\/Reads\/Simulated\/Paired\/new_reads\//} #removes the start of the path so can have a folder with the read name. 
reference=/cib/lisa/denovo/ref/ec_55989_NC_011748.fna



cd $folder #changes into a read specific folder 
if [ -d velvet_ref ]
then
cd velvet_ref #changes into vel dir
else
mkdir velvet_ref
cd velvet_ref #changes into vel dir
fi

for j in {101..127..2}
do
echo "beginning $j"
if [ -a $j/contigs.fa ] #if the folder and assembly exists do nothing
then
   echo "$j done"
elif [ -a $j ] #if the folder without the assembly delete the folder, and do the assembly
then
   rm -r $j
   mkdir $j
   #velveth ./$j $j -reference $reference -separate -fastq -shortPaired -sam ../$folder.sorted.sam
   #ec_pe_l150_f80_Aligned.out.sam
   velveth ./$j $j -reference $reference -separate -fastq -shortPaired $read1 $read2 -sam /cib/lisa/new_l100_paper1/${folder}/${folder}_ref/${folder}_sorted.sam 
   velvetg ./$j -cov_cutoff auto -min_contig_lgth 200 -exp_cov auto 
   echo "finished $j"   
else #else folder doesn't exist, create the folder and do the assembly. 
   mkdir $j
   velveth ./$j $j -reference $reference -separate -fastq -shortPaired $read1 $read2 -sam /cib/lisa/new_l100_paper1/${folder}/${folder}_ref/${folder}_sorted.sam 
   velvetg ./$j -cov_cutoff auto -min_contig_lgth 200 -exp_cov auto 
   echo "finished $j"
fi
done
cd ../ #changes out of vel dir
echo "velvet done"
cd ../
done
