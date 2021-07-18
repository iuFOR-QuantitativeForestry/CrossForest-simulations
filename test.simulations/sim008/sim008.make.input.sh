#!/bin/bash
# numero de cores que serán reservados
#SBATCH -n 1
# particion en donde se ejecutara el trabajo
#SBATCH -p haswell
# limites que se aplicaran al trabajo
#SBATCH -q normal
# nombre
#SBATCH -J RScrpt.Plot.Generator
# tiempo maximo de ejecucion (p.e. 2 dias). Maximo permitido: 5 dias
#SBATCH --time=01:00:00
# archivos de salida y de error
#SBATCH -o RScrpt.Plot.Generator.sim008-%j.o
#SBATCH -e RScrpt.Plot.Generator.sim008-%j.e
# directorio de trabajo por defecto
#SBATCH -D .
# notificaciones por email relacionadas con la ejecucion del trabajo
#SBATCH --mail-user=angelcristobal.ordonez@uva.es
#SBATCH --mail-type=ALL

## make input files - the number as input or 5000 whether no input
# argument passed to the script is the number of files you want to be created ($1), and the number of plot by file ($2), and the number of trees per plot ($3) ...
if [ $# -eq 3 ]; then       nt=$3;  np=$2; nf=$1
  elif [ $# -eq 2 ]; then   nt=100; np=$2; nf=$1
    elif [ $# -eq 1 ]; then nt=100; np=5;  nf=$1
      else                  nt=100; np=5;  nf=5000
fi
## echo $nf "files will be created"
## echo $np "plots per files"
## echo $nt "trees per plot"

SCR_Dir=~/scripts
OUT_Dir=/scratch/uva_iufor_1/uva_iufor_1_3/sim008
if [ ! -d "$OUT_Dir" ]; then mkdir $OUT_Dir; fi
folders=("/input" "/scenario" "/output")
for folder in ${folders[@]}
do
    i_Dir=${OUT_Dir}${folder}
    if [ ! -d "$i_Dir" ]; then mkdir $i_Dir; fi
done

## carga de las variables necesarias para usar R
module load haswell/R_3.6.3
CurrentDir=$(pwd)
cd ${OUT_Dir}/input
# ejecution of R script to build excel input files
i=1
while [ $i -le $nf ]; do
    $SCR_Dir/PlotsGenerator.R id.file=$i sp=999 n.p=$np n.t=$nt age0=25 ht.m=12 dbh.m=11 tph=1111 var.d=4 var.h=2
    ((i++))
done

cd $OUT_Dir/scenario
echo ${OUT_Dir}/scenario > ${CurrentDir}/scenarios.filenames
i=1
while [ $i -le $nf ]; do
	filename=scnr_sp999_${i}_5-100.json
	sed -e "s/_idnumber_/${i}/g" ~/scripts/sim008.template.json > ${filename}
	echo $filename >> ${CurrentDir}/scenarios.filenames
	((i++))
done

cd $CurrentDir
