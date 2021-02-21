# sim001
100 plots, 10 array = 10 input files, 10 ppf (plots per file), 60 tpp (trees per plot)

## make input files
10 files with 10 plot each, 60 trees per plot 
folder: /COMUNES/simanfor/data/simul/sim001/
command in HPC: 
          ----> sbatch ~/scripts/sim001.make.input.hpc.sh 10 10 60
which do 10 call to R-script sim001.PlotsGenerator.EN.hpc.R

## make scenario files
command in HPC: 
          ----> ~/scripts/sim001.make.scenario.files.sh 10
put files in /COMUNES/simanfor/scenario/simul/sim001 from template.json
### put 10 files in  /home/uva_iufor_1/COMUNES/simanfor/scenario/simul/sim001
### filename: scnr_sp999_${i}_10-60.json
### each file change input and output files (with _idnumber_ from 1 to 10): 
#### "output_path": "/home/uva_iufor_1/COMUNES/simanfor/output/simul/sim001/out__idnumber__10-60",
#### "input": "/home/uva_iufor_1/COMUNES/simanfor/data/simul/sim001/input.en__idnumber_.10.60sp999.xlsx"
scenario files run two growth periods, 5 years each and perform a thinning

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim001.job.array.10-60.sh 
which do 10 array jobs for 10 scenario files: scnr_sp999_${i}_10-60.json

## summary from HPC
#------------
calendula Slurm Job_id=488659 Name=RScript_uva Ended, Run time 00:00:22, COMPLETED, ExitCode 0
20/10/20 23:01
#------------
Job ID: 488659
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:00:09
CPU Efficiency: 40.91% of 00:00:22 core-walltime
Job Wall-clock time: 00:00:22
Memory Utilized: 1.00 MB
Memory Efficiency: 0.05% of 1.89 GB
#------------
calendula Slurm Array Summary Job_id=488715_* (488715) Name=python_uva Ended, COMPLETED, ExitCode [0-0]
21/10/20 10:29
#------------
Job ID: 488715
Array Job ID: 488715_10
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:03:35
CPU Efficiency: 74.91% of 00:04:47 core-walltime
Job Wall-clock time: 00:04:47
Memory Utilized: 123.11 MB
Memory Efficiency: 6.36% of 1.89 GB
#------------



# sim002
400 plots, 20 array = 20 input files, 20 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim002.sh

## make scenario files
command in HPC: 
          ----> ~/scripts/sim002.makeScenarioFiles.sh 20
put files in /COMUNES/simanfor/scenario/simul/sim002 from template.json
### put 20 files in  /home/uva_iufor_1/COMUNES/simanfor/scenario/simul/sim002
### filename: scnr_sp999_${i}_20-100.json
### each file change input and output files (with _idnumber_ from 1 to 20): 
#### "output_path": "/home/uva_iufor_1/COMUNES/simanfor/output/simul/sim002/out__idnumber__20-100",
#### "input": "/home/uva_iufor_1/COMUNES/simanfor/data/simul/sim002/input.en__idnumber_.20.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
20 files with 20 plot each, 100 trees per plot 
folder: /COMUNES/simanfor/data/simul/sim002/
command in HPC: 
          ----> sbatch ~/scripts/sim002.make.input.hpc.sh 20 20 100
which do 20 call to R-script sim002.PlotsGenerator.EN.hpc.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim002.JobArray_20-100.sh 
which do 20 array jobs for 20 scenario files: scnr_sp999_${i}_20-100.json

## summary from HPC
#------------
calendula Slurm Job_id=489863 Name=RScript_uva Ended, Run time 00:00:39, COMPLETED, ExitCode 0
25/10/20 0:21
#------------
Job ID: 489863
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:00:25
CPU Efficiency: 64.10% of 00:00:39 core-walltime
Job Wall-clock time: 00:00:39
Memory Utilized: 65.96 MB
Memory Efficiency: 3.41% of 1.89 GB
#------------
calendula Slurm Array Summary Job_id=489904_* (489904) Name=sm4_simul_sim002 Ended, COMPLETED, ExitCode [0-0]
25/10/20 1:40
#------------
Job ID: 489904
Array Job ID: 489904_20
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:53:19
CPU Efficiency: 98.98% of 00:53:52 core-walltime
Job Wall-clock time: 00:53:52
Memory Utilized: 693.74 MB
Memory Efficiency: 35.83% of 1.89 GB
#------------








# sim003
## description
400 plots, 4 array = 4 input files, 100 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim003.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim003.makeScenarioFiles.sh 4
put files in $SCRACH/sim003/scenario from template.json
### put 4 files in  $SCRACH/sim003/scenario
### filename: scnr_sp999_${i}_100-100.json
### each file change input and output files (with _idnumber_ from 1 to 4): 
#### "output_path": "$SCRACH/sim003/out__idnumber__20-100",
#### "input": "$SCRACH/sim003/input.en__idnumber_.100.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
4 files with 100 plot each, 100 trees per plot 
folder: $SCRACH/sim003/
command in HPC: 
          ----> sbatch ~/scripts/sim003.make.input.hpc.sh 4 100 100
which do 4 call to R-script sim003.PlotsGenerator.EN.hpc.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim003.JobArray_100-100.sh 
which do 4 array jobs for 4 scenario files: scnr_sp999_${i}_100-100.json

## summary from HPC
#------------
calendula Slurm Job_id=491177 Name=RScript_uva Ended, Run time 00:00:11, COMPLETED, ExitCode 0
2/11/20 14:33
#------------
Job ID: 491177
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:00:10
CPU Efficiency: 90.91% of 00:00:11 core-walltime
Job Wall-clock time: 00:00:11
Memory Utilized: 1020.00 KB
Memory Efficiency: 0.05% of 1.89 GB

Este es un mensaje automatico. Por favor, no responda a este correo.
This is an automatic email. Please, do not reply to this mail.

------------------------
HPC SCAYLE
www.scayle.es
#------------
calendula Slurm Array Summary Job_id=491221_* (491221) Name=sm4_simul_sim002 Ended, Mixed, MaxSignal [9]
3/11/20 0:28
#------------
Job ID: 491221
Array Job ID: 491221_4
Cluster: calendula
User/Group: uva_iufor_1_3/uva_iufor_1
State: TIMEOUT (exit code 0)
Cores: 1
CPU Utilized: 00:59:36
CPU Efficiency: 98.73% of 01:00:22 core-walltime
Job Wall-clock time: 01:00:22
Memory Utilized: 1.58 GB
Memory Efficiency: 83.83% of 1.89 GB

Este es un mensaje automatico. Por favor, no responda a este correo.
This is an automatic email. Please, do not reply to this mail.
------------------------
HPC SCAYLE
www.scayle.es
#------------





# sim004
## description
400 plots, 5 array = 5 input files, 80 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim004.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim004.makeScenarioFiles.sh 5
put files in $SCRACH/sim004/scenario from template.json
### put 5 files in  $SCRACH/sim004/scenario
### filename: scnr_sp999_${i}_80-100.json
### each file change input and output files (with _idnumber_ from 1 to 5): 
#### "output_path": "$SCRACH/sim004/out__idnumber__80-100",
#### "input": "$SCRACH/sim004/input.en__idnumber_.80.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
5 files with 80 plot each, 100 trees per plot 
folder: $SCRACH/sim004/
command in HPC: 
          ----> sbatch ~/scripts/sim004.make.input.hpc.sh 5 80 100
which do 5 call to R-script sim004.PlotsGenerator.EN.hpc.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim004.JobArray_80-100.sh 
which do 5 array jobs for 5 scenario files: scnr_sp999_${i}_80-100.json

## summary from HPC
#------------

#------------

#------------

#------------






# sim005
## description
400 plots, 40 array = 40 input files, 10 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim005.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim005.makeScenarioFiles.sh 40
put files in $SCRACH/sim005/scenario from template.json
### put 40 files in  $SCRACH/sim005/scenario
### filename: scnr_sp999_${i}_10-100.json
### each file change input and output files (with _idnumber_ from 1 to 40): 
#### "output_path": "$SCRACH/sim005/out__idnumber__10-100",
#### "input": "$SCRACH/sim005/input.en__idnumber_.10.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
40 files with 10 plot each, 100 trees per plot 
folder: $SCRACH/sim005/
command in HPC: 
          ----> sbatch ~/scripts/sim005.make.input.hpc.sh 40 10 100
which do 40 call to R-script sim004.PlotsGenerator.EN.hpc.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim005.JobArray_10-100.sh 
which do 40 array jobs for 40 scenario files: scnr_sp999_${i}_10-100.json

## summary from HPC
#------------

#------------

#------------

#------------






# sim005
## description
400 plots, 4 array = 4 input files, 100 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim003.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim003.makeScenarioFiles.sh 4
put files in $SCRACH/sim003/scenario from template.json
### put 4 files in  $SCRACH/sim003/scenario
### filename: scnr_sp999_${i}_100-100.json
### each file change input and output files (with _idnumber_ from 1 to 4): 
#### "output_path": "$SCRACH/sim003/out__idnumber__20-100",
#### "input": "$SCRACH/sim003/input.en__idnumber_.100.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
4 files with 100 plot each, 100 trees per plot 
folder: $SCRACH/sim003/
command in HPC: 
          ----> sbatch ~/scripts/sim003.make.input.hpc.sh 4 100 100
which do 4 call to R-script sim003.PlotsGenerator.EN.hpc.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim003.JobArray_100-100.sh 
which do 4 array jobs for 4 scenario files: scnr_sp999_${i}_100-100.json

## summary from HPC
#------------

#------------

#------------

#------------






# sim005
## description
400 plots, 4 array = 4 input files, 100 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim003.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim003.makeScenarioFiles.sh 4
put files in $SCRACH/sim003/scenario from template.json
### put 4 files in  $SCRACH/sim003/scenario
### filename: scnr_sp999_${i}_100-100.json
### each file change input and output files (with _idnumber_ from 1 to 4): 
#### "output_path": "$SCRACH/sim003/out__idnumber__20-100",
#### "input": "$SCRACH/sim003/input.en__idnumber_.100.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
4 files with 100 plot each, 100 trees per plot 
folder: $SCRACH/sim003/
command in HPC: 
          ----> sbatch ~/scripts/sim003.make.input.hpc.sh 4 100 100
which do 4 call to R-script sim003.PlotsGenerator.EN.hpc.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim003.JobArray_100-100.sh 
which do 4 array jobs for 4 scenario files: scnr_sp999_${i}_100-100.json

## summary from HPC
#------------

#------------

#------------

#------------






# sim005
## description
400 plots, 4 array = 4 input files, 100 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim003.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim003.makeScenarioFiles.sh 4
put files in $SCRACH/sim003/scenario from template.json
### put 4 files in  $SCRACH/sim003/scenario
### filename: scnr_sp999_${i}_100-100.json
### each file change input and output files (with _idnumber_ from 1 to 4): 
#### "output_path": "$SCRACH/sim003/out__idnumber__20-100",
#### "input": "$SCRACH/sim003/input.en__idnumber_.100.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
4 files with 100 plot each, 100 trees per plot 
folder: $SCRACH/sim003/
command in HPC: 
          ----> sbatch ~/scripts/sim003.make.input.hpc.sh 4 100 100
which do 4 call to R-script sim003.PlotsGenerator.EN.hpc.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim003.JobArray_100-100.sh 
which do 4 array jobs for 4 scenario files: scnr_sp999_${i}_100-100.json

## summary from HPC
#------------

#------------

#------------

#------------






# sim005
## description
400 plots, 4 array = 4 input files, 100 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim003.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim003.makeScenarioFiles.sh 4
put files in $SCRACH/sim003/scenario from template.json
### put 4 files in  $SCRACH/sim003/scenario
### filename: scnr_sp999_${i}_100-100.json
### each file change input and output files (with _idnumber_ from 1 to 4): 
#### "output_path": "$SCRACH/sim003/out__idnumber__20-100",
#### "input": "$SCRACH/sim003/input.en__idnumber_.100.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
4 files with 100 plot each, 100 trees per plot 
folder: $SCRACH/sim003/
command in HPC: 
          ----> sbatch ~/scripts/sim003.make.input.hpc.sh 4 100 100
which do 4 call to R-script sim003.PlotsGenerator.EN.hpc.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim003.JobArray_100-100.sh 
which do 4 array jobs for 4 scenario files: scnr_sp999_${i}_100-100.json

## summary from HPC
#------------

#------------

#------------

#------------






# sim005
## description
400 plots, 4 array = 4 input files, 100 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim003.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim003.makeScenarioFiles.sh 4
put files in $SCRACH/sim003/scenario from template.json
### put 4 files in  $SCRACH/sim003/scenario
### filename: scnr_sp999_${i}_100-100.json
### each file change input and output files (with _idnumber_ from 1 to 4): 
#### "output_path": "$SCRACH/sim003/out__idnumber__20-100",
#### "input": "$SCRACH/sim003/input.en__idnumber_.100.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
4 files with 100 plot each, 100 trees per plot 
folder: $SCRACH/sim003/
command in HPC: 
          ----> sbatch ~/scripts/sim003.make.input.hpc.sh 4 100 100
which do 4 call to R-script sim003.PlotsGenerator.EN.hpc.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim003.JobArray_100-100.sh 
which do 4 array jobs for 4 scenario files: scnr_sp999_${i}_100-100.json

## summary from HPC
#------------

#------------

#------------

#------------






# sim005
## description
400 plots, 4 array = 4 input files, 100 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim003.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim003.makeScenarioFiles.sh 4
put files in $SCRACH/sim003/scenario from template.json
### put 4 files in  $SCRACH/sim003/scenario
### filename: scnr_sp999_${i}_100-100.json
### each file change input and output files (with _idnumber_ from 1 to 4): 
#### "output_path": "$SCRACH/sim003/out__idnumber__20-100",
#### "input": "$SCRACH/sim003/input.en__idnumber_.100.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
4 files with 100 plot each, 100 trees per plot 
folder: $SCRACH/sim003/
command in HPC: 
          ----> sbatch ~/scripts/sim003.make.input.hpc.sh 4 100 100
which do 4 call to R-script sim003.PlotsGenerator.EN.hpc.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim003.JobArray_100-100.sh 
which do 4 array jobs for 4 scenario files: scnr_sp999_${i}_100-100.json

## summary from HPC
#------------

#------------

#------------

#------------






# sim005
## description
400 plots, 4 array = 4 input files, 100 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim003.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim003.makeScenarioFiles.sh 4
put files in $SCRACH/sim003/scenario from template.json
### put 4 files in  $SCRACH/sim003/scenario
### filename: scnr_sp999_${i}_100-100.json
### each file change input and output files (with _idnumber_ from 1 to 4): 
#### "output_path": "$SCRACH/sim003/out__idnumber__20-100",
#### "input": "$SCRACH/sim003/input.en__idnumber_.100.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
4 files with 100 plot each, 100 trees per plot 
folder: $SCRACH/sim003/
command in HPC: 
          ----> sbatch ~/scripts/sim003.make.input.hpc.sh 4 100 100
which do 4 call to R-script sim003.PlotsGenerator.EN.hpc.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim003.JobArray_100-100.sh 
which do 4 array jobs for 4 scenario files: scnr_sp999_${i}_100-100.json

## summary from HPC
#------------

#------------

#------------

#------------






# sim005
## description
400 plots, 4 array = 4 input files, 100 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim003.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim003.makeScenarioFiles.sh 4
put files in $SCRACH/sim003/scenario from template.json
### put 4 files in  $SCRACH/sim003/scenario
### filename: scnr_sp999_${i}_100-100.json
### each file change input and output files (with _idnumber_ from 1 to 4): 
#### "output_path": "$SCRACH/sim003/out__idnumber__20-100",
#### "input": "$SCRACH/sim003/input.en__idnumber_.100.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
4 files with 100 plot each, 100 trees per plot 
folder: $SCRACH/sim003/
command in HPC: 
          ----> sbatch ~/scripts/sim003.make.input.hpc.sh 4 100 100
which do 4 call to R-script sim003.PlotsGenerator.EN.hpc.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim003.JobArray_100-100.sh 
which do 4 array jobs for 4 scenario files: scnr_sp999_${i}_100-100.json

## summary from HPC
#------------

#------------

#------------

#------------






# sim005
## description
400 plots, 4 array = 4 input files, 100 ppf, 100 tpp

## make folders and run other scripts
command in HPC: 
          ----> ~/scripts/sim003.sh
this script run everything but the array jobs
## make scenario files
command in HPC: 
          ----> ~/scripts/sim003.makeScenarioFiles.sh 4
put files in $SCRACH/sim003/scenario from template.json
### put 4 files in  $SCRACH/sim003/scenario
### filename: scnr_sp999_${i}_100-100.json
### each file change input and output files (with _idnumber_ from 1 to 4): 
#### "output_path": "$SCRACH/sim003/out__idnumber__20-100",
#### "input": "$SCRACH/sim003/input.en__idnumber_.100.100sp999.xlsx"
scenario files run tweenty growth periods, 5 years each and perform a thinning after ten growths

## make input files
4 files with 100 plot each, 100 trees per plot 
folder: $SCRACH/sim003/
command in HPC: 
          ----> sbatch ~/scripts/sim003.make.input.hpc.sh 4 100 100
which do 4 call to R-script sim003.PlotsGenerator.EN.hpc.R

## make simulations
command in HPC: 
          ----> sbatch ~/scripts/sim003.JobArray_100-100.sh 
which do 4 array jobs for 4 scenario files: scnr_sp999_${i}_100-100.json

## summary from HPC
#------------

#------------

#------------

#------------
