if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

source setup.sh

#Rivet
wget https://gitlab.com/hepcedar/rivetbootstrap/raw/3.1.4/rivet-bootstrap
chmod +x rivet-bootstrap
INSTALL_PREFIX=$prodBase ./rivet-bootstrap

#MadGraph
wget https://launchpad.net/mg5amcnlo/3.0/3.1.x/+download/MG5_aMC_v3.1.1.tar.gz
tar -xzvf MG5_aMC_v3.1.1.tar.gz
if [[ $? -ne 0 ]]; then
    echo "ERROR getting madgraph"
    exit
fi
rm MG5_aMC_v3.1.1.tar.gz

#Pythia
wget https://pythia.org/download/pythia83/pythia8306.tgz
tar -xzvf pythia8306.tgz
cd pythia8306
./configure --prefix=$prodBase --with-hepmc2=$prodBase
make -j
make install
if [[ $? -ne 0 ]]; then
    echo "ERROR compiling pythia"
    exit
fi
rm pythia8306.tgz
cd ..

#Delphes
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${prodBase}/lib    
export PYTHIA8=$prodBase
git clone https://github.com/delphes/delphes.git
cd delphes
make HAS_PYTHIA8=true -j -I${prodBase}/include/Pythia8
if [[ $? -ne 0 ]]; then
    echo "ERROR compiling delphes"
    exit
fi

#echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${prodBase}/lib" >> ~/.bash_profile
