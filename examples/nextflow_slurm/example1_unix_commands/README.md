# Purpose

Very simple example
Output files are stored in:  cd /home/$USER/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example1_out


## How to launch 

```

# Checking your environment on HPC node:
[1] Run:
EXPANSEPROJECT='YOUR_PROJECT_NAME_ON_EXPANSE'
sed -i "s|<<EXPANSEPROJECT>>|${EXPANSEPROJECT}|g" nextflow.config 
sed -i "s|<<EXPANSEPROJECT>>|${EXPANSEPROJECT}|g" nextflow_test.sb 
sbatch nextflow_test.sb 


[2] Check the status of your job:

squeue --me

[3] Read output from the folder


```
