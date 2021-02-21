#!/bin/bash
#SBATCH -n 1
#SBATCH -p haswell
#SBATCH -q normal
#SBATCH -J simanfor
#SBATCH --time=01:00:00
#SBATCH -o /home/uva_iufor_1/uva_iufor_1_3/auto/logs/log_%j.o 
#SBATCH -e /home/uva_iufor_1/uva_iufor_1_3/auto/logs/log_%j.e

#SBATCH --mail-user=simanfor.data@forest.uva.es
#SBATCH --mail-type=ALL

ROOT=/home/uva_iufor_1/COMUNES/simanfor/simulator/simulator
SCRATCH=/scratch/uva_iufor_1/uva_iufor_1_3
EXPERIMENT_JSON=$1
EXPERIMENT_ID=$2

# carga de las variables necesarias para usar Python 3.7.7
module load python_3.7.7

python $ROOT/src/main.py -s $SCRATCH/input/$EXPERIMENT_JSON -logging_config_file $ROOT/config_files/logging.conf
cd $SCRATCH/output
zip -m ${EXPERIMENT_ID}.zip ${EXPERIMENT_ID}_Output_Plot_*
