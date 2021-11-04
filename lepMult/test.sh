#!/bin/bash
cd MG5_aMC_v3_1_1

rm -rf step*
./bin/mg5_aMC < ../lepMult/step1.mg

./bin/mg5_aMC < ../lepMult/step2.mg

: <<'END'
./bin/mg5_aMC
    #ENTER THESE COMMANDS BY HAND:
    launch step2
    done
    3 -> set run_card /Users/jstupak/workArea/snowmass/productionTeam/MCProd/MG5_aMC_v3_1_1/step1/Cards/run_card.dat
    done
    exit

    gunzip step2/Events/run_0?_decayed_1/unweighted_events.lhe.gz
    cat step2/Events/run_01_decayed_1/unweighted_events.lhe | grep "\-15  1" | wc
    cat step2/Events/run_02_decayed_1/unweighted_events.lhe | grep "\-15  1" | wc
    cat step2/Events/run_03_decayed_1/unweighted_events.lhe | grep "\-15  1" | wc
    cat step2/Events/run_04_decayed_1/unweighted_events.lhe | grep "\-15  1" | wc
END

gunzip step1/Events/run_0?/unweighted_events.lhe.gz
gunzip step2/Events/run_0?_decayed_1/unweighted_events.lhe.gz

cat step1/Events/run_01/unweighted_events.lhe | grep "\-15  1" | wc -l
cat step1/Events/run_02/unweighted_events.lhe | grep "\-15  1" | wc -l
cat step2/Events/run_01_decayed_1/unweighted_events.lhe | grep "\-15  1" | wc -l
cat step2/Events/run_02_decayed_1/unweighted_events.lhe | grep "\-15  1" | wc -l

#cat step2/Events/run_03_decayed_1/unweighted_events.lhe | grep "\-15  1" | wc
#cat step2/Events/run_04_decayed_1/unweighted_events.lhe | grep "\-15  1" | wc
