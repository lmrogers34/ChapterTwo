#!/bin/bash
#Running REAPR on abyss dirs
# maps all l50 reads to be fair
for i in ec_pe_l50_f100
do
folder=$i #paired reads, only diff is _1 or _2
read1=/home/lrogers/work/deNovo-stats/Reads/Simulated/Paired/ec_pe_l50_f20_1.fq 
read2=/home/lrogers/work/deNovo-stats/Reads/Simulated/Paired/ec_pe_l50_f20_2.fq 

echo "folder is $folder"
echo "read1 is $read1"
echo "read2 is $read2"
printf "Starting time for $folder at : " 
date
cd $i #change into the read folder which holds all the assemblies

echo "Beginning Cisa reapr assessment on $folder"

#run contig truncator..  then check to see if it is empty
perl /cib/lisa/denovo/paired/scripts/contig.truncator.pl -i ${i}.denovo.merge.cisa.fa -l 500 -o ${i}.denovo.merge.cisa.fa.truncated.fa
if [ -s ${i}.denovo.merge.cisa.fa.truncated.fa ] # if the file exists and is not empty
then
	# if a sorted bam file exists the pipeline was run before and reapr can be performed
	if [ -s ${i}_same_map.sorted.bam ] # sorted bam file exists, go straight to reapr!! #bam check if
	then
		echo "sorted bam previously computed for $i"
		echo "ready for reapr"
		echo "beginning reapr pipeline for $i"
		start=`date +%s`
		reapr pipeline ${i}.denovo.merge.cisa.fa.facheck.fa ${i}_same_map.sorted.bam ${i}-same-reapr
		end=`date +%s`
		#pipleline
		mv *-reapr /cib/lisa/olc_sga/merge/merged_reapr
		runtime=$((end-start))
		echo "Reapr runtime for ${i} is $runtime"
	else # do whole pipeline, first run through
		echo "Beginning pipeline for ${i}"
		# step 1 facheck
		reapr facheck ${i}.denovo.merge.cisa.fa ${i}.denovo.merge.cisa.fa.facheck
		# step 1.1 check is facheck was succesful, if it was continuw with fachecked file, if not use original.
	
		if [ -s ${i}.denovo.merge.cisa.fa.facheck.fa ] # if file exists and is not 0, ie empty # facehck if 1/3
		then
			#2 index
			echo "beginning smalt indexing on ${i}"
			# smalt index -k hashlength -s steplength ref_name contigfile
			smalt index -k 13 -s 2 ${i}_same_index ${i}.denovo.merge.cisa.fa.facheck.fa
			#3 sample (optional)
			echo "beginning smalt sampling on ${i}"
			smalt sample -u 1000 -o ${i}_same_sample -n 24 ${i}_same_index $read1 $read2 
			#4. Map
			echo "beginning smalt mapping on ${i}"
			smalt map -r 0 -x -y 0.5 -g ${i}_same_sample -f samsoft -o ${i}_same_map.sam ${i}_same_index $read1 $read2 
			#5. sam to bam 
			echo "converting sam to bam for ${i}"
			samtools view -bS ${i}_same_map.sam > ${i}_same_map.bam
			#6. samtools bam sort
			echo "sorting bam file: ${i}"
			samtools sort ${i}_same_map.bam -o ${i}_same_map.sorted.bam
			#7 Reapr pipeline
			if [ -s ${i}_same_map.sorted.bam ] # bam was succesffuly sorted
			then
				echo "ready for reapr"
				echo "beginning reapr pipeline for ${i}"
				start=`date +%s`
				reapr pipeline ${i}.denovo.merge.cisa.fa.facheck.fa ${i}_same_map.sorted.bam ${i}-same-reapr
				end=`date +%s`
				mv *-reapr /cib/lisa/olc_sga/merge/merged_reapr
				runtime=$((end-start))
				echo "Reapr runtime for $i is $runtime"
			else
				echo " bam file not sorted.  Check for ${i}"
			fi # end of bam sort check
		elif [ -s ${i}.denovo.merge.cisa.fa ] # ie facheck didn't work # facehck if else 2/3
		then
			#2 index
			echo "beginning smalt indexing on ${i}"
			# smalt index -k hashlength -s steplength ref_name contigfile
			smalt index -k 13 -s 2 ${i}_same_index ${i}.denovo.merge.cisa.fa
			#3 sample (optional)
			echo "beginning smalt sampling on ${i}"
			smalt sample -u 1000 -o ${i}_same_sample -n 24 ${i}_same_index $read1 $read2 
			#4. Map
			echo "beginning smalt mapping on ${i}"
			smalt map -r 0 -x -y 0.5 -g ${i}_same_sample -f samsoft -o ${i}_same_map.sam ${i}_same_index $read1 $read2 
			#5. sam to bam 
			echo "converting sam to bam for ${i}"
			samtools view -bS ${i}_same_map.sam > ${i}_same_map.bam
			#6. samtools bam sort
			echo "sorting bam file: ${i}"
			samtools sort ${i}_same_map.bam -o ${i}_same_map.sorted.bam
			#7 Reapr pipeline
			if [ -s ${i}_same_map.sorted.bam ] # bam was succesffuly sorted
			then
				echo "ready for reapr"
				echo "beginning reapr pipeline for ${i}"
				start=`date +%s`
				reapr pipeline ${i}.denovo.merge.cisa.fa ${i}_same_map.sorted.bam ${i}-same-reapr
				end=`date +%s`
				mv *-reapr /cib/lisa/olc_sga/merge/merged_reapr
				runtime=$((end-start))
				echo "Reapr runtime for $i is $runtime"
			else
				echo " bam file not sorted.  Check for ${i}"
			fi # end of bam sort check
		else # facehck if else last statement 3/3
			echo "file ${i} is empty therefore there are no contigs to perform REAPR on"
		fi # end of facheck if loop 
	fi # end of sorted bam check if loop

else
	echo "${i} doesn't contain contigs >500bp"
fi # for truncation check

echo "Finished Cisa reapr assessment on $folder"
cd ../ #move out of the read dir
done
