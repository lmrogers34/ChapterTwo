#!/bin/bash
for i in ec_pe_l*0
do
if [ -d $i ] # $i exists
then
cd $i/${i}_ref
sort ${i}_Aligned.out.sam > ${i}_sorted.sam
cd ../../
fi
done

