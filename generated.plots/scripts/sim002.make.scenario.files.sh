#!/bin/bash
# This script makes use of csvtk, downloadable at: https://bioinf.shenwei.me/csvtk/
# https://www.linux.com/training-tutorials/writing-simple-bash-script/
# http://tldp.org/LDP/Bash-Beginners-Guide/html/
# https://bash.cyberciti.biz/guide/For_loop
# argument passed to the script is the number of files you want to be created ($1)
# go to the folder when the files will be cretated, based upon template.json
CurrentDir=$(pwd)
cd /home/uva_iufor_1/COMUNES/simanfor/scenario/simul/sim002
#ls
if [ $#=1  ] 
	then n=$1 
	else n=20 
fi
echo $n "files will be created"
i=1
while [ $i -le $n ]; do
	filename=scnr_sp999_${i}_10-60.json
	sed -e "s/_idnumber_/${i}/g" ~/scripts/sim002.template.json > ${filename}
	echo $filename
	((i++))
done
#ls
cd $CurrentDir
