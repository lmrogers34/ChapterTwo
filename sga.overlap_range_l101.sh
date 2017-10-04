#!/bin/bash
for i in ec_pe_l101*0
do 
cd $i/sga
if [ -s reads.ec.filter.pass.fa ]
then 
echo "reads filtered for $i"
echo "performing low overlapping sga for $i"
sga overlap -m 20 -t 24 reads.ec.filter.pass.fa
echo "overlap done for $i"
# assembly with range of overlaps.. 
for k in {21..101..2}
do
echo "starting assembly for $k"
sga assemble -m $k --min-branch-length 400 -o ${i}_overlap_$k reads.ec.filter.pass.asqg.gz
echo "assembly done for $i"
done

elif [ -f reads.ec.filter.pass.fa ] 
then
echo "empty file for $i"
#Preprocessing
# Preprocess the data to remove ambiguous basecalls
sga preprocess --pe-mode 1 -o reads.pp.fastq /home/lrogers/work/deNovo-stats/Reads/Simulated/Paired/new_reads/${i}_1.fq /home/lrogers/work/deNovo-stats/Reads/Simulated/Paired/new_reads/${i}_2.fq
# Error Correction
# Build the index that will be used for error correction
# As the error corrector does not require the reverse BWT, suppress
# construction of the reversed index
sga index -a ropebwt -t 8 --no-reverse reads.pp.fastq
# Perform k-mer based error correction.
# The k-mer cutoff parameter is learned automatically.
sga correct -k 41 --learn -t 8 -o reads.ec.fastq reads.pp.fastq
# Primary (contig) assembly
# Index the corrected data.
sga index -a ropebwt -t 8 reads.ec.fastq
# Remove exact-match duplicates and reads with low-frequency k-mers
sga filter -x 2 -t 8 reads.ec.fastq
# Compute the structure of the string graph
echo "performing low overlapping sga for $i"
sga overlap -m 20 -t 24 reads.ec.filter.pass.fa
echo "overlap done for $i"
# assembly with range of overlaps.. 
# Perform the contig assembly
for k in {21..101..2}
do
echo "starting assembly for $k"
sga assemble -m $k --min-branch-length 400 -o ${i}_overlap_$k reads.ec.filter.pass.asqg.gz
echo "assembly done for $i"
done


else
echo "No file at all for $i"
#Preprocessing
# Preprocess the data to remove ambiguous basecalls
sga preprocess --pe-mode 1 -o reads.pp.fastq /home/lrogers/work/deNovo-stats/Reads/Simulated/Paired/new_reads/${i}_1.fq /home/lrogers/work/deNovo-stats/Reads/Simulated/Paired/new_reads/${i}_2.fq
# Error Correction
# Build the index that will be used for error correction
# As the error corrector does not require the reverse BWT, suppress
# construction of the reversed index
sga index -a ropebwt -t 8 --no-reverse reads.pp.fastq
# Perform k-mer based error correction.
# The k-mer cutoff parameter is learned automatically.
sga correct -k 41 --learn -t 8 -o reads.ec.fastq reads.pp.fastq
# Primary (contig) assembly
# Index the corrected data.
sga index -a ropebwt -t 8 reads.ec.fastq
# Remove exact-match duplicates and reads with low-frequency k-mers
sga filter -x 2 -t 8 reads.ec.fastq
# Compute the structure of the string graph
echo "performing low overlapping sga for $i"
sga overlap -m 20 -t 24 reads.ec.filter.pass.fa
echo "overlap done for $i"
# assembly with range of overlaps.. 
# Perform the contig assembly
for k in {21..101..2}
do
echo "starting assembly for $k"
sga assemble -m $k --min-branch-length 400 -o ${i}_overlap_$k reads.ec.filter.pass.asqg.gz
echo "assembly done for $i"
done

fi

cd ../../ #mv out of sga and $i
done
