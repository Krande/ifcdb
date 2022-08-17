install:
	conda env create -f environment.yml

update:
	conda env update --file environment.yml --prune

build:
	docker build -t ifc-api/latest .

run:
	docker run -d --name ifc-api -p 5000:5000 --rm --env-file .env ifc-api/latest

test:
	docker run --name edgedb -d -p 5656:5656 -e EDGEDB_SERVER_SECURITY=insecure_dev_mode -e EDGEDB_SERVER_LOG_LEVEL=debug edgedb/edgedb