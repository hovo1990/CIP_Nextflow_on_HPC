# Purpose

Very simple example
Output files are stored in:  cd /home/$USER/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example1_out

# Before launching


**Note:** Replace `sds196` with your actual project name in the following line of the env-slurm.sb script:
```bash
#SBATCH -A sds196

1. Replace sds196 in partition in nextflow.config with the appropriate value for your  access configuration.
2. Replace params.cluster_user with your specific user value.

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

eval "$(conda shell.bash hook)"
conda activate /home/$USER/a/conda_envs/nextflow
sbatch nextflow_test.sb

[3] Check the status of your job:

squeue --me

[4] Read output from the folder


```
