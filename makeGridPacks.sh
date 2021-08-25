#!/bin/bash -x

processes="B BB BBB tt t tB ttB LL LLB vbf H" #vbf-B vbf-H
energies="13 100" #TeV
test=1

##############################################
#module load python/3.7.0
#module load py-numpy/1.15.2-py3.7
#module load py-six/1.11.0-py3.7

#module load python/2.7.15
#module load py-numpy/1.15.2-py2.7
#module load py-six/1.11.0-py2.7

if [[ ! -d gridpacks ]]; then mkdir gridpacks;
else rm -rf gridpacks/*;
fi

for process in $processes; do
    for E in $energies; do
	sample=${E}TeV_${process}
	if [[ -d $sample ]]; then rm -rf $sample; fi

	python ${prodBase}/makeGridPacks.py $E $process $test

	date
	python ${prodBase}/MG5_aMC_v3_1_1/bin/mg5_aMC < ${prodBase}/run/makeGridPacks.mg
	date

	tar -xzvf $sample/run_01_gridpack.tar.gz
	
	cd madevent
	./bin/compile
	./bin/clean4grid
	cd ..
	chmod a+x run.sh
	sed 's%${DIR}/bin/gridrun $num_events $seed $gran%python2 ${DIR}/bin/gridrun $num_events $seed $gran%' --in-place run.sh
	tar -czvf ${prodBase}/run/gridpacks/${sample}.tar.gz madevent run.sh
	rm -rf madevent

	if [[ $test == 1 ]]; then break; fi
    done
    if [[ $test == 1 ]]; then break; fi
done

cd ..
