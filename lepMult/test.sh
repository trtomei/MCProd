#!/bin/bash

if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

#source setup.sh

#rm -rf MG5_aMC_v3_1_1
#bzr branch lp:~maddevelopers/mg5amcnlo/madspin_fake_br MG5_aMC_v3_1_1

#cp -r lepMult/lepMultBias/ MG5_aMC_v3_1_1/Template/LO/Source/BIAS/lepMult

cd MG5_aMC_v2_9_7
rm -rf step*

python ./bin/mg5_aMC < ../lepMult/step1.mg
python ./bin/mg5_aMC < ../lepMult/step2.mg

gunzip step1/Events/run_0?/unweighted_events.lhe.gz
gunzip step2/Events/run_0?_decayed_1/unweighted_events.lhe.gz

echo
cat step1/Events/run_01/unweighted_events.lhe | grep "\-15  1" | wc -l
cat step1/Events/run_02/unweighted_events.lhe | grep "\-15  1" | wc -l
cat step2/Events/run_01_decayed_1/unweighted_events.lhe | grep "\-15  1" | wc -l
cat step2/Events/run_02_decayed_1/unweighted_events.lhe | grep "\-15  1" | wc -l

cd ..
