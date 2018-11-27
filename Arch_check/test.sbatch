#!/bin/bash -l

#SBATCH -t 00:05:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --mem=500M


# Using Cray based machine (Sisu)
#aprun ./hello_asm

# Using Taito
#srun ./hello_asm
