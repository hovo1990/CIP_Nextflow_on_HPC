# How to launch this




Modify this line #SBATCH -A sds196 to match your project name in env-slurm.sb script


```
# Checking your environment on HPC node:

[1] Load module file(s) into the shell environment
module purge
module load cpu/0.15.4
module load gcc
module load mvapich2
module load slurm

[2] Run:

sbatch env-slurm.sb
```