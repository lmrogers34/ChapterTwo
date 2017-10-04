#!/bin/bash
# script for merging contigs using cisa
for i in ec_pe_l250*0 # all folders within top 5
do

if [ -d ${i}_denovo_merge3 ] # if it is a dir ( -d checks if $i is a dir)
then
echo "Changing to ${i}_denovo_merge3..."
folder=${i}_denovo_merge3
cd ${i}_denovo_merge3
else
echo "${i}_denovo_merge3 doesn't exist.  Creating..."
mkdir ${i}_denovo_merge3
folder=${i}_denovo_merge3
cd ${i}_denovo_merge3
fi # if dir check

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

	if [ -f $folder.MERGE.denovo.merge3.config ] # if the cisa merge already happened then we don't recreate the script
		then
		echo "$folder.MERGE.denovo.merge3.config exists"
	else # if it doesn't then we create the config files we require.
		echo "Creating Merge file for $folder"
		touch $folder.MERGE.denovo.merge3.config # touch - creates a file
		echo "count=3" >>$folder.MERGE.denovo.merge3.config # tells cisa how many files we'll be merging
		echo "data=$spades,title=spades" >>$folder.MERGE.denovo.merge3.config
		echo "data=$velvet,title=velvet" >>$folder.MERGE.denovo.merge3.config
		echo "data=$abyss,title=abyss" >>$folder.MERGE.denovo.merge3.config
#		echo "data=$mira,title=mira" >>$folder.MERGE.denovo.merge3.config
#		echo "data=$soap,title=soap" >>$folder.MERGE.denovo.merge3.config
#		echo "data=$velvet_ref,title=velvet_ref" >>$folder.MERGE.denovo.merge3.config
#		echo "data=$mira_ref,title=mira_ref" >>$folder.MERGE.denovo.merge3.config
		echo "Master_file=$folder.denovo.merge3" >>$folder.MERGE.denovo.merge3.config
		echo "min_length=100" >>$folder.MERGE.denovo.merge3.config
		echo "Gap=11" >>$folder.MERGE.denovo.merge3.config
		echo "Merge file created for $folder"
	fi # end of config if check 



if [ -f $folder.CISA.denovo.merge3.config ]
then
echo "$folder.CISA.denovo.merge3.config exists"
else
echo "Creating CISA file for $folder"
touch $folder.CISA.denovo.merge3.config
echo "genome=5500000" >>$folder.CISA.denovo.merge3.config # 5500000 is the estimate of our genome size
echo "infile=$folder.denovo.merge3" >>$folder.CISA.denovo.merge3.config
echo "outfile=$folder.denovo.merge3.cisa.fa" >>$folder.CISA.denovo.merge3.config
echo "R2_Gap=0.95" >>$folder.CISA.denovo.merge3.config
echo "nucmer=/home/lrogers/tools/MUMmer3.23/nucmer" >>$folder.CISA.denovo.merge3.config # points where the tools are installed. 
echo "CISA=/home/lrogers/tools/CISA1.3/" >>$folder.CISA.denovo.merge3.config
echo "makeblastdb=/usr/bin/makeblastdb" >>$folder.CISA.denovo.merge3.config
echo "blastn=/usr/bin/blastn" >>$folder.CISA.denovo.merge3.config
echo "CISA file created for $folder"
fi




if [ -f $folder.denovo.merge3.cisa.fa ]
then
echo "$folder already merged"
elif [ -f $folder.denovo.merge3 ]
then
echo "merge file exists.  Problem with EOF"
echo "beginning cisa for $folder"
CISA.py $folder.CISA.denovo.merge3.config <<-EOF
y
EOF
else
echo "beginning cisa merge for $folder"
Merge.py $folder.MERGE.denovo.merge3.config # starts merging
echo "End of cisa merge for $folder"
echo "beginning cisa for $folder"
CISA.py $folder.CISA.denovo.merge3.config
echo "End of cisa for $folder"
fi

cd ../ # change out of $i # ie the $folder 

done
