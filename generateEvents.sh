#!/bin/bash -x

if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi
if [[ $# < 1 ]]; 
then 
    echo "Usage: ./generateEvents.sh <mg script> [delphes card]"
    echo "Example: ./generateEvents.sh $PWD/test.mg $PWD/delphes/cards/gen_card.tcl"
    exit
else
    mgScript=$1
    if [[ $# -gt 1 ]]; then
	delphesCard=$2
    else
	delphesCard="cards/gen_card.tcl"
    fi
fi

#source setup.sh

touch .dummy

#########################################################################

#cd MG5_aMC_v3_3_1
python MG5_aMC_v3_3_1/bin/mg5_aMC < "${mgScript}"
gzs=`find . -newer .dummy -name "unweighted_events.lhe.gz" -exec echo $PWD/{} \;`
echo $gzs

#------------------------------------------------------------------------
cd delphes
for gz in $gzs; do 
    lhe=${gz%%.gz}
    pythiaOutput=`dirname $lhe`/tag_1_pythia8_events.hepmc.gz
    delphesOutput=${lhe%%.lhe}.root  #set delphes output path/name
    
    gunzip $gz
    #n=`grep -c \<event\> $lhe`
    #echo $n
    #sed s%examples/Pythia8/events.lhe%$lhe% examples/Pythia8/configLHE.cmnd > configLHE.cmnd #this will create a new config pointing to your lhe
    ###sed "s%Main:numberOfEvents = 10%Main:numberOfEvents = $n%" --in-place configLHE.cmnd
    #./DelphesPythia8 $delphesCard configLHE.cmnd $delphesOutput  #this runs delphes using your new config
    ./DelphesLHEF $delphesCard $delphesOutput $lhe

done

#------------------------------------------------------------------------
source $prodBase/rivetenv.sh
source /cvmfs/sft.cern.ch/lcg/releases/LCG_99/ROOT/v6.22.06/x86_64-centos7-gcc10-opt/ROOT-env.sh
#------------------------------------------------------------------------

for gz in $gzs; do
    lhe=${gz%%.gz}
    pythiaOutput=`dirname $lhe`/tag_1_pythia8_events.hepmc.gz

    cd `dirname $lhe`
    rivet --analysis=MC_GENERIC $pythiaOutput
    rivet-mkhtml Rivet.yoda
done
