if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

Nproc=32

#source setup.sh
source /cvmfs/sft.cern.ch/lcg/releases/LCG_99/ROOT/v6.22.06/x86_64-centos7-gcc10-opt/ROOT-env.sh

#LHAPDF
wget https://lhapdf.hepforge.org/downloads/?f=LHAPDF-6.4.0.tar.gz -O LHAPDF-6.4.0.tar.gz
tar -xzvf LHAPDF-6.4.0.tar.gz 
cd LHAPDF-6.4.0
./configure --prefix=$prodBase
make  -j$Nproc
make install
if [[ $? -ne 0 ]]; then
    echo "ERROR installing rivet dependencies"
    exit
fi;
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
make  -j$Nproc
make install
if [[ $? -ne 0 ]]; then
    echo "ERROR installing rivet dependencies"
    exit
fi;
cd ..

#Rivet
wget https://gitlab.com/hepcedar/rivetbootstrap/raw/3.1.4/rivet-bootstrap
chmod +x rivet-bootstrap
INSTALL_PREFIX=$prodBase ./rivet-bootstrap
if [[ $? -ne 0 ]]; then
    echo "ERROR installing LHAPDF"
    exit
fi
cd ..

mkdir PDFs
./bin/lhapdf install NNPDF31_nnlo_as_0118 --listdir share/LHAPDF/ --pdfdir PDFs

#MadGraph
wget https://launchpad.net/mg5amcnlo/3.0/3.3.x/+download/MG5_aMC_v3.3.1.tar.gz
tar -xzvf MG5_aMC_v3.3.1.tar.gz
echo "install mg5amc_py8_interface" | ./MG5_aMC_v3_1_1/bin/mg5_aMC
if [[ $? -ne 0 ]]; then
    echo "ERROR getting madgraph"
    exit
fi
rm MG5_aMC_v3.3.1.tar.gz

#Pythia
wget https://pythia.org/download/pythia83/pythia8306.tgz
tar -xzvf pythia8306.tgz
cd pythia8306
./configure --prefix=$prodBase --with-hepmc2=$prodBase --with-gzip
make -j$Nproc
make install
cd examples/
make main88
if [[ $? -ne 0 ]]; then
    echo "ERROR compiling pythia"
    exit
fi
cd ../..
rm pythia8306.tgz

#Delphes
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${prodBase}/lib
#export PYTHIA8=$prodBase
git clone https://github.com/delphes/delphes.git
cd delphes
make -j$Nproc #HAS_PYTHIA8=true -I${prodBase}/include/Pythia8
if [[ $? -ne 0 ]]; then
    echo "ERROR compiling delphes"
    exit
fi
cd ..
