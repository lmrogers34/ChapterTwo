#!/bin/bash
for i in /home/lrogers/work/deNovo-stats/Reads/Simulated/Paired/new_reads/*1.fq
do
read1=$i #paired reads, only diff is _1 or _2
read2=${read1/_1/_2} #names the second read
first=${read1/_1.fq/} #removes the trailing _1.fq
folder=${first/\/home\/lrogers\/work\/deNovo-stats\/Reads\/Simulated\/Paired\/new_reads\//} #removes the start of the path so can have a folder with the read name. 
reference=/cib/lisa/denovo/ref/ec_55989_NC_011748.fna

if [ -d $folder ] # $folder exists
then
cd $folder #changes into a read specific folder
else
mkdir $folder
cd $folder #changes into a read specific folder
fi
printf "path is "
pwd

mkdir mira_ref
cd mira_ref #change into mira dir
#create manifest.conf file
printf "path is "
pwd
if [ -f manifest.conf ]
then
echo "old file exists..  deleting..."
rm manifest.conf
fi

touch manifest.conf
echo "#Example for a manifest file describing a de-novo assembly with paired Illumina data" >>manifest.conf
echo "#Part 1 : Definitions">>manifest.conf
echo "project = $folder">>manifest.conf
echo "job = mapping,genome,accurate" >>manifest.conf
#echo "parameters = -NW:cmrnl=warn" >>manifest.conf
echo "#Part 2 : Sequencing data" >>manifest.conf
echo "#Reference data" >>manifest.conf
echo "readgroup" >>manifest.conf
echo "is_reference" >>manifest.conf
echo "data = $reference" >>manifest.conf
echo "strain = E.coli O104" >>manifest.conf
echo "#sequencing data" >>manifest.conf
echo "readgroup = Ecoli-paired" >>manifest.conf
echo "data = fastq::$read1 fastq::$read2">>manifest.conf
echo "technology = solexa" >>manifest.conf
echo "template_size = 100 200 autorefine " >>manifest.conf # insert size is 400
echo "segment_placement = ---> <--- " >>manifest.conf
echo "segment_naming = solexa" >>manifest.conf
#End of manifest file
mira -t 8 manifest.conf  # makes mira ignore problem with long read names
cd ../ #exit out of mira dir
echo "mira assembly done"
cd ../ #changes back into original assesment dir to rerun read analysis
echo "End of assemblers for $folder"
done
