#!/bin/bash
# script for merging contigs using cisa
for i in ec_pe_l101*0 # all folders within top 5
do

cd $i
folder=${i}
for j in *.fasta
do
if [[ $j == *_abyss.fasta ]] # tests if the fasta files matches the text abyss, and if it does then you merge.
then
abyss=${j}
elif [[ $j == *_mira.fasta ]]
then
mira=${j}
elif [[ $j == *_spades.fasta ]]
then
spades=${j}
elif [[ $j == *_velvet.fasta ]]
then
velvet=${j}
elif [[ $j == *_soap.fasta ]]
then
soap=${j}
elif [[ $j == *_mira_ref.fasta ]]
then
mira_ref=${j}
elif [[ $j == *_velvet_ref.fasta ]]
then
velvet_ref=${j}
elif [[ $j == *_sga.fasta ]]
then
sga=${j}
else
echo "$j has no match"
fi
done


#echo "folder is $folder"
#echo "abyss assembly is $abyss"
#echo "mira assembly is $mira"
#echo "spades assembly is $spades"
#echo "velvet assembly is $velvet"
#echo "soap assembly is $soap"
#echo "velvet_ref assembly is $velvet_ref"
#echo "mira_ref assembly is $mira_ref"
#echo "sga assembly is $sga"

	if [ -f $folder.MERGE.denovo.config ] # if the cisa merge already happened then we don't recreate the script
		then
		echo "$folder.MERGE.denovo.config exists"
	else # if it doesn't then we create the config files we require.
		echo "Creating Merge file for $folder"
		touch $folder.MERGE.denovo.config # touch - creates a file
		echo "count=6" >>$folder.MERGE.denovo.config # tells cisa how many files we'll be merging
		echo "data=$spades,title=spades" >>$folder.MERGE.denovo.config
		echo "data=$velvet,title=velvet" >>$folder.MERGE.denovo.config
		echo "data=$sga,title=sga" >>$folder.MERGE.denovo.config
		echo "data=$abyss,title=abyss" >>$folder.MERGE.denovo.config
		echo "data=$mira,title=mira" >>$folder.MERGE.denovo.config
		echo "data=$soap,title=soap" >>$folder.MERGE.denovo.config
		echo "Master_file=$folder.denovo.merge" >>$folder.MERGE.denovo.config
		echo "min_length=100" >>$folder.MERGE.denovo.config
		echo "Gap=11" >>$folder.MERGE.denovo.config
		echo "Merge file created for $folder"
	fi # end of config if check 



if [ -f $folder.CISA.denovo.config ]
then
echo "$folder.CISA.denovo.config exists"
else
echo "Creating CISA file for $folder"
touch $folder.CISA.denovo.config
echo "genome=5500000" >>$folder.CISA.denovo.config # 5500000 is the estimate of our genome size
echo "infile=$folder.denovo.merge" >>$folder.CISA.denovo.config
echo "outfile=$folder.denovo.merge.cisa.fa" >>$folder.CISA.denovo.config
echo "R2_Gap=0.95" >>$folder.CISA.denovo.config
echo "nucmer=/home/lrogers/tools/MUMmer3.23/nucmer" >>$folder.CISA.denovo.config # points where the tools are installed. 
echo "CISA=/home/lrogers/tools/CISA1.3/" >>$folder.CISA.denovo.config
echo "makeblastdb=/usr/bin/makeblastdb" >>$folder.CISA.denovo.config
echo "blastn=/usr/bin/blastn" >>$folder.CISA.denovo.config
echo "CISA file created for $folder"
fi




if [ -f $folder.denovo.merge.cisa.fa ]
then
echo "$folder already merged"
elif [ -f ${folder}.denovo.merge ]
then
echo "merge file exists.  Problem with EOF"
echo "beginning cisa for $folder"
CISA.py $folder.CISA.denovo.config <<-EOF
y
EOF
else
echo "beginning cisa merge for $folder"
Merge.py $folder.MERGE.denovo.config # starts merging
echo "End of cisa merge for $folder"
echo "beginning cisa for $folder"
CISA.py $folder.CISA.denovo.config
echo "End of cisa for $folder"
fi

cd ../ # change out of $i # ie the $folder 

done
