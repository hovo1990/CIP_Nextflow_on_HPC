# How to launch 



**Note:** Replace `sds196` with your actual project name in the following line of the env-slurm.sb script:
```bash
#SBATCH -A sds196



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