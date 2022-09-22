FROM continuumio/miniconda3

WORKDIR /code

ARG poc_dir=./src/client/IfcDesignerBot

COPY ${poc_dir}/environment.yml /code/environment.yml

RUN conda env create -f /code/environment.yml

COPY ./core /code/