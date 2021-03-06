#!/bin/bash
for i in /home/lrogers/work/deNovo-stats/Reads/Simulated/Paired/new_reads/ec_pe_l150_f20*1.fq
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

mkdir soapdenovo2

#Soap Denovo 2
cd soapdenovo2 #changes into soap dir
#create soap.conf file
touch $folder.conf
echo "#maximal read length" >>$folder.conf
echo "max_rd_len=150" >>$folder.conf 
echo "[LIB]" >>$folder.conf
echo "#average insert size" >>$folder.conf
echo "avg_ins=400" >>$folder.conf
echo "#if sequence needs to be reversed" >>$folder.conf
echo "reverse_seq=0" >>$folder.conf
echo "#in which part(s) the reads are used" >>$folder.conf
echo "asm_flags=3" >>$folder.conf
echo "#3 both contig and scaffolding" >>$folder.conf
echo "#use only first 50 bps of each read" >>$folder.conf
echo "rd_len_cutoff=300" >>$folder.conf
echo "#in which order the reads are used while scaffolding" >>$folder.conf
echo "rank=1" >>$folder.conf
echo "# cutoff of pair number for a reliable connection (at least 3 for short insert size)" >>$folder.conf
echo "pair_num_cutoff=3" >>$folder.conf
echo "#minimum aligned length to contigs for a reliable read location (at least 32 for short insert size)" >>$folder.conf
echo "map_len=32" >>$folder.conf
echo "#a pair of fastq file, read 1 file should always be followed by read 2 file" >>$folder.conf
echo "q1=$read1" >>$folder.conf
echo "q2=$read2" >>$folder.conf
#end of .conf file
for h in {101..127..2}
do
if [ -a $folder-k$h/$folder-k$h.contig ] #if the folder and assembly exists do nothing
then
   echo "$folder-k$h done"
elif [ -a $folder-k$h ] #if the folder without the assembly delete the folder, and do the assembly
then
   echo "$folder-k$h exists but no assembly so restarting"
   rm -r $folder-k$h
   mkdir $folder-k$h
   cd $folder-k$h #changes into that folder
   SOAPdenovo-127mer all -s ../$folder.conf -K $h -R -o $folder-k$h #as now the conf file is a dir up.
   echo "k-mer $h done" 
   cd ../ #comes out of that folder
else #else folder doesn't exist, create the folder and do the assembly. 
   echo "Beginning assembly for $folder-k$h"
   mkdir $folder-k$h
   cd $folder-k$h #changes into that folder
   SOAPdenovo-127mer all -s ../$folder.conf -K $h -R -o $folder-k$h #as now the conf file is a dir up.
   echo "k-mer $h done"
   cd ../ #comes out of that folder
fi
done
cd ../ #leaves soapdenovo2 dir
echo "Soapdenovo2 assembler done"
cd ../ #changes back into original assesment dir to rerun read analysis
echo "End of Soap assembly for $folder"
done
