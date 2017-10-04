#!/bin/bash
for i in /home/lrogers/work/deNovo-stats/Reads/Simulated/Paired/ec_pe_l50*1.fq
do
read1=$i #paired reads, only diff is _1 or _2
read2=${read1/_1/_2} #names the second read
first=${read1/_1.fq/} #removes the trailing _1.fq
folder=${first/\/home\/lrogers\/work\/deNovo-stats\/Reads\/Simulated\/Paired\//} #removes the start of the path so can have a folder with the read name. 

if [ -d $folder ] # $folder exists
then
cd $folder #changes into a read specific folder
else
mkdir $folder
cd $folder #changes into a read specific folder
fi

mkdir sga

#Soap Denovo 2
cd sga #changes into soap dir
#create soap.conf file
touch ${folder}_sga.sh

echo "#! /bin/bash -x" >>${folder}_sga.sh
## parameters optimised for l150
echo "IN1=$read1" >>${folder}_sga.sh
echo "IN2=$read2" >>${folder}_sga.sh

echo "#" >>${folder}_sga.sh
echo "# Parameters" >>${folder}_sga.sh
echo "#" >>${folder}_sga.sh
echo "# Program paths" >>${folder}_sga.sh

echo "SGA_BIN=sga" >>${folder}_sga.sh
echo "BWA_BIN=bwa" >>${folder}_sga.sh
echo "SAMTOOLS_BIN=samtools" >>${folder}_sga.sh
echo "BAM2DE_BIN=sga-bam2de.pl" >>${folder}_sga.sh
echo "ASTAT_BIN=sga-astat.py" >>${folder}_sga.sh
echo "DISTANCE_EST=DistanceEst" >>${folder}_sga.sh

echo "# The number of threads to use" >>${folder}_sga.sh
echo "CPU=8" >>${folder}_sga.sh

echo "# Correction k-mer " >>${folder}_sga.sh
echo "CORRECTION_K=41" >>${folder}_sga.sh

echo "# The minimum overlap to use when computing the graph." >>${folder}_sga.sh
echo "# The final assembly can be performed with this overlap or greater" >>${folder}_sga.sh
echo "MIN_OVERLAP=75" >>${folder}_sga.sh

echo "# The overlap value to use for the final assembly" >>${folder}_sga.sh
echo "ASSEMBLE_OVERLAP=111" >>${folder}_sga.sh

echo "# Branch trim length" >>${folder}_sga.sh
echo "TRIM_LENGTH=400" >>${folder}_sga.sh

echo "# The minimum length of contigs to include in a scaffold" >>${folder}_sga.sh
echo "MIN_CONTIG_LENGTH=200" >>${folder}_sga.sh

echo "# The minimum number of reads pairs required to link two contigs" >>${folder}_sga.sh
echo "MIN_PAIRS=10" >>${folder}_sga.sh

echo "#" >>${folder}_sga.sh
echo "# Dependency checks" >>${folder}_sga.sh
echo "#" >>${folder}_sga.sh


#echo "# Check the required programs are installed and executable" >>${folder}_sga.sh
#echo "prog_list=\"$SGA_BIN $BWA_BIN $SAMTOOLS_BIN $BAM2DE_BIN $DISTANCE_EST $ASTAT_BIN\"" >>${folder}_sga.sh
#echo "for prog in $prog_list; do" >>${folder}_sga.sh
#echo "    hash $prog 2>/dev/null || { echo \"Error $prog not found. Please place $prog on your PATH or update the *_BIN variables in this script\"; exit 1; }" >>${folder}_sga.sh
#echo "done " >>${folder}_sga.sh

#echo "# Check the files are found" >>${folder}_sga.sh
#echo "file_list=\"$IN1 $IN2\"" >>${folder}_sga.sh
#echo "for input in $file_list; do" >>${folder}_sga.sh
#echo "    if [ ! -f $input ]; then" >>${folder}_sga.sh
#echo "        echo \"Error input file $input not found\"; exit 1;" >>${folder}_sga.sh
#echo "    fi" >>${folder}_sga.sh
#echo "done" >>${folder}_sga.sh

echo "#" >>${folder}_sga.sh
echo "# Preprocessing" >>${folder}_sga.sh
echo "#" >>${folder}_sga.sh

echo "# Preprocess the data to remove ambiguous basecalls" >>${folder}_sga.sh
echo "\$SGA_BIN preprocess --pe-mode 1 -o reads.pp.fastq \$IN1 \$IN2" >>${folder}_sga.sh

echo "#" >>${folder}_sga.sh
echo "# Error Correction" >>${folder}_sga.sh
echo "#" >>${folder}_sga.sh

echo "# Build the index that will be used for error correction" >>${folder}_sga.sh
echo "# As the error corrector does not require the reverse BWT, suppress" >>${folder}_sga.sh
echo "# construction of the reversed index" >>${folder}_sga.sh
echo "\$SGA_BIN index -a ropebwt -t \$CPU --no-reverse reads.pp.fastq" >>${folder}_sga.sh

echo "# Perform k-mer based error correction." >>${folder}_sga.sh
echo "# The k-mer cutoff parameter is learned automatically." >>${folder}_sga.sh
echo "\$SGA_BIN correct -k \$CORRECTION_K --learn -t \$CPU -o reads.ec.fastq reads.pp.fastq" >>${folder}_sga.sh

echo "#" >>${folder}_sga.sh
echo "# Primary (contig) assembly" >>${folder}_sga.sh
echo "#" >>${folder}_sga.sh

echo "# Index the corrected data." >>${folder}_sga.sh
echo "\$SGA_BIN index -a ropebwt -t \$CPU reads.ec.fastq" >>${folder}_sga.sh

echo "# Remove exact-match duplicates and reads with low-frequency k-mers" >>${folder}_sga.sh
echo "\$SGA_BIN filter -x 2 -t \$CPU reads.ec.fastq" >>${folder}_sga.sh

echo "# Compute the structure of the string graph" >>${folder}_sga.sh
echo "\$SGA_BIN overlap -m \$MIN_OVERLAP -t \$CPU reads.ec.filter.pass.fa" >>${folder}_sga.sh

echo "# Perform the contig assembly" >>${folder}_sga.sh
echo "\$SGA_BIN assemble -m \$ASSEMBLE_OVERLAP --min-branch-length \$TRIM_LENGTH -o primary reads.ec.filter.pass.asqg.gz" >>${folder}_sga.sh

echo "#" >>${folder}_sga.sh
echo "# Scaffolding" >>${folder}_sga.sh
echo "#" >>${folder}_sga.sh

echo "PRIMARY_CONTIGS=primary-contigs.fa" >>${folder}_sga.sh
echo "PRIMARY_GRAPH=primary-graph.asqg.gz" >>${folder}_sga.sh

echo "# Align the reads to the contigs" >>${folder}_sga.sh
echo "\$BWA_BIN index \$PRIMARY_CONTIGS" >>${folder}_sga.sh
echo "\$BWA_BIN aln -t \$CPU \$PRIMARY_CONTIGS \$IN1 > \$IN1.sai" >>${folder}_sga.sh
echo "\$BWA_BIN aln -t \$CPU \$PRIMARY_CONTIGS \$IN2 > \$IN2.sai" >>${folder}_sga.sh
echo "\$BWA_BIN sampe \$PRIMARY_CONTIGS \$IN1.sai \$IN2.sai \$IN1 \$IN2 | $SAMTOOLS_BIN view -Sb - > libPE.bam" >>${folder}_sga.sh

echo "# Convert the BAM file into a set of contig-contig distance estimates" >>${folder}_sga.sh
echo "\$BAM2DE_BIN -n \$MIN_PAIRS -m \$MIN_CONTIG_LENGTH --prefix libPE libPE.bam" >>${folder}_sga.sh

echo "# Compute copy number estimates of the contigs" >>${folder}_sga.sh
echo "\$ASTAT_BIN -m \$MIN_CONTIG_LENGTH libPE.bam > libPE.astat" >>${folder}_sga.sh

echo "# Build the scaffolds" >>${folder}_sga.sh
echo "\$SGA_BIN scaffold -m \$MIN_CONTIG_LENGTH -a libPE.astat -o scaffolds.scaf --pe libPE.de $PRIMARY_CONTIGS" >>${folder}_sga.sh

echo "# Convert the scaffolds to FASTA format" >>${folder}_sga.sh
echo "\$SGA_BIN scaffold2fasta --use-overlap --write-unplaced -m $MIN_CONTIG_LENGTH -a $PRIMARY_GRAPH -o sga-scaffolds.fa scaffolds.scaf" >>${folder}_sga.sh


#end of .conf file

echo "running sga script for $folder"
chmod 777 ${folder}_sga.sh
./${folder}_sga.sh


cd ../ #leaves sga dir
echo "sga assembler done"
cd ../ #changes back into original assesment dir to rerun read analysis
echo "End of sga assembly for $folder"
done
