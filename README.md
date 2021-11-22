# MCProd

## Installation and setup
    git clone https://github.com/Snowmass21-software/MCProd.git -b rivet
    cd MCProd/
    ./install.sh


## Produce a single gridpack without extra partons at ME-level (quick test)

    source setup.sh
    ./test.sh 1

## Produce all gridpacks
    source setup.sh
    ./test.sh 0

## Produce events (no gridpack)

    source setup.sh
    ./generateEvents.sh <mg script> [delphes card]
where `<mg script>` contains a list of madgraph commands, and `[delphes card]` is an optional argument specifying which Delphes card to run.  For example:
    ./generateEvents.sh $PWD/test.mg $PWD/delphes/cards/delphes_card_FCCeh.tcl

      
