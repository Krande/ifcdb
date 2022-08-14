FROM continuumio/miniconda3

WORKDIR /code

#
COPY ./environment.yml /code/environment.yml

#
RUN conda env create -f /code/environment.yml
SHELL ["conda", "run", "--no-capture-output", "-n", "ifc-api", "/bin/bash", "-c"]

COPY ./app /code/app
COPY ./dbschema /code/dbschema
COPY ./edgedb.toml /code/edgedb.toml
COPY ./cert.pem /code/cert.pem

EXPOSE 5000
CMD ["conda", "run", "--no-capture-output", "-n", "ifc-api", "/bin/bash", "-c", "uvicorn app.main:fast_api --host 0.0.0.0 --port 5000"]
