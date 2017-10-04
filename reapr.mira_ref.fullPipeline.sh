#!/bin/bash
#Running REAPR
for i in ec_pe_l1*0
do
folder=$i #paired reads, only diff is _1 or _2
read1=/cib/lisa/denovo/reads/ec_pe_l50_f20_1.fq 
read2=/cib/lisa/denovo/reads/ec_pe_l50_f20_2.fq 

echo "folder is $folder"
echo "readpath is $readpath"
echo "read1 is $read1"
echo "read2 is $read2"
cd $i #change into the read folder which holds all the assemblies
#Start of mira_ref
echo "Beginning mira_ref reapr assessment on $folder"
cd mira_ref
perl /home/lrogers/work/deNovo-stats/assembly/paired/contig.truncator.pl -i ${folder}_assembly/${folder}_d_results/${folder}_ref.unpadded.fasta -l 500 -o ${folder}_assembly/${folder}_d_results/${folder}_ref.unpadded.fasta.truncated.fa
if [ -s ${folder}_assembly/${folder}_d_results/${folder}_ref.unpadded.fasta.truncated.fa ] # if the file exists and is not empty
then
	# if a sorted bam file exists the pipeline was run before and reapr can be performed
	if [ -f ${folder}_same_map.sorted.bam ] # sorted bam file exists, go straight to reapr!! #bam check if
	then
		echo "sorted bam previously computed for $k"
		echo "ready for reapr"
		echo "beginning reapr pipeline for $k"
		start=`date +%s`
		reapr pipeline ${folder}_assembly/${folder}_d_results/${folder}_ref.unpadded.fasta.facheck.fa ${folder}_same_map.sorted.bam $folder-mira_ref-same-reapr
		end=`date +%s`
		#pipleline
		mv *-reapr /cib/lisa/new_l100_paper1/reapr-mira_ref
		runtime=$((end-start))
		echo "Reapr runtime for $folder is $runtime"
	else # do whole pipeline, first run through
		echo "Beginning pipeline for $folder"
		# step 1 facheck
		reapr facheck ${folder}_assembly/${folder}_d_results/${folder}_ref.unpadded.fasta ${folder}_assembly/${folder}_d_results/${folder}_ref.unpadded.fasta.facheck.fa
		# step 1.1 check is facheck was succesful, if it was continuw with fachecked file, if not use original.
	
		if [ -s ${folder}_assembly/${folder}_d_results/${folder}_ref.unpadded.fasta.facheck.fa ] # if file exists and is not 0, ie empty # facehck if 1/3
		then
			#2 index
			echo "beginning smalt indexing on $folder"
			# smalt index -k hashlength -s steplength ref_name contigfile
			smalt index -k 13 -s 2 ${folder}_same_index ${folder}_assembly/${folder}_d_results/${folder}_ref.unpadded.fasta.facheck.fa 
			#3 sample (optional)
			echo "beginning smalt sampling on $folder"
			smalt sample -u 1000 -o ${folder}_same_sample -n 24 ${folder}_same_index $read1 $read2 
			#4. Map
			echo "beginning smalt mapping on $folder"
			smalt map -r 0 -x -y 0.5 -g ${folder}_same_sample -f samsoft -o ${folder}_same_map.sam ${folder}_same_index $read1 $read2 
			#5. sam to bam 
			echo "converting sam to bam for ${folder}_same_map.sam"
			samtools view -bS ${folder}_same_map.sam > ${folder}_same_map.bam
			#6. samtools bam sort
			echo "sorting bam file: ${folder}_same_map.bam"
			samtools sort ${folder}_same_map.bam ${folder}_same_map.sorted
			#7 Reapr pipeline
			if [ -f ${folder}_same_map.sorted.bam ] # bam was succesffuly sorted
			then
				echo "ready for reapr"
				echo "beginning reapr pipeline for $folder"
				start=`date +%s`
				reapr pipeline ${folder}_assembly/${folder}_d_results/${folder}_ref.unpadded.fasta.facheck.fa ${folder}_same_map.sorted.bam $folder-mira_ref-same-reapr
				end=`date +%s`
				mv *-reapr /cib/lisa/new_l100_paper1/reapr-mira_ref
				runtime=$((end-start))
				echo "Reapr runtime for $k is $runtime"
			else
				echo " bam file not sorted.  Check for $folder"
			fi # end of bam sort check
		elif [ -s ${folder}_assembly/${folder}_d_results/${folder}_ref.unpadded.fasta ] # ie facheck didn't work # facehck if else 2/3
		then
			#2 index
			echo "beginning smalt indexing on $folder"
			# smalt index -k hashlength -s steplength ref_name contigfile
			smalt index -k 13 -s 2 ${folder}_same_index ${folder}_assembly/${folder}_d_results/${folder}_ref.unpadded.fasta
			#3 sample (optional)
			echo "beginning smalt sampling on $folder"
			smalt sample -u 1000 -o ${folder}_same_sample -n 24 ${folder}_same_index $read1 $read2 
			#4. Map
			echo "beginning smalt mapping on $folder"
			smalt map -r 0 -x -y 0.5 -g ${folder}_same_sample -f samsoft -o ${folder}_same_map.sam ${folder}_same_index $read1 $read2 
			#5. sam to bam 
			echo "converting sam to bam for ${folder}_same_map.sam"
			samtools view -bS ${folder}_same_map.sam > ${folder}_same_map.bam
			#6. samtools bam sort
			echo "sorting bam file: ${folder}_same_map.bam"
			samtools sort ${folder}_same_map.bam ${folder}_same_map.sorted
			#7 Reapr pipeline
			if [ -f ${folder}_same_map.sorted.bam ] # bam was succesffuly sorted
			then
				echo "ready for reapr"
				echo "beginning reapr pipeline for $folder"
				start=`date +%s`
				reapr pipeline ${folder}_assembly/${folder}_d_results/${folder}_ref.unpadded.fasta ${folder}_same_map.sorted.bam $folder-mira_ref-same-reapr
				end=`date +%s`
				mv *-reapr /cib/lisa/new_l100_paper1/reapr-mira_ref
				runtime=$((end-start))
				echo "Reapr runtime for $k is $runtime"
			else
				echo " bam file not sorted.  Check for $folder"
			fi # end of bam sort check (inner loop)
		else # facehck if else last statement 3/3
			echo "file $folder is empty therefore there are no contigs to perform REAPR on"
		fi # end of facheck if loop 
	fi # end of sorted bam check if loop
else
	echo "$folder doesn't contain contigs >500bp"
fi # for truncation check
cd ../ #move out of mira_ref dir
#End of mira_ref 
echo "Finished mira_ref reapr assessment on $folder"
cd ../ #move out of the read dir
done
