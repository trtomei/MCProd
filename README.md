# MCProd

## Installation and setup
    git clone https://github.com/Snowmass21-software/MCProd.git
    cd MCProd/
    ./install.sh
    source setup.sh

## Produce a single gridpack without extra partons at ME-level (quick test)
  
    ./test.sh 1

## Produce all gridpacks

    ./test.sh 0

## Produce events (no gridpack)

    ./generateEvents.sh <mg script> [delphes card]
where `<mg script>` contains a list of madgraph commands, and `[delphes card]` is an optional argument specifying which Delphes card to run.
