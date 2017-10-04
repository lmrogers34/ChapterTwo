# 7th
# spades l50
nohup ./spades.l50_f20.sh > spades.l50_f20.07-04-16.out 2> spades.l50_f20.07-04-16.err &
nohup ./spades.l50_f40.sh > spades.l50_f40.07-04-16.out 2> spades.l50_f40.07-04-16.err &
nohup ./spades.l50_f60.sh > spades.l50_f60.07-04-16.out 2> spades.l50_f60.07-04-16.err &
nohup ./spades.l50_f80.sh > spades.l50_f80.07-04-16.out 2> spades.l50_f80.07-04-16.err &
nohup ./spades.l50_f100.sh > spades.l50_f100.07-04-16.out 2> spades.l50_f100.07-04-16.err &
# spades l75
nohup ./spades.l75_f20.sh > spades.l75_f20.07-04-16.out 2> spades.l75_f20.07-04-16.err &
nohup ./spades.l75_f40.sh > spades.l75_f40.07-04-16.out 2> spades.l75_f40.07-04-16.err &
nohup ./spades.l75_f60.sh > spades.l75_f60.07-04-16.out 2> spades.l75_f60.07-04-16.err &
nohup ./spades.l75_f80.sh > spades.l75_f80.07-04-16.out 2> spades.l75_f80.07-04-16.err &
nohup ./spades.l75_f100.sh > spades.l75_f100.07-04-16.out 2> spades.l75_f100.07-04-16.err &
# spades l250
nohup ./spades.l250_f20.sh > spades.l250_f20.07-04-16.out 2> spades.l250_f20.07-04-16.err &
nohup ./spades.l250_f40.sh > spades.l250_f40.07-04-16.out 2> spades.l250_f40.07-04-16.err &
nohup ./spades.l250_f60.sh > spades.l250_f60.07-04-16.out 2> spades.l250_f60.07-04-16.err &
nohup ./spades.l250_f80.sh > spades.l250_f80.07-04-16.out 2> spades.l250_f80.07-04-16.err &
nohup ./spades.l250_f100.sh > spades.l250_f100.07-04-16.out 2> spades.l250_f100.07-04-16.err &
     
# Velvet l150 k 101..127..2

# When 10 cores free up can do assemblies.  When they finish - can do quast and reapr 
cd /cib/lisa/new_l100_paper1

#velvet.assembly_l150_f100.sh  velvet.assembly_l150_f20.sh   velvet.assembly_l150_f40.sh   velvet.assembly_l150_f60.sh   velvet.assembly_l150_f80.sh   

nohup ./velvet.assembly_l150_f20.sh > velvet.assembly_l150_f20.07-04-16.out 2> velvet.assembly_l150_f20.07-04-16.err &
nohup ./velvet.assembly_l150_f40.sh > velvet.assembly_l150_f40.07-04-16.out 2> velvet.assembly_l150_f40.07-04-16.err &
nohup ./velvet.assembly_l150_f60.sh > velvet.assembly_l150_f60.07-04-16.out 2> velvet.assembly_l150_f60.07-04-16.err &
nohup ./velvet.assembly_l150_f80.sh > velvet.assembly_l150_f80.07-04-16.out 2> velvet.assembly_l150_f80.07-04-16.err &
nohup ./velvet.assembly_l150_f100.sh > velvet.assembly_l150_f100.07-04-16.out 2> velvet.assembly_l150_f100.07-04-16.err &


# Abyss l150 k 101..127..2

#abyss.assembly_l150_f100.sh  abyss.assembly_l150_f20.sh   abyss.assembly_l150_f40.sh   abyss.assembly_l150_f60.sh   abyss.assembly_l150_f80.sh   

nohup ./abyss.assembly_l150_f20.sh > abyss.assembly_l150_f20.07-04-16.out 2> abyss.assembly_l150_f20.07-04-16.err &
nohup ./abyss.assembly_l150_f40.sh > abyss.assembly_l150_f40.07-04-16.out 2> abyss.assembly_l150_f40.07-04-16.err &
nohup ./abyss.assembly_l150_f60.sh > abyss.assembly_l150_f60.07-04-16.out 2> abyss.assembly_l150_f60.07-04-16.err &
nohup ./abyss.assembly_l150_f80.sh > abyss.assembly_l150_f80.07-04-16.out 2> abyss.assembly_l150_f80.07-04-16.err &
nohup ./abyss.assembly_l150_f100.sh > abyss.assembly_l150_f100.07-04-16.out 2> abyss.assembly_l150_f100.07-04-16.err &


# Soap l150 k101..127
#soap.assembly_l150_f100.sh  soap.assembly_l150_f20.sh   soap.assembly_l150_f40.sh   soap.assembly_l150_f60.sh   soap.assembly_l150_f80.sh   

nohup ./soap.assembly_l150_f20.sh > soap.assembly_l150_f20.07-04-16.out 2> soap.assembly_l150_f20.07-04-16.err &
nohup ./soap.assembly_l150_f40.sh > soap.assembly_l150_f40.07-04-16.out 2> soap.assembly_l150_f40.07-04-16.err &
nohup ./soap.assembly_l150_f60.sh > soap.assembly_l150_f60.07-04-16.out 2> soap.assembly_l150_f60.07-04-16.err &
nohup ./soap.assembly_l150_f80.sh > soap.assembly_l150_f80.07-04-16.out 2> soap.assembly_l150_f80.07-04-16.err &
nohup ./soap.assembly_l150_f100.sh > soap.assembly_l150_f100.07-04-16.out 2> soap.assembly_l150_f100.07-04-16.err &



# 8th


#velvet
nohup ./quast.velvet_l150_f20.sh > quast.velvet_l150_f20.08-04-16.out 2> quast.velvet_l150_f20.08-04-16.err &
nohup ./quast.velvet_l150_f40.sh > quast.velvet_l150_f40.08-04-16.out 2> quast.velvet_l150_f40.08-04-16.err &
nohup ./quast.velvet_l150_f60.sh > quast.velvet_l150_f60.08-04-16.out 2> quast.velvet_l150_f60.08-04-16.err &
nohup ./quast.velvet_l150_f80.sh > quast.velvet_l150_f80.08-04-16.out 2> quast.velvet_l150_f80.08-04-16.err &
nohup ./quast.velvet_l150_f100.sh > quast.velvet_l150_f100.08-04-16.out 2> quast.velvet_l150_f100.08-04-16.err &


# soap
nohup ./quast.soap_l150_f20.sh > quast.soap_l150_f20.08-04-16.out 2> quast.soap_l150_f20.08-04-16.err &
nohup ./quast.soap_l150_f40.sh > quast.soap_l150_f40.08-04-16.out 2> quast.soap_l150_f40.08-04-16.err &
nohup ./quast.soap_l150_f60.sh > quast.soap_l150_f60.08-04-16.out 2> quast.soap_l150_f60.08-04-16.err &
nohup ./quast.soap_l150_f80.sh > quast.soap_l150_f80.08-04-16.out 2> quast.soap_l150_f80.08-04-16.err &
nohup ./quast.soap_l150_f100.sh > quast.soap_l150_f100.08-04-16.out 2> quast.soap_l150_f100.08-04-16.err &


# reapr
#velvet
nohup ./reapr.velvet.l150_f20.sh > reapr.velvet.l150_f20.08-04-16.out 2> reapr.velvet.l150_f20.08-04-16.err &
nohup ./reapr.velvet.l150_f40.sh > reapr.velvet.l150_f40.08-04-16.out 2> reapr.velvet.l150_f40.08-04-16.err &
nohup ./reapr.velvet.l150_f60.sh > reapr.velvet.l150_f60.08-04-16.out 2> reapr.velvet.l150_f60.08-04-16.err &
nohup ./reapr.velvet.l150_f80.sh > reapr.velvet.l150_f80.08-04-16.out 2> reapr.velvet.l150_f80.08-04-16.err &
nohup ./reapr.velvet.l150_f100.sh > reapr.velvet.l150_f100.08-04-16.out 2> reapr.velvet.l150_f100.08-04-16.err &

# soap
nohup ./reapr.soap.l150_f20.sh > reapr.soap.l150_f20.08-04-16.out 2> reapr.soap.l150_f20.08-04-16.err &
nohup ./reapr.soap.l150_f40.sh > reapr.soap.l150_f40.08-04-16.out 2> reapr.soap.l150_f40.08-04-16.err &
nohup ./reapr.soap.l150_f60.sh > reapr.soap.l150_f60.08-04-16.out 2> reapr.soap.l150_f60.08-04-16.err &
nohup ./reapr.soap.l150_f80.sh > reapr.soap.l150_f80.08-04-16.out 2> reapr.soap.l150_f80.08-04-16.err &
nohup ./reapr.soap.l150_f100.sh > reapr.soap.l150_f100.08-04-16.out 2> reapr.soap.l150_f100.08-04-16.err &



# velvet_ref k101..127..2
nohup ./velvet.ref_l150_f100.sh > velvet.ref_l150_f100.08-04-16.out 2> velvet.ref_l150_f100.08-04-16.err &
nohup ./velvet.ref_l150_f20.sh > velvet.ref_l150_f20.08-04-16.out 2> velvet.ref_f20_f100.08-04-16.err &
nohup ./velvet.ref_l150_f40.sh > velvet.ref_l150_f40.08-04-16.out 2> velvet.ref_l150_f40.08-04-16.err &
nohup ./velvet.ref_l150_f60.sh > velvet.ref_l150_f60.08-04-16.out 2> velvet.ref_l150_f60.08-04-16.err &
nohup ./velvet.ref_l150_f80.sh > velvet.ref_l150_f80.08-04-16.out 2> velvet.ref_l150_f80.08-04-16.err &



# spades
# when assemblies are done - run these
cd /cib/lisa/new_l100_paper1/redo_spades
nohup ./quast.spades_l50.sh > quast.spades_l50.07-04-16.out 2>  quast.spades_l50.07-04-16.err &
nohup ./reapr.spades.fullPipeline.contigs.l50.sh > reapr.spades.fullPipeline.contigs.l50.07-04-16.out 2> reapr.spades.fullPipeline.contigs.l50.07-04-16.err &
nohup ./reapr.spades.fullPipeline.contigs.l250.sh > reapr.spades.fullPipeline.contigs.l250.08-04-16.out 2> reapr.spades.fullPipeline.contigs.l250.08-04-16.err &

# When assemblies are done :
cd /cib/lisa/new_l100_paper1
# quast

# abyss
nohup ./quast.abyss_l150_f20.sh > quast.abyss_l150_f20.08-04-16.out 2> quast.abyss_l150_f20.08-04-16.err &
nohup ./quast.abyss_l150_f40.sh > quast.abyss_l150_f40.08-04-16.out 2> quast.abyss_l150_f40.08-04-16.err &
nohup ./quast.abyss_l150_f60.sh > quast.abyss_l150_f60.08-04-16.out 2> quast.abyss_l150_f60.08-04-16.err &
nohup ./quast.abyss_l150_f80.sh > quast.abyss_l150_f80.08-04-16.out 2> quast.abyss_l150_f80.08-04-16.err &
nohup ./quast.abyss_l150_f100.sh > quast.abyss_l150_f100.08-04-16.out 2> quast.abyss_l150_f100.08-04-16.err &
# reapr
# abyss
nohup ./reapr.abyss.l150_f20.sh > reapr.abyss.l150_f20.08-04-16.out 2> reapr.abyss.l150_f20.08-04-16.err &
nohup ./reapr.abyss.l150_f40.sh > reapr.abyss.l150_f40.08-04-16.out 2> reapr.abyss.l150_f40.08-04-16.err &
nohup ./reapr.abyss.l150_f60.sh > reapr.abyss.l150_f60.08-04-16.out 2> reapr.abyss.l150_f60.08-04-16.err &
nohup ./reapr.abyss.l150_f80.sh > reapr.abyss.l150_f80.08-04-16.out 2> reapr.abyss.l150_f80.08-04-16.err &
nohup ./reapr.abyss.l150_f100.sh > reapr.abyss.l150_f100.08-04-16.out 2> reapr.abyss.l150_f100.08-04-16.err &



nohup ./quast.spades_l250.sh > quast.spades_l250.08-04-16.out 2>  quast.spades_l250.08-04-16.err &





nohup ./quast.velvet_ref_l101_f60.sh  > quast.velvet_ref_l101_f60.08-04-16.out 2> quast.velvet_ref_l101_f60.08-04-16.err &
nohup ./quast.velvet_ref_l101_f80.sh  > quast.velvet_ref_l101_f80.08-04-16.out 2> quast.velvet_ref_l101_f80.08-04-16.err &


nohup ./quast.velvet_ref_l150_f20.sh  > quast.velvet_ref_l150_f20.08-04-16.out 2> quast.velvet_ref_l150_f20.08-04-16.err &
nohup ./quast.velvet_ref_l150_f40.sh  > quast.velvet_ref_l150_f40.08-04-16.out 2> quast.velvet_ref_l150_f40.08-04-16.err &
nohup ./quast.velvet_ref_l150_f60.sh  > quast.velvet_ref_l150_f60.08-04-16.out 2> quast.velvet_ref_l150_f60.08-04-16.err &
nohup ./quast.velvet_ref_l150_f80.sh  > quast.velvet_ref_l150_f80.08-04-16.out 2> quast.velvet_ref_l150_f80.08-04-16.err &
nohup ./quast.velvet_ref_l150_f100.sh  > quast.velvet_ref_l150_f100.08-04-16.out 2> quast.velvet_ref_l150_f100.08-04-16.err &




nohup ./reapr.velvet_ref.l150_f100.sh  > reapr.velvet_ref.l150_f100.08-04-16.out 2> reapr.velvet_ref.l150_f100.08-04-16.err &
nohup ./reapr.velvet_ref.l150_f20.sh  > reapr.velvet_ref.l150_f20.08-04-16.out 2> reapr.velvet_ref.l150_f20.08-04-16.err &
nohup ./reapr.velvet_ref.l150_f40.sh  > reapr.velvet_ref.l150_f40.08-04-16.out 2> reapr.velvet_ref.l150_f40.08-04-16.err &
nohup ./reapr.velvet_ref.l150_f60.sh  > reapr.velvet_ref.l150_f60.08-04-16.out 2> reapr.velvet_ref.l150_f60.08-04-16.err &
nohup ./reapr.velvet_ref.l150_f80.sh  > reapr.velvet_ref.l150_f80.08-04-16.out 2> reapr.velvet_ref.l150_f80.08-04-16.err &



nohup ./reapr.velvet_ref.l101_f100.sh  > reapr.velvet_ref.l101_f100.08-04-16.out 2> reapr.velvet_ref.l101_f100.08-04-16.err &
nohup ./reapr.velvet_ref.l101_f20.sh  > reapr.velvet_ref.l101_f20.08-04-16.out 2> reapr.velvet_ref.l101_f20.08-04-16.err &
nohup ./reapr.velvet_ref.l101_f40.sh  > reapr.velvet_ref.l101_f40.08-04-16.out 2> reapr.velvet_ref.l101_f40.08-04-16.err &
nohup ./reapr.velvet_ref.l101_f60.sh  > reapr.velvet_ref.l101_f60.08-04-16.out 2> reapr.velvet_ref.l101_f60.08-04-16.err &
nohup ./reapr.velvet_ref.l101_f80.sh  > reapr.velvet_ref.l101_f80.08-04-16.out 2> reapr.velvet_ref.l101_f80.08-04-16.err &


##
#Abyss
cd /cib/lisa/denovo/abyss_redo_06-05-16
#reapr abyss l50
#l75
nohup ./reapr.abyss.fullPipeline.l75_f20.sh > reapr.abyss.fullPipeline.l75_f20.08-04-16.out 2> reapr.abyss.fullPipeline.l75_f20.08-04-16.err &
nohup ./reapr.abyss.fullPipeline.l75_f40.sh > reapr.abyss.fullPipeline.l75_f40.08-04-16.out 2> reapr.abyss.fullPipeline.l75_f40.08-04-16.err &
nohup ./reapr.abyss.fullPipeline.l75_f60.sh > reapr.abyss.fullPipeline.l75_f60.08-04-16.out 2> reapr.abyss.fullPipeline.l75_f60.08-04-16.err &
nohup ./reapr.abyss.fullPipeline.l75_f80.sh > reapr.abyss.fullPipeline.l75_f80.08-04-16.out 2> reapr.abyss.fullPipeline.l75_f80.08-04-16.err &
nohup ./reapr.abyss.fullPipeline.l75_f100.sh > reapr.abyss.fullPipeline.l75_f100.08-04-16.out 2> reapr.abyss.fullPipeline.l75_f100.08-04-16.err &
#l250
nohup ./reapr.abyss.fullPipeline.l250_f20.sh > reapr.abyss.fullPipeline.l250_f20.08-04-16.out 2> reapr.abyss.fullPipeline.l250_f20.08-04-16.err &
nohup ./reapr.abyss.fullPipeline.l250_f40.sh > reapr.abyss.fullPipeline.l250_f40.08-04-16.out 2> reapr.abyss.fullPipeline.l250_f40.08-04-16.err &
nohup ./reapr.abyss.fullPipeline.l250_f60.sh > reapr.abyss.fullPipeline.l250_f60.08-04-16.out 2> reapr.abyss.fullPipeline.l250_f60.08-04-16.err &
nohup ./reapr.abyss.fullPipeline.l250_f80.sh > reapr.abyss.fullPipeline.l250_f80.08-04-16.out 2> reapr.abyss.fullPipeline.l250_f80.08-04-16.err &
nohup ./reapr.abyss.fullPipeline.l250_f100.sh > reapr.abyss.fullPipeline.l250_f100.08-04-16.out 2> reapr.abyss.fullPipeline.l250_f100.08-04-16.err &



# 
nohup ./quast.abyss.l250_f20.sh > quast.abyss.l250_f20.09-04-16.out 2> quast.abyss.l250_f20.09-04-16.err &
nohup ./quast.abyss.l250_f40.sh > quast.abyss.l250_f40.09-04-16.out 2> quast.abyss.l250_f40.09-04-16.err &
nohup ./quast.abyss.l250_f60.sh > quast.abyss.l250_f60.09-04-16.out 2> quast.abyss.l250_f60.09-04-16.err &
nohup ./quast.abyss.l250_f100.sh > quast.abyss.l250_f100.09-04-16.out 2> quast.abyss.l250_f100.09-04-16.err &

nohup ./quast.abyss.l75_f20.sh > quast.abyss.l75_f20.09-04-16.out 2> quast.abyss.l75_f20.09-04-16.err &
nohup ./quast.abyss.l75_f40.sh > quast.abyss.l75_f40.09-04-16.out 2> quast.abyss.l75_f40.09-04-16.err &
nohup ./quast.abyss.l75_f60.sh > quast.abyss.l75_f60.09-04-16.out 2> quast.abyss.l75_f60.09-04-16.err &
nohup ./quast.abyss.l75_f80.sh > quast.abyss.l75_f80.09-04-16.out 2> quast.abyss.l75_f80.09-04-16.err &
nohup ./quast.abyss.l75_f100.sh > quast.abyss.l75_f100.09-04-16.out 2> quast.abyss.l75_f100.09-04-16.err &


# spades
nohup ./quast.spades_l75.sh > quast.spades_l75.08-04-16.out 2>  quast.spades_l75.08-04-16.err &
# reapr
nohup ./reapr.spades.fullPipeline.contigs.l75.sh > reapr.spades.fullPipeline.contigs.l75.08-04-16.out 2> reapr.spades.fullPipeline.contigs.l50.08-04-16.err &

