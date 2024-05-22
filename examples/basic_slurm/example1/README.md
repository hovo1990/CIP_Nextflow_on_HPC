# Before launching



**Note:** Replace `sds196` with your actual project name in the following line of the env-slurm.sb script:
```bash
#SBATCH -A sds196
```

## How to launch 

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

[3] Check the status of your job:

squeue --me

[4] Read output:

less envinfo......

```