set lhapdf_py2 /tank/scratch/jstupak/dev/MCProd/bin/lhapdf-config
generate p p > Z
add process p p > Z g
output
launch
#shower = Pythia8
analysis = off
done
Cards/run_card.dat
#Cards/pythia8_card.dat
set xqcut 40
set nevents 10
done