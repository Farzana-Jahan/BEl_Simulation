#!/usr/bin/env bash

#PBS -N BEL-mixPorter100
#PBS -l ncpus=3
#PBS -l mem=100GB
#PBS -l walltime=50:00:00
#PBS -l cpuarch=avx2
#PBS -o BEL-mixPorter100_stdout.out
#PBS -e BEL-mixPorter100_stderr.out

# More info on PBS directives can be found here
# http://qcd.phys.cmu.edu/QCDcluster/pbs/run_serial.html

###############################################
#
#
#  Display PBS info
#
#
###############################################
print_pbs_info(){
  echo ------------------------------------------------------
    echo -n 'Job is running on node '; cat $PBS_NODEFILE
  echo ------------------------------------------------------
    echo PBS: qsub is running on $PBS_O_HOST
  echo PBS: originating queue is $PBS_O_QUEUE
  echo PBS: executing queue is $PBS_QUEUE
  echo PBS: working directory is $PBS_O_WORKDIR
  echo PBS: execution mode is $PBS_ENVIRONMENT
  echo PBS: job identifier is $PBS_JOBID
  echo PBS: job name is $PBS_JOBNAME
  echo PBS: node file is $PBS_NODEFILE
  echo PBS: current home directory is $PBS_O_HOME
  echo PBS: PATH = $PBS_O_PATH
  echo ------------------------------------------------------
}

###############################################
#
#
#  Helper/Setup Functions
#
#
###############################################

load_modules(){
  #activate module environment
  #NOTE: a recent HPC update means that you shouldn't need
  #to do this anymore, but I have included as a sanity check
  source /etc/profile.d/modules.sh
  
  #load R
  module load atg/R/3.4.1-foss-2016a
}


copy_in(){
  #copy some data to  your input directory
  #nothing to copy in on this script
  #For empty bash functions, must put a colon in them,
  #otherwise it will throw an error
  :
}


copy_out(){
  #nothing to copy out on this script
  #For empty bash functions, must put a colon in them,
  #otherwise it will throw an error
  :
}



run_program(){
  #make sure we change to the current directory
  #where this bash job script is
  cd $PBS_O_WORKDIR
  Rscript "Rscripts/mix_BSHEL_100.R" 
  #this script installed all of the packages locally,
  #since you do not have root access to HPC.
  #This just means we need to let R now where we installed
  #the new packages. This next command will save the variable
  #in an R envirionment file to tell us where it is stored
  #echo 'R_LIBS_USER="~/R/library"' >  ~/.Renviron
  
}


run_clean(){
  #nothing to clean for this script
  #For empty bash functions, must put a colon in them,
  #otherwise it will throw an error
  :
}

###############################################
#
#
#  Running everything
#
#
###############################################

print_pbs_info
load_modules
copy_in
copy_out
run_program
run_clean
