#!/bin/bash
#Running REAPR on abyss dirs
# modified on 10-02-15
for i in ec_pe_l150_f40
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
cd abyss
echo "Beginning Abyss reapr assessment on $folder"


for j in {21..99..2}
do
if [ -d "$j" ]
then
	#run contig truncator..  then check to see if it is empty
	perl /home/lrogers/work/deNovo-stats/assembly/paired/contig.truncator.pl -i $j/${folder}-${j}-contigs.fa -l 500 -o $j/${folder}-${j}-contigs.fa.truncated.fa
	if [ -s $j/${folder}-${j}-contigs.fa.truncated.fa ] # if the file exists and is not empty
	then
		#as run previously check for the sorted bam file.  If it exists, then can go straight to reapr
		if [ -f ${i}_${j}_same_map.sorted.bam ] # sorted bam file exists, go straight to reapr!! #bam check if
		then
			echo "sorted bam previously computed for $i-$j"
			echo "ready for reapr"
			echo "beginning reapr pipeline for $i-$j"
			start=`date +%s`
			reapr pipeline $j/${folder}-${j}-contigs.fa.facheck.fa ${i}_${j}_same_map.sorted.bam ${i}_k${j}-abyss-same-reapr
			end=`date +%s`
			#pipleline
			mv *-reapr /cib/lisa/new_l100_paper1/reapr-same-500bp+
			runtime=$((end-start))
			echo "Reapr runtime for ${i}_${j} is $runtime"
		else # do whole pipeline
			# step 1 facheck
			reapr facheck $j/${folder}-${j}-contigs.fa $j/${folder}-${j}-contigs.fa.facheck
			# step 1.1 check is facheck was succesful, if it was continuw with fachecked file, if not use original.
	
			if [ -s $j/${folder}-${j}-contigs.fa.facheck.fa ] # if file exists and is not 0, ie empty # facehck if 1/3
			then
				#2 index
				echo "beginning smalt indexing on $i-$j"
				# smalt index -k hashlength -s steplength ref_name contigfile
				smalt index -k 13 -s 2 ${i}_${j}_same_index $j/${folder}-${j}-contigs.fa.facheck.fa 
				#3 sample (optional)
				echo "beginning smalt sampling on $i-$j"
				smalt sample -u 1000 -o ${i}_${j}_same_sample -n 24 ${i}_${j}_same_index $read1 $read2 
				#4. Map
				echo "beginning smalt mapping on $i-$j"
				smalt map -r 0 -x -y 0.5 -g ${i}_${j}_same_sample -f samsoft -o ${i}_${j}_same_map.sam ${i}_${j}_same_index $read1 $read2 
				#5. sam to bam 
				echo "converting sam to bam for ${i}_${j}_same_map.sam"
				samtools view -bS ${i}_${j}_same_map.sam > ${i}_${j}_same_map.bam
				#6. samtools bam sort
				echo "sorting bam file: ${i}_${j}_same_map.bam"
				samtools sort ${i}_${j}_same_map.bam ${i}_${j}_same_map.sorted
				#7 Reapr pipeline
				if [ -f ${i}_${j}_same_map.sorted.bam ] 
				then
					echo "ready for reapr"
					echo "beginning reapr pipeline for $j"
					start=`date +%s`
					reapr pipeline $j/${folder}-${j}-contigs.fa.facheck.fa ${i}_${j}_same_map.sorted.bam ${i}_k${j}-abyss-same-reapr
					end=`date +%s`
					mv *-reapr /cib/lisa/new_l100_paper1/reapr-same-500bp+
					runtime=$((end-start))
					echo "Reapr runtime for ${i}_${j} is $runtime"
				else
				echo " bam file not sorted.  Check for $j"
				fi
			elif [ -s $j/${folder}-${j}-contigs.fa ] # ie facheck didn't work # facehck if else 2/3
			then
				#2 index
				echo "beginning smalt indexing on $i-$j"
				# smalt index -k hashlength -s steplength ref_name contigfile
				smalt index -k 13 -s 2 ${i}_${j}_same_index $j/${folder}-${j}-contigs.fa 
				#3 sample (optional)
				echo "beginning smalt sampling on $i-$j"
				smalt sample -u 1000 -o ${i}_${j}_same_sample -n 24 ${i}_${j}_same_index $read1 $read2 
				#4. Map
				echo "beginning smalt mapping on $i-$j"
				smalt map -r 0 -x -y 0.5 -g ${i}_${j}_same_sample -f samsoft -o ${i}_${j}_same_map.sam ${i}_${j}_same_index $read1 $read2 
				#5. sam to bam 
				echo "converting sam to bam for ${i}_${j}_same_map.sam"
				samtools view -bS ${i}_${j}_same_map.sam > ${i}_${j}_same_map.bam
				#6. samtools bam sort
				echo "sorting bam file: ${i}_${j}_same_map.bam"
				samtools sort ${i}_${j}_same_map.bam ${i}_${j}_same_map.sorted
				#7 Reapr pipeline
				if [ -f ${i}_${j}_same_map.sorted.bam ] 
				then
					echo "ready for reapr"
					echo "beginning reapr pipeline for $j"
					start=`date +%s`
					reapr pipeline $j/${folder}-${j}-contigs.fa ${i}_${j}_same_map.sorted.bam ${i}_k${j}-abyss-same-reapr
					end=`date +%s`
					mv *-reapr /cib/lisa/new_l100_paper1/reapr-same-500bp+
					runtime=$((end-start))
					echo "Reapr runtime for ${i}_${j} is $runtime"
				else
				echo " bam file not sorted.  Check for ${i}_${j}"
				fi
			else # facehck if else last statement 3/3
				echo "file ${i}_${j} is empty therefore there are no contigs to perform REAPR on"
			fi
		echo "done for ${i}_${j}"
	fi # dir to close bam check if
else
	echo "$folder doesn't contain contigs >500bp"
fi # if to check if truncation file exists
fi # dir check if close
printf "End time for ${i}_${j} at : " 
date
done
cd ../ #move out of abyss dir
#End of abyss
cd ../ #move out of the read dir
done
