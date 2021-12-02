if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

#source $prodBase/setup.sh

if [[ ! -d run ]]; then mkdir run;
else rm -rf run/*;
fi
cd run
../makeGridPacks.sh 1
cd ..

if [[ ! -d test ]]; then mkdir test;
else rm -rf test/*;
fi
cd test
cp ../run/gridpacks/13TeV_B.tar.gz .
tar -xzvf 13TeV_B.tar.gz

sed 's%${DIR}/bin/gridrun $num_events $seed $gran%python ${DIR}/bin/gridrun $num_events $seed $gran%' run.sh --in-place
./run.sh 10000 8
