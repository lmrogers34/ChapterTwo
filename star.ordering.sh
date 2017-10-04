#!/bin/bash
#Running STAR
# index ref genome, or in this case closely related genome - Already indexed
#STAR --runThreadN 24 --runMode genomeGenerate --genomeDir /cib/lisa/ref-based/genomeIndex --genomeFastaFiles /cib/lisa/denovo/ref/ec_55989_NC_011748.fna --sjdbGTFfile /cib/lisa/denovo/ref/ec_55989_NC_011748.gff --sjdbOverhang 299
#alignment
for i in /home/lrogers/work/deNovo-stats/Reads/Simulated/Paired/new_reads/*1.fq
do
read1=$i #paired reads, only diff is _1 or _2
read2=${read1/_1/_2} #names the second read
first=${read1/_1.fq/} #removes the trailing _1.fq
folder=${first/\/home\/lrogers\/work\/deNovo-stats\/Reads\/Simulated\/Paired\/new_reads\//} #removes the start of the path so can have a folder with the read name. 
mkdir ${folder}/${folder}_ref
#STAR --runThreadN 24 --runMode alignReads --genomeDir /cib/lisa/ref-based/genomeIndex --readFilesIn $read1 $read2 --ou‎tFileNamePrefix ${folder}_ref/$folder
STAR --runThreadN 24 --runMode alignReads --genomeDir /cib/lisa/ref-based/genomeIndex/ --readFilesIn $read1 $read2 --outFileNamePrefix ${folder}/${folder}_ref/${folder}_
done



