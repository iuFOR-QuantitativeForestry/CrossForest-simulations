#!/bin/bash
## make folders

OUT_Dir=/scratch/uva_iufor_1/uva_iufor_1_3/sim002
if [ ! -d "$OUT_Dir" ]; then mkdir $OUT_Dir; fi
folders=("/input" "/scenario" "/output")
for folder in ${folders[@]}
do
    i_Dir=${OUT_Dir}${folder}
    if [ ! -d "$i_Dir" ]; then mkdir $i_Dir; fi
done
## permiso de ejecucion para los archivos
chmod 744 ~/scripts/sim002.*
## make input files
n=20 
## sbatch ~/scripts/sim002.make.input.hpc.sh 20 20 100
## make scenario files
CurrentDir=$(pwd)
cd $OUT_Dir/scenario
i=1
while [ $i -le $n ]; do
	filename=scnr_sp999_${i}_20-100.json
	sed -e "s/_idnumber_/${i}/g" ~/scripts/sim002.template.json > ${filename}
	echo $filename
	((i++))
done
cd $CurrentDir
## make simulations
sbatch ~/scripts/sim002.job.test.sh 
##sbatch ~/scripts/sim002.job.array.20-100.sh 
