#!/bin/bash

#SBATCH --job-name=wrf
#SBATCH --nodes=2-2
#SBATCH -n 96
#SBATCH --partition=sesempi
#SBATCH --time=6:00:00
#SBATCH --mem-per-cpu=1000
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=END
#SBATCH --mail-user=[your NetID]@illinois.edu

now=$(date +"%T")
echo "Start time : $now"
echo ${run}

source ~/.bashrc

#free the system to have unlimited memory requests

ulimit -s -S unlimited

#make permissions group readable on output files

umask 022

#load libraries that you compiled with – here I used the intel libraries

module purge
#module load intel/intel-15.0.3
#module load intel/netcdf3-4.7.4-intel-15.0.3
#module load intel/openmpi-3.1.6-intel-15.0.3

# UPDATE with your path to WRF
cd /data/where/you/have/wrf/test/em_real
# Make sure there is a copy of makekeelingloads.csh in your em_real directory
source makekeelingloads.csh

export MKL_DEBUG_CPU_TYPE=5
export MKL_CBWR=COMPATIBLE

time mpirun -np 24 ./real.exe

time mpirun -np 96 ./wrf.exe

now=$(date +"%T")
echo "End time : $now"
