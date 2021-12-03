if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

rm -rf root_v*.source.tar.gz MG5_aMC_v* pythia* delphes share bin include lib etc build *.tar.gz *~ HepMC-* fastjet-* fjcontrib-* YODA-* cython-* yodaenv.sh Rivet-* rivetenv* ghostscript-* rivet-bootstrap py.py PROC_* LHAPDF-* dummy run test
if [[ -L lib64 ]]; then unlink lib64; fi



