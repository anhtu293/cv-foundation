FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04

ARG py=3.9
ARG pytorch=1.13.1
ARG torchvision=0.14.1
ARG torchaudio=0.13.1
ARG pytorch_lightning=1.9.3
ARG pycyda=11.7
ARG HOME=/home/cv

ENV TZ=Europe/Paris
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y  update; apt-get -y install sudo
RUN apt-get install -y build-essential nano git wget libgl1-mesa-glx

# Usefull for scipy & visualization inside docker container
RUN apt-get install -y gfortran  libglib2.0-0 python3-tk libqt5gui5

# Create cv user
RUN useradd --create-home --uid 1000 --shell /bin/bash cv && usermod -aG sudo cv && echo "cv ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV HOME /home/cv
WORKDIR /home/cv

# install miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    /bin/bash /tmp/miniconda.sh -b -p /opt/miniconda && \
    rm /tmp/miniconda.sh
ENV CONDA_HOME /opt/miniconda
ENV PATH ${CONDA_HOME}/condabin:${CONDA_HOME}/bin:${PATH}
RUN /bin/bash -c "source activate base"

# The following so that any user can install packages inside this Image
RUN chmod -R o+w /opt/miniconda && chmod -R o+w /home/cv

USER cv

# Pytorch & pytorch lightning
RUN conda install pytorch==${pytorch} torchvision==${torchvision} torchaudio==${torchaudio} pytorch-cuda=${pycuda} -c pytorch -c nvidia
RUN pip install pytorch_lightning==${pytorch_lightning}


COPY --chown=cv:cv requirements.txt /home/cv/install/requirements.txt
RUN pip install -r /home/cv/install/requirements.txt
COPY --chown=cv:cv  ./aloscene/utils /home/cv/install/utils

USER root
COPY entrypoint.sh  /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
