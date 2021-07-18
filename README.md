# CrossForest-simulations
simulations performed at hpc - scripts and notes

## Simulations with randomly generated plots - 0 spp 999
All plots has been randomly generated with an R script `PlotsGenerator.R` in which number of trees per plot, number of plots per file and average dimension of trees is predefined.

There are a set of 9 simulations, from sim001 to sim009, with a raising number of total plots.

The scenario (`sim###.scenario.json`) is the same for all of the simulations, in which from 25 to 140 years are simulated with a thinning at 75 years

Simulation input files is generated with `sim###.make.input.sh` which run the R script as many times as necessary and generates the scenarios based on the template.


[Go to test simulations](./test.simulations/README.md)


## Simulations with NFI plots

After testing HPC and SIMANFOR performance, we run simulations with all possible plots from Spanish NFI with 5 different scenarios

[Go to real simulations](./real.simulations/README.md)

