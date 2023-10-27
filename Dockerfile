FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04

ARG pytorch=1.13.1
ARG torchvision=0.14.1
ARG torchaudio=0.13.1
ARG pytorch_lightning=1.9.3
ARG pycuda=cu117
ARG HOME=/home/cv

ENV TZ=Europe/Paris
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y  update; apt-get -y install sudo
RUN apt-get install -y build-essential nano git curl wget libgl1-mesa-glx gfortran
RUN apt-get install -y libglib2.0-0 python3-tk libqt5gui5 python3.10
RUN apt-get install -y python3-dev python3-distutils

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
# RUN update-alternatives --config python

RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3

# Create cv user
RUN useradd --create-home --uid 1000 --shell /bin/bash cv && usermod -aG sudo cv && echo "cv ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER cv
ENV HOME /home/cv
WORKDIR /home/cv

# Pytorch & pytorch lightning
RUN pip install torch==${pytorch}+${pycuda} torchvision==${torchvision}+${pycuda} torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/${pycuda}
RUN pip install pytorch_lightning==${pytorch_lightning}

COPY --chown=cv:cv requirements.txt /home/cv/install/requirements.txt
RUN pip install -r /home/cv/install/requirements.txt

USER root
COPY entrypoint.sh  /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
