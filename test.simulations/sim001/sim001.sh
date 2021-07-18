#!/bin/bash
## make folders

OUT_Dir=/scratch/uva_iufor_1/uva_iufor_1_3/sim001
if [ ! -d "$OUT_Dir" ]; then mkdir $OUT_Dir; fi
folders=("/input" "/scenario" "/output")
for folder in ${folders[@]}
do
    i_Dir=${OUT_Dir}${folder}
    if [ ! -d "$i_Dir" ]; then mkdir $i_Dir; fi
done
## permiso de ejecucion para los archivos
chmod 744 ~/scripts/sim001.*
n=10
## make input files
## sbatch ~/scripts/sim001.make.input.hpc.sh $n 10 60
## make scenario files
CurrentDir=$(pwd)
cd $OUT_Dir/scenario
i=1 
while [ $i -le $n ]; do
	filename=scnr_sp999_${i}_10-60.json
	sed -e "s/_idnumber_/${i}/g" ~/scripts/sim001.template.json > ${filename}
	echo $filename
	((i++))
done
cd $CurrentDir
## make simulations
sbatch ~/scripts/sim001.job.test.sh 
##sbatch ~/scripts/sim001.job.array.10-60.sh
