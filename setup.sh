if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

export prodBase=$PWD

if [[ $HOSTNAME == "login.snowmass21.io" ]]; then
    module purge

    module load python/2.7.15
    module load py-numpy/1.15.2-py2.7
    module load py-six/1.11.0-py2.7
    
    #module load python/3.7.0
    #module load py-numpy/1.15.2-py3.7

    #module load cmake
    
    #source /cvmfs/sft.cern.ch/lcg/app/releases/ROOT/6.24.06/x86_64-fedora32-gcc102-opt/bin/thisroot.sh #maybe?
    #. /cvmfs/sft.cern.ch/lcg/app/releases/ROOT/6.24.06/x86_64-fedora32-gcc102-opt/bin/thisroot.sh
    . /cvmfs/sft.cern.ch/lcg/app/releases/ROOT/6.22.08/x86_64-centos7-gcc48-opt/bin/thisroot.sh  #original
    #source /cvmfs/sft.cern.ch/lcg/releases/LCG_99/ROOT/v6.22.06/x86_64-centos7-gcc10-opt/ROOT-env.sh  #for rivet
    #.     /cvmfs/sft.cern.ch/lcg/releases/LCG_99/ROOT/v6.22.08/x86_64-centos7-gcc48-opt/ROOT-env.sh
    
    #convenient
    module load emacs
else
    # Try to load a consistent version of ROOT, python, numpy and six such that we do not go mad
    source /cvmfs/sft.cern.ch/lcg/releases/LCG_99python2/ROOT/v6.22.06/x86_64-centos7-gcc8-opt/ROOT-env.sh
    # This *should* load ROOT v6.22.06, Python 2.7.16, numpy 1.16.4 and six 1.12.0
    which root >> /dev/null
    if [[ $? -ne 0 ]]; then
	echo "Please ensure ROOT is available and retry"
	exit
    fi
fi

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${prodBase}/lib #:${prodBase}/MG5_aMC_v2_9_7/HEPTools/lhapdf6_py3/lib                             
export PATH=$PATH:${prodBase}/bin:/cvmfs/sft.cern.ch/lcg/external/texlive/2016/bin/x86_64-linux
export PYTHONPATH=$PYTHONPATH:$PWD/lib/python2.7/site-packages
#export lhapdf=$prodBase/MG5_aMC_v2_9_7/HEPTools/bin/lhapdf-config
#export lhapdf=$prodBase/bin/lhapdf-config
export LHAPDF_DATA_PATH=$prodBase/PDFs
#if [[ -e rivetenv.sh ]]; then source rivetenv.sh; fi
