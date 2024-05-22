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
module load slurm
module load anaconda3/2020.11

[2] Run:

sbatch env-python-slurm.sb
```