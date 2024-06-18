# Purpose

Very simple example
Output files are stored in:  cd /home/$USER/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example1_out

# Before launching


**Note:** Replace `sds196` with your actual project name in the following line of the env-slurm.sb script:
```bash
#SBATCH -A sds196

1. Replace sds196 in partition in nextflow.config with the appropriate value for your  access configuration.

```

## How to launch 

```

# Checking your environment on HPC node:


[1] Run:
EXPANSEPROJECT='sds196'
sed -i "s|<<EXPANSEPROJECT>>|${EXPANSEPROJECT}|g" nextflow.config
sbatch nextflow_test.sb 


[2] Check the status of your job:

squeue --me

[3] Read output from the folder


```
