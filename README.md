# MCProd

## Installation and setup
    git clone https://github.com/Snowmass21-software/MCProd.git -b gridpacks
    cd MCProd/
    ./install.sh


## Produce a single gridpack without extra partons at ME-level (quick test)

    source setup.sh
    ./testGridpacks.sh

## Produce all gridpacks
    source setup.sh
    ./makeGridPacks.sh

## Produce events (no gridpack) and run Rivet

    source setup.sh
    ./generateEvents.sh <mg script> [delphes card]
where `<mg script>` contains a list of madgraph commands, and `[delphes card]` is an optional argument specifying which Delphes card to run.  For example:

    ./generateEvents.sh $PWD/test.mg $PWD/delphes/cards/FCC/FCChh.tcl
      
