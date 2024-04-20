FROM pytorch/pytorch:2.1.2-cuda12.1-cudnn8-devel
ARG DEBIAN_FRONTEND=noninteractive

ENV  TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0 7.5 8.0 8.6+PTX" \
     SETUPTOOLS_USE_DISTUTILS=stdlib


# Install libraries in the brand new image. 
RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         build-essential \
         git \
         python3-opencv \
         ninja-build \
         ca-certificates


# Set the working directory for all the subsequent Dockerfile instructions.
WORKDIR /opt/program


ENV CUDA_HOME=/usr/local/cuda-12.1

COPY . .

RUN  python -m pip install -e .
    
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''"]
