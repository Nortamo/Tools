#!/bin/bash -l

#SBATCH -t 00:05:00
#SBATCH -N 1
#SBATCH -n 2
#SBATCH -p test
#SBATCH -c 2
#SBATCH --mem=5G

#as -a --gstabs -o x.o x.s
#ld -o x x.o
#aprun -n 2 ./x
aprun -n 2 ./a.out
