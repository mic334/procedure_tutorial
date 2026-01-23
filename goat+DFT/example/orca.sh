#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --account=CNHPC_1700031_0
#SBATCH -p dcgp_usr_prod            # DO NOT USE boost_usr_prod! ORCA HAS NO GPU SUPPORT[0m
#SBATCH --mem=4000MB              # up to  494000MB
#SBATCH --time=24:00:00
#SBATCH --error=orca_%j.err
#SBATCH --job-name=orca_test

ml profile/chem-phys
ml orca/6.0.0--gcc--12.2.0  

# export xtb dall mia home 
export XTBEXE=$HOME/xtb/xtb-6.6.1/bin/xtb
export PATH=$(dirname $XTBEXE):$PATH

# suppress no cuda error
export OMPI_MCA_opal_warn_on_missing_libcuda=0

INPUT='goat_water'

# in order to execute orca you need to use the absolute path !!!
$ORCA_HOME/bin/orca ${INPUT}.inp > ${INPUT}.out

rm -f ${INPUT}*tmp

