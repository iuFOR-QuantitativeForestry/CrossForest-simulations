#!/bin/bash
# numero de cores que serán reservados
#SBATCH -n 1
# particion en donde se ejecutara el trabajo
#SBATCH -p haswell
# limites que se aplicaran al trabajo
#SBATCH -q normal
# nombre
#SBATCH -J RScrpt.Plot.Generator.sim007
# tiempo maximo de ejecucion (p.e. 2 dias). Maximo permitido: 5 dias
#SBATCH --time=02:00:00
# archivos de salida y de error
#SBATCH -o RScrpt.Plot.Generator.sim007-%j.o
#SBATCH -e RScrpt.Plot.Generator.sim007-%j.e
# directorio de trabajo por defecto
#SBATCH -D .
# notificaciones por email relacionadas con la ejecucion del trabajo
#SBATCH --mail-user=angelcristobal.ordonez@uva.es
#SBATCH --mail-type=ALL
SCR_Dir=~/scripts
OUT_Dir=/scratch/uva_iufor_1/uva_iufor_1_3/sim007/input
# argument passed to the script is the number of files you want to be created ($1), and the number of plot by file ($2), and the number of trees per plot ($3) ...
if [ $# -eq 3 ]; then       nt=$3; np=$2; nf=$1
  elif [ $# -eq 2 ]; then   nt=100; np=$2; nf=$1
    elif [ $# -eq 1 ]; then nt=100; np=80;  nf=$1 
      else                  nt=100; np=5;  nf=200
fi
echo $nf "files will be created"
echo $np "plots per files"
echo $nt "trees per plot"
# carga de las variables necesarias para usar R
## module load /soft/calendula2/modulefiles/haswell/R_3.6.3
module load haswell/R_3.6.3 
CurrentDir=$(pwd)
cd $OUT_Dir
# ejecution of R script to build excel input files
i=1
while [ $i -le $nf ]; do
    $SCR_Dir/PlotsGenerator.R id.file=$i sp=999 n.p=$np n.t=$nt age0=25 ht.m=12 dbh.m=11 tph=1111 var.d=4 var.h=2
    ((i++))
done
cd $CurrentDir
