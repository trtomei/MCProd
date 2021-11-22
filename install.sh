if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

source setup.sh

python3 -m pip install python-dev-tools --user --upgrade

#Rivet
wget https://gitlab.com/hepcedar/rivetbootstrap/raw/3.1.4/rivet-bootstrap
chmod +x rivet-bootstrap
INSTALL_PREFIX=$prodBase ./rivet-bootstrap
if [[ $? -ne 0 ]]; then
    echo "ERROR installing rivet"
    exit
fi
source rivet-env.sh

#MadGraph
wget https://launchpad.net/mg5amcnlo/3.0/3.1.x/+download/MG5_aMC_v3.1.1.tar.gz
tar -xzvf MG5_aMC_v3.1.1.tar.gz
echo "install pythia8" | python ./MG5_aMC_v3_1_1/bin/mg5_aMC
if [[ $? -ne 0 ]]; then
    echo "ERROR getting madgraph"
    exit
fi
rm MG5_aMC_v3.1.1.tar.gz

#Pythia
# wget https://pythia.org/download/pythia83/pythia8306.tgz
# tar -xzvf pythia8306.tgz
# cd pythia8306
# ./configure --prefix=$prodBase --with-hepmc2=$prodBase
# make -j
# make install
# if [[ $? -ne 0 ]]; then
#     echo "ERROR compiling pythia"
#     exit
# fi
# rm pythia8306.tgz
# cd ..

#Delphes
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${prodBase}/lib    
export PYTHIA8=$prodBase
git clone https://github.com/delphes/delphes.git
cd delphes
make -j #HAS_PYTHIA8=true -I${prodBase}/include/Pythia8
if [[ $? -ne 0 ]]; then
    echo "ERROR compiling delphes"
    exit
fi
cd ..
