if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

source $prodBase/setup.sh

if [[ ! -d run ]]; then mkdir run;
else rm -rf run/*;
fi
cd run
../makeGridPacks.sh
cd ..

if [[ ! -d test ]]; then mkdir test;
else rm -rf test/*;
fi
cd test
cp ../run/gridpacks/13TeV_B.tar.gz .
tar -xzvf 13TeV_B.tar.gz

./run.sh 10000 8
