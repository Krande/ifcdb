env:
	conda env update --file environment.dev.yml --prune

docs-install:
	conda env create -f docs/environment.docs.yml

docs-update:
	conda env update --file docs/environment.docs.yml --prune

bdocs:
	activate ifcdb-docs && cd docs && make html

format:
	black . && isort . && flake8 .

build:
	docker build -t ifc-api/latest -f api.Dockerfile .

migrate:
	edgedb migration apply --credentials-file ./credentials.json --schema-dir ./src/server/schema/complete_in_steps/dbschema