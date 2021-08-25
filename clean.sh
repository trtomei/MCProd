if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

rm -rf MG5_aMC_v3_1_1/ pythia8306/ delphes/ share/ bin/ include/ lib/ *.tar.gz *~
