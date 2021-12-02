if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

#root
#wget https://root.cern/download/root_v6.24.06.source.tar.gz
#tar -xzvf root_v6.24.06.source.tar.gz
#mkdir build
#cd build
#cmake -DCMAKE_INSTALL_PREFIX=$prodBase -DCMAKE_CXX_STANDARD=14 ../root-6.24.06/
#cmake --build . --target install -- -j8

#MadGraph                                                                                                                                  
wget https://launchpad.net/mg5amcnlo/3.0/3.3.x/+download/MG5_aMC_v2.9.7.tar.gz
tar -xzvf MG5_aMC_v2.9.7.tar.gz
echo "install pythia8" | python ./MG5_aMC_v2_9_7/bin/mg5_aMC
if [[ $? -ne 0 ]]; then
    echo "ERROR getting madgraph"
    exit
fi
rm MG5_aMC_v2.9.7.tar.gz

#Delphes
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${prodBase}/lib
#export PYTHIA8=$prodBase
git clone https://github.com/delphes/delphes.git
cd delphes
make -j8 #HAS_PYTHIA8=true -I${prodBase}/include/Pythia8
if [[ $? -ne 0 ]]; then
    echo "ERROR compiling delphes"
    exit
fi
cd ..

#Rivet dependencies
python3 -m pip install python-dev-tools --user --upgrade
if [[ $? -ne 0 ]]; then
    echo "ERROR installing python-dev-tools"
    exit
fi
wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9550/ghostscript-9.55.0.tar.gz
tar -xzvf ghostscript-9.55.0.tar.gz 
cd ghostscript-9.55.0/
./configure --prefix=$prodBase
make -j8
make install
if [[ $? -ne 0 ]]; then
    echo "ERROR installing ghostscript"
    exit
fi
cd ..

#Rivet
wget https://gitlab.com/hepcedar/rivetbootstrap/raw/3.1.4/rivet-bootstrap
chmod +x rivet-bootstrap
source /cvmfs/sft.cern.ch/lcg/releases/LCG_99/ROOT/v6.22.06/x86_64-centos7-gcc10-opt/ROOT-env.sh
INSTALL_PREFIX=$prodBase ./rivet-bootstrap
if [[ $? -ne 0 ]]; then
    echo "ERROR installing rivet"
    exit
fi
#source rivetenv.sh

# #MadGraph
# wget https://launchpad.net/mg5amcnlo/3.0/3.3.x/+download/MG5_aMC_v2.9.7.tar.gz
# tar -xzvf MG5_aMC_v2.9.7.tar.gz
# echo "install pythia8" | python ./MG5_aMC_v2_9_7/bin/mg5_aMC
# if [[ $? -ne 0 ]]; then
#     echo "ERROR getting madgraph"
#     exit
# fi
# rm MG5_aMC_v2.9.7.tar.gz

# #Pythia
# # wget https://pythia.org/download/pythia83/pythia8306.tgz
# # tar -xzvf pythia8306.tgz
# # cd pythia8306
# # ./configure --prefix=$prodBase --with-hepmc2=$prodBase
# # make -j
# # make install
# # if [[ $? -ne 0 ]]; then
# #     echo "ERROR compiling pythia"
# #     exit
# # fi
# # rm pythia8306.tgz
# # cd ..

# #Delphes
# #export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${prodBase}/lib    
# #export PYTHIA8=$prodBase
# git clone https://github.com/delphes/delphes.git
# cd delphes
# make -j8 #HAS_PYTHIA8=true -I${prodBase}/include/Pythia8
# if [[ $? -ne 0 ]]; then
#     echo "ERROR compiling delphes"
#     exit
# fi
# cd ..
