
include .env

install:
	conda env create -f environment.yml

update:
	conda env update --file environment.yml --prune

web:
	conda activate ifcapi && uvicorn app.main:fast_api --port 5000 --reload

build:
	docker build -t ifc-api/latest .

run:
	docker run -d --name ifc-api -p 5000:5000 --rm --env-file .env ifc-api/latest

run2:
	uvicorn app.main:fast_api --reload