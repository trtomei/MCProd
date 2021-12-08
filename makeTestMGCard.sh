#!/bin/bash -x

if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

if [[ -f test.mg ]];
then
    rm test.mg
fi

prodBase="$PWD"

printf 'set lhapdf %s/bin/lhapdf-config\n' "$prodBase/MG5_aMC_v2_9_7" > test.mg
printf 'set lhapdf_py2 %s/bin/lhapdf-config\n' "$prodBase/MG5_aMC_v2_9_7" >> test.mg
printf 'generate p p > Z\n' >> test.mg
#printf 'add process p p > Z g\n' >> test.mg # Add whatever process you want.
printf 'output\n' >> test.mg
printf 'launch\n' >> test.mg
printf 'shower = Pythia8\n' >> test.mg
#printf 'analysis = off\n' >> test.mg
printf 'done\n' >> test.mg
printf 'Cards/run_card.dat\n' >> test.mg
printf 'Cards/pythia8_card.dat\n' >> test.mg
printf 'done\n' >> test.mg
