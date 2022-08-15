FROM continuumio/miniconda3

WORKDIR /code

#
COPY ./environment.yml /code/environment.yml

#
RUN conda env create -f /code/environment.yml
SHELL ["conda", "run", "--no-capture-output", "-n", "ifc-api", "/bin/bash", "-c"]

COPY ./app /code/app
COPY ./scripts /code/scripts
COPY ./config/schema /code/config/schema

EXPOSE 8000
CMD ["conda", "run", "--no-capture-output", "-n", "ifc-api", "/bin/bash", "-c", "./scripts/startup.sh"]
