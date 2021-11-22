if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

rm -rf MG5_aMC_v*/ pythia*/ delphes/ share/ bin/ include/ lib/ etc/ build *.tar.gz *~ HepMC-*-build fastjet-* fjcontrib-* YODA-* cython-* yodaenv.sh Rivet-* rivetenv* rivet-bootstrap
unlink lib64




