#!/bin/bash
# numero de cores que serán reservados
#SBATCH -n 1
# particion en donde se ejecutara el trabajo
#SBATCH -p haswell
# limites que se aplicaran al trabajo
#SBATCH -q normal
# nombre
#SBATCH -J Script.make.scenarios.real001
# tiempo maximo de ejecucion (p.e. 2 dias). Maximo permitido: 5 dias
#SBATCH --time=1:00:00
# archivos de salida y de error
#SBATCH -o Script.make.scenarios.real003-%j.o
#SBATCH -e Script.make.scenarios.real003-%j.e
# directorio de trabajo por defecto
#SBATCH -D .
# notificaciones por email relacionadas con la ejecucion del trabajo
#SBATCH --mail-user=angelcristobal.ordonez@uva.es
#SBATCH --mail-type=ALL

## argument passed to the script is the scenario type number ($1)
if [ $# -eq 1 ]; then scenario=$1 
      else scenario=_E1
fi

ROOT=/home/uva_iufor_1/uva_iufor_1_3/simanfor/scripts
OUT_Dir=/scratch/uva_iufor_1/uva_iufor_1_3/real/real003

CurrentDir=$(pwd)
cd $OUT_Dir

## create a list with the input files
## https://unix.stackexchange.com/questions/356385/loop-through-a-folder-and-list-files
## searchDir="*"
cd ./input/
inputlist=()
while IFS= read -r -d $'\0' foundFile; do
    inputlist+=("$foundFile")
done < <(find plot* -maxdepth 1 -type f -print0 2> /dev/null)
cd ..

## build scenario files for each itinerario

echo ${OUT_Dir}/scenario > ./templates/scenarios.filenames${scenario}

i=1
if [[ ${#inputlist[@]} -ne 0 ]]; then  ## checking for non empty list
    for inputfilename in "${inputlist[@]}"; do ## proccess every file in a for loop
	## https://www.baeldung.com/linux/bash-substring
	## echo ${inputfilename}
	species=${inputfilename:18:13}
	## echo ${species}
	## https://stackoverflow.com/questions/12152626/how-can-i-remove-the-extension-of-a-filename-in-a-shell-script
	## name=$(echo "$filename" | cut -f 1 -d '.')
	filename=$(echo "${inputfilename%.*}")
	filename=${filename#?????} ## REMOVES plot_ at the begining of the name
	echo ${filename}
	scenariofilename=scnr_pure_cat${scenario}_${i}_.json
	## echo ${scenariofilename}
	sed -e "s/_idfile_/${filename}/g" ./templates/${species}${scenario}.json > ./scenario/${scenariofilename}
	echo $scenariofilename >> ./templates/scenarios.filenames${scenario}
	((i++))
    done
fi

cd $CurrentDir
