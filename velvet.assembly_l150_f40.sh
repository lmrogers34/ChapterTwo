#!/bin/bash
for i in /home/lrogers/work/deNovo-stats/Reads/Simulated/Paired/new_reads/ec_pe_l150_f40*1.fq
do
read1=$i #paired reads, only diff is _1 or _2
read2=${read1/_1/_2} #names the second read
first=${read1/_1.fq/} #removes the trailing _1.fq
folder=${first/\/home\/lrogers\/work\/deNovo-stats\/Reads\/Simulated\/Paired\/new_reads\//} #removes the start of the path so can have a folder with the read name. 



if [ -d $folder ] # $folder exists
then
cd $folder #changes into a read specific folder
else
mkdir $folder
cd $folder #changes into a read specific folder
fi

mkdir velvet
cd velvet #changes into vel dir
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
   velveth ./$j $j -separate -fastq -shortPaired $read1 $read2 
   #Velvet g just done basically at first, can play around with parameters later
   velvetg ./$j -cov_cutoff auto -min_contig_lgth 200 -exp_cov auto 
   echo "finished $j"   
else #else folder doesn't exist, create the folder and do the assembly. 
   mkdir $j
   velveth ./$j $j -separate -fastq -shortPaired $read1 $read2 
   #Velvet g just done basically at first, can play around with parameters later
   velvetg ./$j -cov_cutoff auto -min_contig_lgth 200 -exp_cov auto 
   echo "finished $j"
fi
done
cd ../ #changes out of vel dir
echo "velvet done"
cd ../
done
