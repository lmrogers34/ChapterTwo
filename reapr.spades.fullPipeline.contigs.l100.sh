#!/bin/bash
#Running REAPR on abyss dirs
# maps all l50 reads to be fair
for i in ec_pe_l1*0
do
folder=$i #paired reads, only diff is _1 or _2
read1=/cib/lisa/denovo/reads/ec_pe_l50_f20_1.fq 
read2=/cib/lisa/denovo/reads/ec_pe_l50_f20_2.fq 

echo "folder is $folder"
echo "read1 is $read1"
echo "read2 is $read2"
printf "Starting time for $folder at : " 
date
cd $i #change into the read folder which holds all the assemblies
#Start of Abyss
cd spades
echo "Beginning spades reapr assessment on $folder"
for g in spades*
do
#run contig truncator..  then check to see if it is empty
perl /home/lrogers/work/deNovo-stats/assembly/paired/contig.truncator.pl -i $g/contigs.fasta -l 500 -o $g/contigs.fasta.truncated.fa
if [ -s $g/contigs.fasta.truncated.fa ] # if the file exists and is not empty
then
	# if a sorted bam file exists the pipeline was run before and reapr can be performed
	if [ -s ${i}_${g}_same_map.sorted.bam ] # sorted bam file exists, go straight to reapr!! #bam check if
	then
		echo "sorted bam previously computed for $g"
		echo "ready for reapr"
		echo "beginning reapr pipeline for $g"
		start=`date +%s`
		reapr pipeline $g/contigs.fasta.facheck.fa ${i}_${g}_same_map.sorted.bam ${i}-${g}-same-reapr
		end=`date +%s`
		#pipleline
		mv *-reapr /cib/lisa/new_l100_paper1/reapr-same-500bp+
		runtime=$((end-start))
		echo "Reapr runtime for ${i}_${g} is $runtime"
	else # do whole pipeline, first run through
		echo "Beginning pipeline for ${i}_${g}"
		# step 1 facheck
		reapr facheck $g/contigs.fasta $g/contigs.fasta.facheck
		# step 1.1 check is facheck was succesful, if it was continuw with fachecked file, if not use original.
	
		if [ -s $g/contigs.fasta.facheck.fa ] # if file exists and is not 0, ie empty # facehck if 1/3
		then
			#2 index
			echo "beginning smalt indexing on ${i}_${g}"
			# smalt index -k hashlength -s steplength ref_name contigfile
			smalt index -k 13 -s 2 ${i}_${g}_same_index $g/contigs.fasta.facheck.fa
			#3 sample (optional)
			echo "beginning smalt sampling on ${i}_${g}"
			smalt sample -u 1000 -o ${i}_${g}_same_sample -n 24 ${i}_${g}_same_index $read1 $read2 
			#4. Map
			echo "beginning smalt mapping on ${i}-${g}"
			smalt map -r 0 -x -y 0.5 -g ${i}_${g}_same_sample -f samsoft -o ${i}_${g}_same_map.sam ${i}_${g}_same_index $read1 $read2 
			#5. sam to bam 
			echo "converting sam to bam for ${i}_${g}"
			samtools view -bS ${i}_${g}_same_map.sam > ${i}_${g}_same_map.bam
			#6. samtools bam sort
			echo "sorting bam file: ${i}_${g}"
			samtools sort ${i}_${g}_same_map.bam ${i}_${g}_same_map.sorted
			#7 Reapr pipeline
			if [ -s ${i}_${g}_same_map.sorted.bam ] # bam was succesffuly sorted
			then
				echo "ready for reapr"
				echo "beginning reapr pipeline for ${i}_${g}"
				start=`date +%s`
				reapr pipeline $g/contigs.fasta.facheck.fa ${i}_${g}_same_map.sorted.bam ${i}-${g}-same-reapr
				end=`date +%s`
				mv *-reapr /cib/lisa/new_l100_paper1/reapr-same-500bp+
				runtime=$((end-start))
				echo "Reapr runtime for $g is $runtime"
			else
				echo " bam file not sorted.  Check for ${i}_${g}"
			fi # end of bam sort check
		elif [ -s $g/contigs.fasta ] # ie facheck didn't work # facehck if else 2/3
		then
			#2 index
			echo "beginning smalt indexing on ${i}_${g}"
			# smalt index -k hashlength -s steplength ref_name contigfile
			smalt index -k 13 -s 2 ${i}_${g}_same_index $g/contigs.fasta
			#3 sample (optional)
			echo "beginning smalt sampling on ${i}_${g}"
			smalt sample -u 1000 -o ${i}_${g}_same_sample -n 24 ${i}_${g}_same_index $read1 $read2 
			#4. Map
			echo "beginning smalt mapping on ${i}-${g}"
			smalt map -r 0 -x -y 0.5 -g ${i}_${g}_same_sample -f samsoft -o ${i}_${g}_same_map.sam ${i}_${g}_same_index $read1 $read2 
			#5. sam to bam 
			echo "converting sam to bam for ${i}_${g}"
			samtools view -bS ${i}_${g}_same_map.sam > ${i}_${g}_same_map.bam
			#6. samtools bam sort
			echo "sorting bam file: ${i}_${g}"
			samtools sort ${i}_${g}_same_map.bam ${i}_${g}_same_map.sorted
			#7 Reapr pipeline
			if [ -s ${i}_${g}_same_map.sorted.bam ] # bam was succesffuly sorted
			then
				echo "ready for reapr"
				echo "beginning reapr pipeline for ${i}_${g}"
				start=`date +%s`
				reapr pipeline $g/contigs.fasta ${i}_${g}_same_map.sorted.bam ${i}-${g}-same-reapr
				end=`date +%s`
				mv *-reapr /cib/lisa/new_l100_paper1/reapr-same-500bp+
				runtime=$((end-start))
				echo "Reapr runtime for $g is $runtime"
			else
				echo " bam file not sorted.  Check for ${i}_${g}"
			fi # end of bam sort check
		else # facehck if else last statement 3/3
			echo "file ${i}-${g} is empty therefore there are no contigs to perform REAPR on"
		fi # end of facheck if loop 
	fi # end of sorted bam check if loop

else
	echo "${i}-${g} doesn't contain contigs >500bp"
fi # for truncation check


done
cd ../ #move out of spades dir
#End of spades
echo "Finished Spades reapr assessment on $folder"
cd ../ #move out of the read dir
done
