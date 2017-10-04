#!/bin/bash
#Running REAPR
# modified on 02-02-15
for i in ec_pe_l150_f80
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
#Start of soapdenovo2
echo "Beginning Soapdenovo2 reapr assessment on $folder"
cd soapdenovo2
for m in *-k?? # the 2 numbers afterwards
do
if [ -d "$m" ] # dir check if
then
	#run contig truncator..  then check to see if it is empty
	perl /home/lrogers/work/deNovo-stats/assembly/paired/contig.truncator.pl -i $m/$m.contig -l 500 -o $m/$m.contig.truncated.fa
	if [ -s $m/$m.contig.truncated.fa ] # if the file exists and is not empty
	then
		#as run previously check for the sorted bam file.  If it exists, then can go straight to reapr
		if [ -f ${m}_same_map.sorted.bam ] # sorted bam file exists, go straight to reapr!! #bam check if
		then
			echo "sorted bam previously computed for $m"
			echo "ready for reapr"
			echo "beginning reapr pipeline for $m"
			start=`date +%s`
			reapr pipeline $m/$m.contig.facheck.fa ${m}_same_map.sorted.bam $m-soap-same-reapr
			end=`date +%s`
			#pipleline
			mv *-reapr /cib/lisa/new_l100_paper1/reapr-same-500bp+
		else # do whole pipeline
			# step 1 facheck
			reapr facheck $m/$m.contig $m/$m.contig.facheck
			# step 1.1 check is facheck was succesful, if it was continuw with fachecked file, if not use original.
	
			if [ -s $m/$m.contig.facheck.fa ] # if file exists and is not 0, ie empty # facehck if 1/3
			then
				#2 index
				echo "beginning smalt indexing on $m"
				# smalt index -k hashlength -s steplength ref_name contigfile
				smalt index -k 13 -s 2 ${m}_same_index $m/$m.contig.facheck.fa 
				#3 sample (optional)
				echo "beginning smalt sampling on $m"
				smalt sample -u 1000 -o ${m}_same_sample -n 24 ${m}_same_index $read1 $read2 
				#4. Map
				echo "beginning smalt mapping on $m"
				smalt map -r 0 -x -y 0.5 -g ${m}_same_sample -f samsoft -o ${m}_same_map.sam ${m}_same_index $read1 $read2 
				#5. sam to bam 
				echo "converting sam to bam for ${m}_same_map.sam"
				samtools view -bS ${m}_same_map.sam > ${m}_same_map.bam
				#6. samtools bam sort
				echo "sorting bam file: ${m}_same_map.bam"
				samtools sort ${m}_same_map.bam ${m}_same_map.sorted
				#7 Reapr pipeline
				if [ -f ${m}_same_map.sorted.bam ] # was previously testing for the wrong name.  Wihtout the bam
				then
					echo "ready for reapr"
					echo "beginning reapr pipeline for $m"
					start=`date +%s`
					reapr pipeline $m/$m.contig.facheck.fa ${m}_same_map.sorted.bam $m-soap-same-reapr
					end=`date +%s`
					mv *-reapr /cib/lisa/new_l100_paper1/reapr-same-500bp+
				else
				echo " bam file not sorted.  Check for $m"
				fi
			elif [ -s $m/$m.contig ] # ie facheck didn't work # facehck if else 2/3
			then
				#2 index
				# smalt index -k hashlength -s steplength ref_name contigfile
				echo "beginning smalt indexing"
				smalt index -k 13 -s 2 ${m}_same_index $m/$m.contig 
				#3 sample (optional)
				echo "beginning smalt sampling"
				smalt sample -u 1000 -o ${m}_same_sample -n 24 ${m}_same_index $read1 $read2 
				#4. Map
				echo "beginning smalt mapping"
				smalt map -r 0 -x -y 0.5 -g ${m}_same_sample -f samsoft -o ${m}_same_map.sam ${m}_same_index $read1 $read2 
				#5. sam to bam 
				echo "converting sam to bam"
				samtools view -bS ${m}_same_map.sam > ${m}_same_map.bam
				#6. samtools bam sort
				echo "sorting bam file"
				samtools sort ${m}_same_map.bam ${m}_same_map.sorted
				if [ -f ${m}_same_map.sorted.bam ] # was previously testing for the wrong name.  Wihtout the bam
					then
					#7 Reapr pipeline
					echo "beginning reapr pipeline"
					start=`date +%s`
					reapr pipeline $m/$m.contig ${m}_same_map.sorted.bam $m-soap-same-reapr
					end=`date +%s`					
					#pipleline
					mv *-reapr /cib/lisa/new_l100_paper1/reapr-same-500bp+
				else
					echo " bam file not sorted.  Check for $m"
				fi
			else # facehck if else last statement 3/3
				echo "file $m is empty therefore there are no contigs to perform REAPR on"
			fi
		echo "done for $m"
	fi # dir to close bam check if
else
	echo "$folder doesn't contain contigs >500bp"
fi # if to check if truncation file exists
fi # dir check if close
printf "End time for $folder at : " 
date
done
cd ../ #move out of soapdenovo2 dir
#End of soapdenovo2
cd ../ #move out of the read dir
done
