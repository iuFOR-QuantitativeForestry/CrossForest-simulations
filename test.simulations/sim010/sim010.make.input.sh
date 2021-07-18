#!/bin/bash
# numero de cores que serán reservados
#SBATCH -n 1
# particion en donde se ejecutara el trabajo
#SBATCH -p haswell
# limites que se aplicaran al trabajo
#SBATCH -q normal
# nombre
#SBATCH -J Scrpt.Plot&Scenario.Generator
# tiempo maximo de ejecucion (p.e. 2 dias). Maximo permitido: 5 dias
#SBATCH --time=120:00:00
# archivos de salida y de error
#SBATCH -o Input.Generator.sim010-%j.o
#SBATCH -e Input.Generator.sim010-%j.e
# directorio de trabajo por defecto
#SBATCH -D .
# notificaciones por email relacionadas con la ejecucion del trabajo
#SBATCH --mail-user=angelcristobal.ordonez@uva.es
#SBATCH --mail-type=ALL

## make input files - the number as input or 30000 whether no input
# argument passed to the script is the number of files you want to be created ($1), and the number of plot by file ($2), and the number of trees per plot ($3) ...

if [ $# -eq 5 ]; then           nt=$3;  np=$2; nf=$1;    nf1=$4;  nf2=$5
  elif [ $# -eq 4 ]; then       nt=$3;  np=$2; nf=$1;    nf1=$4;  nf2=300
    elif [ $# -eq 3 ]; then     nt=$3;  np=$2; nf=$1;    nf1=300; nf2=300
      elif [ $# -eq 2 ]; then   nt=100; np=$2; nf=$1;    nf1=300; nf2=300
	elif [ $# -eq 1 ]; then nt=100; np=1;  nf=$1;    nf1=300; nf2=300
          else                  nt=100; np=4;  nf=22500; nf1=150; nf2=150
fi
## nf=$nf1*$nf2 se debe cumplir para que salgan nf ficheros
## echo $nf "files will be created"
## echo $np "plots per files"
## echo $nt "trees per plot"

SCR_Dir=~/simanfor/scripts
OUT_Dir=/scratch/uva_iufor_1/uva_iufor_1_3/sim010
if [ ! -d "$OUT_Dir" ]; then mkdir $OUT_Dir; fi
folders=("/input" "/scenario" "/output" "/output.summary")
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
for (( j = 1; j <= $((nf2)); j++ ))
do
    for (( i = 1; i<= $((nf1)); i++ ))
    do
	coorX=$((26200+(j-1)*690000/nf2))
	coorY=$((41600000+(i-1)*670000/nf1))
	plotId=$((i+(j-1)*nf1))
	$SCR_Dir/PlotsGenerator.R id.file=$plotId sp=999 n.p=$np n.t=$nt age0=25 ht.m=12 dbh.m=11 tph=1111 var.d=4 var.h=2 x=$coorX y=$coorY
	echo "file " $plotId "coor x " $coorX "coor y" $coorY "i " $i "j " $j
    done
done

cd $OUT_Dir/scenario
echo ${OUT_Dir}/scenario > ${CurrentDir}/scenarios.filenames
i=1
while [ $i -le $nf ]; do
	filename=scnr_sp999_${i}_4-100.json
	sed -e "s/_idnumber_/${i}/g" ~/simanfor/scripts/sim010.template.json > ${filename}
	echo $filename >> ${CurrentDir}/scenarios.filenames
	((i++))
done

cd $CurrentDir
