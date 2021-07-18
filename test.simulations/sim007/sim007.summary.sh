#!/bin/bash
# numero de cores que serán reservados
#SBATCH -n 1
# particion en donde se ejecutara el trabajo
#SBATCH -p haswell
# limites que se aplicaran al trabajo
#SBATCH -q normal
# nombre
#SBATCH -J compile_simul_sim007
# tiempo maximo de ejecucion (p.e. 2 dias). Maximo permitido: 5 dias
#SBATCH --time=53:00:00
# archivos de salida y de error
#SBATCH -o compile_simul_sim007.o
#SBATCH -e compile_simul_sim007.e
# directorio de trabajo por defecto
#SBATCH -D .
# notificaciones por email relacionadas con la ejecucion del trabajo
#SBATCH --mail-user=angelcristobal.ordonez@uva.es
#SBATCH --mail-type=ALL

ROOT=/home/uva_iufor_1/uva_iufor_1_3/simanfor/scripts

# carga de las variables necesarias para usar Python 3.7.7
module load python_3.7.7

# ejecution of simulator
python $ROOT/resumeCSVs.py sim007 450 16
