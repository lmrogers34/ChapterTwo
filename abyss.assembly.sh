#!/bin/bash
for i in /home/lrogers/work/deNovo-stats/Reads/Simulated/Paired/new_reads/*1.fq
do
read1=$i #paired reads, only diff is _1 or _2
read2=${read1/_1/_2} #names the second read
first=${read1/_1.fq/} #removes the trailing _1.fq
folder=${first/\/home\/lrogers\/work\/deNovo-stats\/Reads\/Simulated\/Paired\/new_reads\//} #removes the start of the path so can have a folder with the read name. 


if [ -d $folder ] # $folder exists
then
cd $folder #changes into a read specific folder
else
mkdir $folder
cd $folder #changes into a read specific folder
fi

if [ -d abyss ] # $folder exists
then
cd abyss
else
mkdir abyss
cd abyss #cd into abyss dir
fi

#Abyss for loop
for k in {21..99..2}
do
if [ -d $k ]
then
cd $k
else
mkdir $k
cd $k
fi

if [[ $folder == *\:* ]]
then
echo "problem with : in $folder.  Replacing name..."
rename=${folder/\:/_}
echo "folder renamed to $rename"
folder=$rename;
fi


if [ -f $folder-$k-contigs.fa ]
then
echo "assembly for $folder-$k exists"
else
abyss-pe k=$k n=10 in="$read1 $read2" name=$folder-$k
fi

cd ../
echo "k-mer $k done"
done    
cd ../ #leave abyss dir
echo "abyss done"
cd ../
done

