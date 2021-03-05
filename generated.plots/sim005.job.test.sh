#!/bin/bash
# numero de cores que serán reservados
#SBATCH -n 1
# particion en donde se ejecutara el trabajo
#SBATCH -p haswell
# limites que se aplicaran al trabajo
#SBATCH -q normal
# nombre
#SBATCH -J sm4_simul_sim005-test
# tiempo maximo de ejecucion (p.e. 2 dias). Maximo permitido: 5 dias
#SBATCH --time=02:00:00
# archivos de salida y de error
#SBATCH -o sm4_simul_sim005-test.o
#SBATCH -e sm4_simul_sim005-test.e
# directorio de trabajo por defecto
#SBATCH -D .
# notificaciones por email relacionadas con la ejecucion del trabajo
#SBATCH --mail-user=angelcristobal.ordonez@uva.es
#SBATCH --mail-type=ALL
############ SBATCH --array=1-40
ROOT=/home/uva_iufor_1/COMUNES/simanfor/simulator/simulator
SCNR=/scratch/uva_iufor_1/uva_iufor_1_3/sim005/scenario/scnr_sp999_1_10-100.json
# carga de las variables necesarias para usar Python 3.7.7
module load python_3.7.7
# ejecution of simulator
python $ROOT/src/main.py -s $SCNR -logging_config_file $ROOT/config_files/logging.conf
