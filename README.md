# CrossForest-simulations
simulations performed at hpc - scripts and notes

## Simulations with randomly generated plots - 0 spp 999
All plots has been randomly generated with an R script `PlotsGenerator.R` in which number of trees per plot, number of plots per file and average dimension of trees is predefined.

There are a set of 9 simulations, from sim001 to sim009, with a raising number of total plots.

The scenario (`sim###.scenario.json`) is the same for all of the simulations, in which from 25 to 140 years are simulated with a thinning at 75 years

Simulation input files is generated with `sim###.make.input.sh` which run the R script as many times as necessary and generates the scenarios based on the template.

## Simulations with NFI - 1 *Pinus sylvestris* (Psy) pure

## Simulations with NFI - 2 *Pinus pinaster* (Ptr) pure

## Simulations with NFI - 3 *Pinus pinaster* atlantica (Ptr-A)

## Simulations with NFI - 4 *Pinus nigra* (Png) pure

## Simulations with NFI - 5 *Fagus sylvatica* (Fsy) pure

## Simulations with NFI - 6 *Quercus pyrenaica* (Qpy) pure

## Simulations with NFI - 7 *Quercus robur* (Qrb) pure

## Simulations with NFI - 8 *Quercus petrea* (Qpt) pure

## Simulations with NFI - 9 Psy + Ptr

## Simulations with NFI - 10 Psy + Png

## Simulations with NFI - 11 Psy + Fsy

## Simulations with NFI - 12 Psy + Qpy

## Simulations with NFI - 13 Psy + Qrb

## Simulations with NFI - 14 Psy + Qpt

## Simulations with NFI - 15 Ptr + Png

## Simulations with NFI - 16 Ptr + Qpy

## Simulations with NFI - 17 Png + Qpy

## Simulations with NFI - 18 Fsy + Qrb

## Simulations with NFI - 19 Fsy + Qpt

## Simulations with NFI - 20 Qrb + Qpt

## Simulations with NFI - 21 Qrb + Qpy

## Simulations with NFI - 22 Qpt + Qpy
