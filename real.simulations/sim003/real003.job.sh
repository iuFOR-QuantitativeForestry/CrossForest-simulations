#!/bin/bash
# numero de cores que serán reservados
#SBATCH -n 1
# particion en donde se ejecutara el trabajo
#SBATCH -p haswell
# limites que se aplicaran al trabajo
#SBATCH -q normal
# nombre
#SBATCH -J sm4_simul_pure_cat_real003-from1to41
# tiempo maximo de ejecucion (p.e. 2 dias). Maximo permitido: 5 dias
#SBATCH --time=120:00:00
# archivos de salida y de error
#SBATCH -o sm4_simul_pure_cat_real003-from1to41_%A_%a.o
#SBATCH -e sm4_simul_pure_cat_real003-from1to41_%A_%a.e
# directorio de trabajo por defecto
#SBATCH -D .
# notificaciones por email relacionadas con la ejecucion del trabajo
#SBATCH --mail-user=angelcristobal.ordonez@uva.es
#SBATCH --mail-type=ALL
#SBATCH --array=1-41

if [ $# -eq 1 ]; then scenario=$1 
      else scenario=_E1
fi

ROOT=/home/uva_iufor_1/uva_iufor_1_3/simanfor/simulator
SCNR=/scratch/uva_iufor_1/uva_iufor_1_3/real/real003/scenario/scnr_pure_cat${scenario}_${SLURM_ARRAY_TASK_ID}_.json
# carga de las variables necesarias para usar Python 3.7.7
module load python_3.7.7
# ejecution of simulator
python $ROOT/src/main.py -s $SCNR -logging_config_file $ROOT/config_files/logging.conf
