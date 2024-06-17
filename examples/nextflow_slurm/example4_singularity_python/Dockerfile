#-- * For MXNET version
FROM nvcr.io/nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04


LABEL Description="ICM-PRO MXNET with RIDE AND RIDGE for NVIDIA GPU"

LABEL Maintainer="Hovakim Grabski  hovakim.grabski@gmail.com or hgrabski@health.ucsd.edu"

#-- * Declare some ARGuments
ARG PYTHON_VERSION=3.7
ARG CONDA_VERSION=37
ARG CONDA_PY_VERSION=4.9.2
ARG username=i-am-curious

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install libraries inside the container shell
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  libgl1 \
  firefox \
  pymol \
  bash  \
  gawk \
  neofetch \
  locate \
  ncdu \
  less \
  nano \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  libtiff-dev \
  libjpeg-dev \
  libpng-dev \
  libglib2.0-0 \
  libxext6 \
  libsm6 \
  libxext-dev \
  libxrender1 \
  libzmq3-dev \
  libc6 \
  && rm -rf /var/lib/apt/lists/*


RUN apt update && apt install python3-pip -y   && rm -rf /var/lib/apt/lists/*
RUN pip install "pandas[performance]" toolz cytoolz click loguru fs  psutil gputil py-cpuinfo click