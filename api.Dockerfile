FROM continuumio/miniconda3

WORKDIR /code

ARG api_dir=./src/server/api/fastapi_azure

#
COPY ${api_dir}/environment.yml /code/environment.yml

#
RUN conda env create -f /code/environment.yml
SHELL ["conda", "run", "--no-capture-output", "-n", "ifc-api", "/bin/bash", "-c"]


COPY ${api_dir}/app /code/app
COPY ${api_dir}/scripts /code/scripts
COPY ./src/core /code/core

ENV PYTHONPATH "${PYTHONPATH}:/code/core"

EXPOSE 8000
CMD ["conda", "run", "--no-capture-output", "-n", "ifc-api", "/bin/bash", "-c", "uvicorn app.main:app --host 0.0.0.0 --port 8000"]
