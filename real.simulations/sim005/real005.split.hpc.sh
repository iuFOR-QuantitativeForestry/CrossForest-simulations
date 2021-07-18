#!/bin/bash
# numero de cores que serán reservados
#SBATCH -n 1
# particion en donde se ejecutara el trabajo
#SBATCH -p haswell
# limites que se aplicaran al trabajo
#SBATCH -q normal
# nombre
#SBATCH -J Python.Plot.split.real005
# tiempo maximo de ejecucion (p.e. 2 dias). Maximo permitido: 5 dias
#SBATCH --time=10:00:00
# archivos de salida y de error
#SBATCH -o Python.Plot.split.real005-%j.o
#SBATCH -e Python.Plot.split.real005-%j.e
# directorio de trabajo por defecto
#SBATCH -D .
# notificaciones por email relacionadas con la ejecucion del trabajo
#SBATCH --mail-user=aitor.vazquez.veloso@uva.es
#SBATCH --mail-type=ALL

# carga de las variables necesarias para usar Python 3.7.7
module load python_3.7.7

ROOT=/home/uva_iufor_1/uva_iufor_1_2/simanfor/scripts
OUT_Dir=/scratch/uva_iufor_1/uva_iufor_1_2/real005

CurrentDir=$(pwd)
cd $OUT_Dir
# ejecution of Python script to split excel file into individual files

python $ROOT/splitInputExcel2indPlots.py /scratch/uva_iufor_1/uva_iufor_1_2/real005/ Mix.xlsx xlsx

cd $CurrentDir
