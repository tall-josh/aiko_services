ARG PYTHON_VERSION=3.10
FROM python:${PYTHON_VERSION}-slim

# git:
#  for installing aiko_services from a git repo not pip
# libmagic1 libgl1-mesa-glx libglib2.0-0: 
#  for opencv
RUN apt-get update && apt-get install -y \
    git \
    libmagic1 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /aiko_services

RUN pip install --upgrade pip && pip install pytest 

COPY ./dist/ /aiko_services/

# Pip install the wheel file with the highest version number
RUN WHEEL_FILE=$(ls ./aiko_services*.whl | tail -1) && \
    pip install ${WHEEL_FILE}

# Clean up
RUN rm -rf ./dist
