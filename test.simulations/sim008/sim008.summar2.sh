#!/bin/bash
# numero de cores que serán reservados
#SBATCH -n 1
# particion en donde se ejecutara el trabajo
#SBATCH -p haswell
# limites que se aplicaran al trabajo
#SBATCH -q normal
# nombre
#SBATCH -J compile_simul_sim008_cat
# tiempo maximo de ejecucion (p.e. 2 dias). Maximo permitido: 5 dias
#SBATCH --time=33:00:00
# archivos de salida y de error
#SBATCH -o compile_simul_sim008.o
#SBATCH -e compile_simul_sim008.e
# directorio de trabajo por defecto
#SBATCH -D .
# notificaciones por email relacionadas con la ejecucion del trabajo
#SBATCH --mail-user=angelcristobal.ordonez@uva.es
#SBATCH --mail-type=ALL

ROOT=/home/uva_iufor_1/uva_iufor_1_3/simanfor/scripts
ACTDIR=pwd
cd /scratch/uva_iufor_1/uva_iufor_1_3/sim008/output.summary
cat *.csv ../sim008.plot.csv
cd $ACTDIR
# carga de las variables necesarias para usar Python 3.7.7
# module load python_3.7.7

# ejecution of simulator
# python $ROOT/unify2csv.py 
