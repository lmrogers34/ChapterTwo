#!/bin/bash
#Trying to automate assembly of reads.
#Will take reads and in the assembly folder, create a reads folder which will contain the different assemblies of that reads
#example of read file name : ec_pe_l250_f100_1.fq
for i in /storage/lisa/Reads/Simulated/Paired/ec_pe_l75_f40*1.fq
do
read1=$i #paired reads, only diff is _1 or _2
read2=${read1/_1/_2} #names the second read
first=${read1/_1.fq/} #removes the trailing _1.fq
folder=${first/\/storage\/lisa\/Reads\/Simulated\/Paired\//} #removes the start of the path so can have a folder with the read name.  
mkdir $folder
cd $folder #changes into a read specific folder
#Spades
mkdir spades
cd spades # change sinto spades dir
spades.py -1 $read1 -2 $read2 -o spades_default
#spades.py -1 $read1 -2 $read2 --careful -o spades_careful
spades.py -1 $read1 -2 $read2 -k 21,25,29,33,37,41,45,49,53,57,61,65,69,73 -o spades_kmer-range
#spades.py -1 $read1 -2 $read2 --only-assembler -o spades-no_correction
cd ../ #changes out of spades dir
echo "Spades assembler done for $folder"
cd ../ #changes back into original assesment dir to rerun read analysis
echo "End of assemblers for $folder"
done

