# Purpose

This example demonstrates how to use Nextflow and Slurm to run blast using Singularity container.

Inspired by: https://pawseysc.github.io/singularity-containers/13-bio-example-host/index.html

Output files are stored in:  cd /home/$USER/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example9_out


# Before launching


**Note:** Replace `sds196` with your actual project name in the following line of the env-slurm.sb script:
```bash
#SBATCH -A sds196

1. Replace sds196 in partition in nextflow.config with the appropriate value for your  access configuration.
2. Replace params.cluster_user with your specific user value.

```

# Convert Gromacs OCI image to Singularity

```

# On your local machine
mkdir ~/a/c_images
cd ~/a/c_images
mkdir -p /tmp/$USER

export SINGULARITY_TMPDIR=/tmp/$USER
env | grep TMP


# Pull image
singularity pull docker://quay.io/biocontainers/blast:2.9.0--pl526h3066fca_4


# Test if sif image works 
singularity shell blast_2.9.0--pl526h3066fca_4.sif
blastp -help


# Copy sif image to SDSC Expanse
mkdir -p ~/a/c_images
scp blast_2.9.0--pl526h3066fca_4.sif  <username>@login.expanse.sdsc.edu:/home/<username>/a/c_images


# Test on SDSC expanse
module purge
module load singularitypro/3.11
cd ~/a/c_images
singularity shell blast_2.9.0--pl526h3066fca_4.sif
blastp -help
```


# prep on SDSC expanse login node
```
mkdir -p ~/a/demos/{blast,blast_db}
cd  ~/a/demos/blast_db
curl -O ftp://ftp.ncbi.nih.gov/refseq/M_musculus/mRNA_Prot/mouse.1.protein.faa.gz
curl -O ftp://ftp.ncbi.nih.gov/refseq/M_musculus/mRNA_Prot/mouse.2.protein.faa.gz
curl -O ftp://ftp.ncbi.nih.gov/refseq/M_musculus/mRNA_Prot/mouse.3.protein.faa.gz

curl -O ftp://ftp.ncbi.nih.gov/refseq/D_rerio/mRNA_Prot/zebrafish.1.protein.faa.gz
gunzip *.gz

cd  ~/a/demos/blast
wget https://rest.uniprot.org/uniprotkb/P04156.fasta



```


## How to launch 

```
# Checking your environment on HPC node:

[1] Load module file(s) into the shell environment
module purge
module load cpu/0.15.4
module load gpu/0.15.4
module load slurm
module load anaconda3/2020.11
module load singularitypro/3.11
eval "$(conda shell.bash hook)"


[2] Run:

conda activate /home/$USER/a/conda_envs/nextflow
sbatch nextflow_blast.sb

[3] Check the status of your job:

squeue --me

[4] Read output from the folder


```
