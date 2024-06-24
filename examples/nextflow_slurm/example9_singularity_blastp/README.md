# Purpose

This example demonstrates how to use Nextflow and Slurm to run blast using Singularity container.

Inspired by: https://pawseysc.github.io/singularity-containers/13-bio-example-host/index.html




# Convert BLAST OCI image to Singularity

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

[1] Update yml config file for the inputs
EXPANSEPROJECT='YOUR_PROJECT_NAME_ON_EXPANSE'
sed -i "s|<<EXPANSEPROJECT>>|${EXPANSEPROJECT}|g" nextflow.config 


sed -i "s|<<EXPANSEPROJECT>>|${EXPANSEPROJECT}|g" config.yml 
sed -i "s|<<USER>>|${USER}|g" config.yml 


sed -i "s|<<EXPANSEPROJECT>>|${EXPANSEPROJECT}|g" nextflow_blast.sb



[2] Run:
sbatch nextflow_blast.sb

[3] Check the status of your job:

squeue --me

[4] Read output from the folder


```
