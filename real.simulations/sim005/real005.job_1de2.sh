#!/bin/bash
# numero de cores que serán reservados
#SBATCH -n 1
# particion en donde se ejecutara el trabajo
#SBATCH -p haswell
# limites que se aplicaran al trabajo
#SBATCH -q normal
# nombre
#SBATCH -J sm4_simul_pp_at_real005-part1
# tiempo maximo de ejecucion (p.e. 2 dias). Maximo permitido: 5 dias
#SBATCH --time=120:00:00
# archivos de salida y de error
#SBATCH -o files.o/sm4_simul_pp_at_real005-part1_%A_%a.o
#SBATCH -e files.e/sm4_simul_pp_at_real005-part1_%A_%a.e
# directorio de trabajo por defecto
#SBATCH -D .
# notificaciones por email relacionadas con la ejecucion del trabajo
#SBATCH --mail-user=aitor.vazquez.veloso@uva.es
#SBATCH --mail-type=ALL
#SBATCH --array=1-29998


# ejecución de las simulaciones de Pinus pinaster atlantica (costa e interior) - parte 1 de 2

ROOT=/home/uva_iufor_1/uva_iufor_1_2/simulator/simulator  # ruta de la carpeta simulator (anterior a src) dentro del simulador
SCNR=/scratch/uva_iufor_1/uva_iufor_1_2/real005/scenario/part_1/scnr_ppat_${SLURM_ARRAY_TASK_ID}.json  # ruta donde se encuentran los escenarios dentro del HPC
																		# ${SLURM_ARRAY_TASK_ID} es la variable que recorre todos los escenarios en orden
# carga de las variables necesarias para usar Python 3.7.7
module load python_3.7.7
# ejecution of simulator
python $ROOT/src/main.py -s $SCNR -logging_config_file $ROOT/config_files/logging.conf  # orden para ejecutar el simulador en el HPC
