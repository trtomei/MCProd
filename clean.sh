if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

rm -rf MG5_aMC_v* pythia* delphes share bin include lib etc build *.tar.gz *~ HepMC-* fastjet-* fjcontrib-* YODA-* cython-* yodaenv.sh Rivet-* rivetenv*
unlink lib64



