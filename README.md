# 👋 Welcome to the Instructional Intro to Nextflow on HPC
This repository is designed to be an interactive introduction on how to use Nextflow on HPC within the CIP.



This intro assumes that you are familiar with a <a href="https://en.wikipedia.org/wiki/Linux" target="_blank">Linux Operating System</a> and are proficient in using Linux command line tools.


This tutorial was created with the San Diego Supercomputer Center's Expanse supercomputer in mind.


## ✔ Mission Objectives
After completing this introduction, you should:
1. Be able to run a simple Nextflow pipeline on HPC
2. How to use conda environments with Nextflow
3. How to use Nextflow with Singularity containers
4. Perform simple data analysis and visualizations 
5. Be able to use basic git commands

## Why Nextflow on HPC with Slurm?

- **Accessibility**: Nextflow abstracts the complexities of SLURM, making it more accessible and user-friendly.
- **Simplified Workflow Management**: Users can define and execute workflows using simple, high-level commands.
- **Efficient Execution**: Facilitates the efficient and scalable execution of complex data analysis pipelines.
- **No In-depth SLURM Knowledge Required**: Allows leveraging SLURM's powerful resource management capabilities without needing detailed knowledge of its configurations.
- **Optimized Resource Utilization**: Ensures optimal utilization of HPC resources by integrating workflow management with SLURM's job scheduling.
- **Enhanced Workflow Development**: Simplifies the overall workflow development and execution process.


## 0. How to use this repository



This repository contains a series of examples that demonstrate how to use Nextflow on HPC with SLURM.

To get started, navigate to the appropriate example directory and follow the instructions provided in the README file.


```
mkdir -p ~/a/
cd ~/a
git clone https://github.com/hovo1990/CIP_Nextflow_on_HPC.git
```


## 1. General Guide

[Very Basic Guide](basic_guide.md)


## 2. Nextflow setup on cluster

Unfortunately, there are instances where Nextflow is not available on the cluster and must be installed manually.

[Nextflow setup on cluster](nextflow_setup.md)

## 3. Before diving into Nextflow examples that utilize SLURM, let's start with some simple SLURM tutorial examples.

[Slurm examples](./examples/basic_slurm/README.md)

## 4. Now we can proceed to Nextflow examples that utilize Slurm.

[Nextflow examples](./examples/nextflow_slurm/README.md)
