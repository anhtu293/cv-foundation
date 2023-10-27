# cv-foundation
Personal repository for implementation and pre-training of lightweight feature extraction networks with many methods: image classification, self-supervised learning, semi-supervised learning.


# About project
Pretraining feature extraction networks is fundamental for all neural networks in computer vision. In addition to the classical image classification on Imagenet (or other large private datasets), many self-supervised learning methods have been researched recently.

Therefore, I have implement this repository to unify those methods in a pipeline that is easy to scale. Furthermore, I implement some state-of-the-art neural networks and my personal models.

 This repository focuses mainly on lightweight neural networks and pretraining them efficiently, which is not the case in many research projects. The models and pretrained weights will be used in my other personal projects, such as [nndepth](https://github.com/anhtu293/nndepth/tree/master) and more in the future.


# Working environment
- The easiest way is to use docker.
- Build docker image
```bash
docker build -t cv-foundation .
```
- Launch docker container
```bash
docker run  --gpus all --ipc host -e LOCAL_USER_ID=$(id -u)  -it --rm  -v MOUNT_YOUR_DISK  --privileged -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix cv-foundation
```
- Example
```bash
docker run  --gpus all --ipc host -e LOCAL_USER_ID=$(id -u)  -it --rm  -v /home/anhtu/workspace:/workspace -v /data:/data  --privileged -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix cv-foundation
```
The above command launch the docker container which mount `/home/anhtu/workspace` on host to `/workspace` inside the container and `/data` from host to `/data` inside the container.


# Roadmap
- [ ] Implement basic blocks: `datasets`, `blocks`, `extractors`
- [ ] `classification` training pipeline
- [ ] `constrastive_learning` pipeline
- [ ] JEPA pipeline: I-JEPA, MC-JEPA. For more info: [A Path Towards Autonomous Machine Intelligence](https://openreview.net/pdf?id=BZ5a1r-kVsf)
